//
//  GameScene.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 23/12/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        // Your setup code here
        let label = SKLabelNode(text: "SpriteKit without SKS file")
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }
}
