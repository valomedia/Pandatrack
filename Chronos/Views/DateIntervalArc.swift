//
//  DateIntervalArc.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import SwiftUI


// MARK: DateIntervalArc

/// Undocumented.
///
/// - Todo: Document.
///
struct DateIntervalArc: Shape {

    // MARK: - Static properties

    private let gap = 2.0

    // MARK: - Static methods

    // MARK: - Life cycle methods

    /// Draw an arc from two intervals.
    ///
    /// - Parameters:
    ///     - arcInterval: The interval to draw the arc for.
    ///     - containingInterval: The interval to draw the arc in.
    ///     - lineWidth: The width for the stroke of the arc.
    ///
    init(interval arcInterval: DateInterval, in containingInterval: DateInterval, lineWidth: Double) {
        let degreesPerSecond = 360.0 / containingInterval.duration
        start = Angle(
                degrees: degreesPerSecond
                        * DateInterval(start: containingInterval.start, end: arcInterval.start).duration
                        + gap
                        / 2.0)
        angle = Angle(degrees: degreesPerSecond * arcInterval.duration - gap / 2.0)
        width = lineWidth
    }

    // MARK: - Properties

    private let start: Angle
    private let angle: Angle
    private let width: Double

    // MARK: - Methods

    func path(in rect: CGRect) -> Path {
        let d = min(rect.size.width, rect.size.height) - width
        let r = d / 2.0
        return Path { path in
            if angle.degrees > gap * 2.0 {
                path.addArc(
                        center: rect.center,
                        radius: r,
                        startAngle: start,
                        endAngle: start + angle,
                        clockwise: false)
            }
        }
    }
}
