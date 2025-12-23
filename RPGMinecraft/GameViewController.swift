//
//  GameViewController.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 23/12/25.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let skView = self.view as? SKView {
            let scene = GameScene(size: skView.bounds.size)
            scene.scaleMode = .resizeFill

            skView.presentScene(scene)

            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
