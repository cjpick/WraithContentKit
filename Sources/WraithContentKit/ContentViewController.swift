//
//  ContentViewController.swift
//  WraithGrid
//
//  Created by Christopher Pick on 6/6/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import UIKit

public class ContentViewController: UIViewController {
    
    // MARK: - Public Properties
    
    fileprivate var contentViewModel: ContentViewModel
    
    // MARK: - Private Properties
    
    fileprivate let stackView = UIStackView()
    
    // MARK: - Init/Deinit
    
    public init(_ contents:ContentViewModel) {
        self.contentViewModel = contents
        super.init(nibName: nil, bundle: nil)
        title = contentViewModel.title
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Overrides
    
    override public func loadView() {
        view = UIView()
        view.backgroundColor = contentViewModel.viewStyle.backgroundColor
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height ?? 0)).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        loadStackView()
    }
    
    fileprivate func loadStackView() {
        stackView.subviews.forEach{ $0.removeFromSuperview() }
        contentViewModel.contents.forEach { stackView.addArrangedSubview($0.view) }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(userChangedTextSize(notification:)), name: NSNotification.Name.UIContentSizeCategoryDidChange,object: nil)
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Actions
    // MARK: - Private Actions
    
    @objc func userChangedTextSize(notification: Notification) {
        loadStackView()
    }
}
