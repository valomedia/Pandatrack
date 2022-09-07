//
//  AVPlayer+ding.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import AVFoundation


// MARK: AVPlayer

// MARK: + ding

extension AVPlayer {

    /// An AVPlayer for a clear sound of a bell.
    ///
    /// - Copyright: Asset by Aiwha, see ACKNOWLEDGEMENTS.txt for more information.
    ///
    static let ding: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find source file.")
        }
        return AVPlayer(url: url)
    }()
}
