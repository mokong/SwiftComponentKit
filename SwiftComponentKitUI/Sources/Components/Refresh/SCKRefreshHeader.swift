//
//  SCKRefreshHeader.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 下拉刷新头部
public class SCKRefreshHeader: UIView {
    /// 刷新状态
    public enum RefreshState {
        case idle          // 闲置
        case pulling       // 拖拽中
        case refreshing    // 刷新中
        case willRefresh   // 即将刷新
    }
    
    /// 刷新回调
    public var refreshBlock: (() -> Void)?
    
    /// 当前状态
    public private(set) var state: RefreshState = .idle {
        didSet {
            updateUI()
        }
    }
    
    /// 刷新视图（可自定义）
    public var refreshView: UIView? {
        didSet {
            setupRefreshView()
        }
    }
    
    /// 是否正在刷新
    public var isRefreshing: Bool {
        return state == .refreshing
    }
    
    private weak var scrollView: UIScrollView?
    private var originalContentInsetTop: CGFloat = 0
    private let refreshHeight: CGFloat = 60
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .clear
        frame = CGRect(x: 0, y: -refreshHeight, width: UIScreen.main.bounds.width, height: refreshHeight)
        
        // 默认刷新视图
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = false
        refreshView = indicator
        
        setupRefreshView()
    }
    
    private func setupRefreshView() {
        subviews.forEach { $0.removeFromSuperview() }
        
        if let refreshView = refreshView {
            addSubview(refreshView)
            refreshView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refreshView.centerXAnchor.constraint(equalTo: centerXAnchor),
                refreshView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
    
    // MARK: - Public Methods
    
    /// 添加到滚动视图
    /// - Parameter scrollView: 滚动视图
    public func add(to scrollView: UIScrollView) {
        self.scrollView = scrollView
        originalContentInsetTop = scrollView.contentInset.top
        scrollView.addSubview(self)
        
        // 监听滚动
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
    }
    
    /// 开始刷新
    public func beginRefreshing() {
        guard state != .refreshing else { return }
        
        state = .refreshing
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.top = self.originalContentInsetTop + self.refreshHeight
            scrollView.contentOffset.y = -scrollView.contentInset.top
        }
        
        refreshBlock?()
    }
    
    /// 结束刷新
    public func endRefreshing() {
        guard state == .refreshing else { return }
        
        state = .idle
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.top = self.originalContentInsetTop
        }
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        switch state {
        case .idle:
            if let indicator = refreshView as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
        case .pulling:
            if let indicator = refreshView as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
        case .refreshing:
            if let indicator = refreshView as? UIActivityIndicatorView {
                indicator.startAnimating()
            }
        case .willRefresh:
            break
        }
    }
    
    // MARK: - KVO
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset", let scrollView = scrollView else { return }
        
        let offsetY = scrollView.contentOffset.y
        let insetTop = scrollView.contentInset.top
        
        if state == .refreshing {
            return
        }
        
        if offsetY <= -insetTop - refreshHeight {
            if state == .idle {
                state = .pulling
            }
        } else if offsetY <= -insetTop {
            if state == .pulling {
                state = .idle
            }
        }
        
        // 松手时开始刷新
        if scrollView.isDragging == false && state == .pulling {
            beginRefreshing()
        }
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
}

