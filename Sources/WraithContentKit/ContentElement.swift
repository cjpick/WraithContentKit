//
//  ContentElement.swift
//  WraithGrid
//
//  Created by Christopher Pick on 6/6/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import UIKit

public protocol ContentElementType {
    /// Should be a function sense it can be a new view when called?
    var view: UIView { get }
}

public struct CustomContentElement: ContentElementType {
    
    public var view: UIView { return _view }
    
    private var _view: UIView
    
    init(_ view: UIView) {
        self._view = view
    }
}

public struct ContentElement<Type>: ContentElementType where Type: UIView {
    
    public var view: UIView {
        let view = Type()
        setup(view)
        return view
    }
    
    fileprivate let setup: (Type)->Void
    
    
    public init(viewStyle: Style, setup: @escaping (Type)->Void = { _ in }) {
        self.setup = { view in
            view.backgroundColor = viewStyle.backgroundColor
            setup(view)
        }
    }
}

public extension ContentElement where Type: UIStackView {
    
    public init(axis: UILayoutConstraintAxis = .vertical, spacing: CGFloat = 20, distribution: UIStackViewDistribution = .fill, content: [ContentElementType], setup: @escaping (Type)->Void = { _ in }) {
        self.setup = { stack in
            stack.axis = axis
            stack.spacing = spacing
            stack.distribution = distribution
            for element in content {
                stack.addArrangedSubview(element.view)
            }
            setup(stack)
        }
    }
}

public extension ContentElement where Type: UITextField {
    
    public init(textField: String = "", setup: @escaping (Type)->Void = { _ in }) {
        self.setup = { field in
            field.borderStyle = .line
            field.text = textField
            setup(field)
        }
    }
}

public extension ContentElement where Type: UILabel {
    
    public init(label: String, style: UIFontTextStyle = .body, alignment: NSTextAlignment = .left, setup: @escaping (UILabel) -> Void = { _ in }) {
        self.setup = { view in
            view.font = UIFont.preferredFont(forTextStyle: style)
            view.textAlignment = alignment
            view.numberOfLines = 0
            view.text = label
            setup(view)
        }
    }
    
    public init(textLabel: String, style: Style, setup: @escaping (UILabel) -> Void = { _ in }) {
        self.setup = { view in
            view.text = textLabel
            view.font = style.font
            view.textAlignment = style.textAlignment
            view.textColor = style.textColor
            view.backgroundColor = style.backgroundColor
            
            setup(view)
        }
    }
}

public extension ContentElement where Type: UISegmentedControl {
    
    public init(segment: Int = 0, segments: [String], setup: @escaping (UISegmentedControl) -> Void = { _ in }) {
        self.setup = { segmentControl in
            segments.forEach{ segmentControl.insertSegment(withTitle: $0, at: segmentControl.numberOfSegments, animated: false)}
            segmentControl.selectedSegmentIndex = segment
            setup(segmentControl)
        }
    }
}

public extension ContentElement where Type: UIButton {
    
    public init(buttonTitle: String? = nil, action: @escaping ()->Void = {}, setup: @escaping (UIButton) -> Void = { _ in }) {
        self.setup = { button in
            button.setTitle(buttonTitle, for: .normal)
            setup(button)
        }
    }
}
