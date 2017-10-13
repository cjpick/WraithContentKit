//
//  ContentViewModel.swift
//  WraithGrid
//
//  Created by Christopher Pick on 6/6/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import Foundation

public protocol ContentViewModel {
    
    var contents: [ContentElementType] { get }
    var title: String { get }
    var viewStyle: Style { get }
    
}
