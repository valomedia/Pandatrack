//
//  CGRect+center.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: CGRect

extension CGRect {

    // MARK: + center

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

}