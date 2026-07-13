//
//  CGRect+center.swift
//  Chronos
//

import Foundation


// MARK: CGRect

extension CGRect {

    // MARK: + center

    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

}
