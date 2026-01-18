//
//  GameScene.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 23/12/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player(character: Witch())
    let enemy = Player(character: Zombie())
    
    lazy var battleManager = BattleManager(player: player, enemy: enemy)
    lazy var battleHud = BattleHud(player: player, enemy: enemy, sceneSize: size)
    
    override func didMove(to view: SKView) {
        addChild(battleHud)
        configureBattle()
        
        let playerNode = addPlayerNode()
        let enemyNode = addEnemyNode()
        
        player.battleHud = self.battleHud
        enemy.battleHud = self.battleHud
        battleManager.BattleHud = self.battleHud
        
        addChild(playerNode)
        addChild(enemyNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touche = touches.first else { return }
//        let location = touche.location(in: self)
        
//        let touchedNode = self.atPoint(location)
//        print(touchedNode.name)
    }
    
    private func configureBattle() {
        
        battleHud.onAttackSelected = { index in
            self.battleManager.playerAttack(attackIndex: index)
        }
        
        battleManager.turnEndAction = { playerHeart, enemyHeart in
            self.battleHud.updatePlayerHeart(value: playerHeart)
            self.battleHud.updateEnemyHeart(value: enemyHeart)
            self.battleHud.enableAttacks(isAnabled: self.battleManager.isPlayerTurn)
        }
        
        battleManager.dialogAction = { dialog in
            Task {
                await self.battleHud.updateDialog(text: dialog)
            }
        }
    }
}


extension GameScene {
    func addPlayerNode() -> SKSpriteNode {
        let textureName = player.spriteName
        let texture = SKTexture(imageNamed: textureName)
        let playerNode = SKSpriteNode(texture: texture)
        playerNode.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        playerNode.name = "player"
        playerNode.size = CGSize(width: 64, height: 64)
        return playerNode
    }
    
    func addEnemyNode() -> SKSpriteNode{
        let textureName = enemy.spriteName
        let texture = SKTexture(imageNamed: textureName)
        let enemyNode = SKSpriteNode(texture: texture)
        enemyNode.position = CGPoint(x: size.width * 0.8, y: size.height * 0.75)
        enemyNode.name = "enemy"
        enemyNode.size = CGSize(width: 64, height: 64)
        return enemyNode
    }
}
