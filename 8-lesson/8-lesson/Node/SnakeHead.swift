//
//  SnakeHead.swift
//  8-lesson
//
//  Created by Denis Dmitriev on 08.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
