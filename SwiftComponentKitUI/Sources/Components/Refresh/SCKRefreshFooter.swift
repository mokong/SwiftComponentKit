//
//  SCKRefreshFooter.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 上拉加载底部
public class SCKRefreshFooter: UIView {
    /// 加载状态
    public enum LoadState {
        case idle          // 闲置
        case loading       // 加载中
        case noMoreData    // 没有更多数据
    }
    
    /// 加载回调
    public var loadBlock: (() -> Void)?
    
    /// 当前状态
    public private(set) var state: LoadState = .idle {
        didSet {
            updateUI()
        }
    }
    
    /// 加载视图（可自定义）
    public var loadView: UIView? {
        didSet {
            setupLoadView()
        }
    }
    
    /// 是否正在加载
    public var isLoading: Bool {
        return state == .loading
    }
    
    /// 是否没有更多数据
    public var isNoMoreData: Bool {
        return state == .noMoreData
    }
    
    private weak var scrollView: UIScrollView?
    private var originalContentInsetBottom: CGFloat = 0
    private let loadHeight: CGFloat = 60
    
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
        
        // 默认加载视图
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = false
        loadView = indicator
        
        setupLoadView()
    }
    
    private func setupLoadView() {
        subviews.forEach { $0.removeFromSuperview() }
        
        if let loadView = loadView {
            addSubview(loadView)
            loadView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadView.centerXAnchor.constraint(equalTo: centerXAnchor),
                loadView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
    
    // MARK: - Public Methods
    
    /// 添加到滚动视图
    /// - Parameter scrollView: 滚动视图
    public func add(to scrollView: UIScrollView) {
        self.scrollView = scrollView
        originalContentInsetBottom = scrollView.contentInset.bottom
        scrollView.addSubview(self)
        
        // 监听滚动
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
        scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
    }
    
    /// 开始加载
    public func beginLoading() {
        guard state != .loading && state != .noMoreData else { return }
        
        state = .loading
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.bottom = self.originalContentInsetBottom + self.loadHeight
        }
        
        loadBlock?()
    }
    
    /// 结束加载
    public func endLoading() {
        guard state == .loading else { return }
        
        state = .idle
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.bottom = self.originalContentInsetBottom
        }
    }
    
    /// 设置没有更多数据
    public func setNoMoreData() {
        state = .noMoreData
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.bottom = self.originalContentInsetBottom
        }
    }
    
    /// 重置状态
    public func reset() {
        state = .idle
        
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.bottom = self.originalContentInsetBottom
        }
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        switch state {
        case .idle:
            if let indicator = loadView as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
            isHidden = false
        case .loading:
            if let indicator = loadView as? UIActivityIndicatorView {
                indicator.startAnimating()
            }
            isHidden = false
        case .noMoreData:
            if let indicator = loadView as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
            isHidden = true
        }
    }
    
    private func updateFrame() {
        guard let scrollView = scrollView else { return }
        
        let contentHeight = scrollView.contentSize.height
        let scrollHeight = scrollView.bounds.height
        let contentInsetTop = scrollView.contentInset.top
        let contentInsetBottom = scrollView.contentInset.bottom
        
        let y = max(contentHeight + contentInsetTop, scrollHeight - contentInsetBottom)
        frame = CGRect(x: 0, y: y, width: scrollView.bounds.width, height: loadHeight)
    }
    
    // MARK: - KVO
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = scrollView else { return }
        
        if keyPath == "contentSize" {
            updateFrame()
        } else if keyPath == "contentOffset" {
            updateFrame()
            
            if state == .loading || state == .noMoreData {
                return
            }
            
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollHeight = scrollView.bounds.height
            let contentInsetTop = scrollView.contentInset.top
            let contentInsetBottom = scrollView.contentInset.bottom
            
            // 计算是否到达底部
            let threshold = contentHeight + contentInsetTop + contentInsetBottom - scrollHeight
            
            if offsetY >= threshold - 10 && !scrollView.isDragging {
                beginLoading()
            }
        }
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
        scrollView?.removeObserver(self, forKeyPath: "contentSize")
    }
}

