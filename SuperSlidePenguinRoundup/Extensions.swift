//
//  Extensions.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-06.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTexture {
    convenience init(pixelImageNamed: String) {
        self.init(imageNamed: pixelImageNamed)
        self.filteringMode = .nearest
    }
}
