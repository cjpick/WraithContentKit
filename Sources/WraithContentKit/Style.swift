//
//  Style.swift
//  WraithContentKitPackageDescription
//
//  Created by Christopher Pick on 10/13/17.
//

import Foundation
import UIKit

public protocol Style {
    
    var backgroundColor: UIColor { get }
    var font: UIFont { get }
    var textAlignment: NSTextAlignment { get }
    var textColor: UIColor { get }
    
}
