//
//  GameScene.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 23/12/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player(character: Steve())
    let enemy = Player(character: Steve())
    
    lazy var button1 = attackButton(atackName: player.character.atacks[0].name,
                                    width: 0.2,
                                    height: 0.25,
                                    nodeName: "button1")
    
    lazy var button2 = attackButton(atackName: player.character.atacks[1].name,
                                    width: 0.8,
                                    height: 0.25,
                                    nodeName: "button2")
    
    lazy var button3 = attackButton(atackName: player.character.atacks[2].name,
                                    width: 0.2,
                                    height: 0.15,
                                    nodeName: "button3")
    
    lazy var button4 = attackButton(atackName: player.character.atacks[3].name,
                                    width: 0.8,
                                    height: 0.15,
                                    nodeName: "button4")
    
    lazy var playerNode = addPlayerNode()
    lazy var enemyNode = addEnemyNode()
    
    lazy var playerInfo = QuadroPersonagem(nome: "Player")
    lazy var enemyInfo = QuadroPersonagem(nome: "Enemy")
    
    override func didMove(to view: SKView) {
        
        // Nodes
        addChild(playerNode)
        addChild(enemyNode)
        // Infos
        playerInfo.position = CGPoint(x: size.width * 0.7, y: size.height * 0.5)
        enemyInfo.position = CGPoint(x: size.width * 0.3, y: size.height * 0.75)
        addChild(playerInfo)
        addChild(enemyInfo)
        
        // Buttons
        addChild(button1)
        addChild(button2)
        addChild(button3)
        addChild(button4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touche = touches.first else { return }
        let location = touche.location(in: self)
        
        let touchedNode = self.atPoint(location)
        
        switch touchedNode.name {
        case "button1":
            self.player.character.atackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.atacks[0])
            enemyAtack()
        case "button2":
            self.player.character.atackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.atacks[1])
            enemyAtack()
        case "button3":
            self.player.character.atackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.atacks[2])
            enemyAtack()
        case "button4":
            self.player.character.atackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.atacks[3])
            enemyAtack()
        default: return
        }
        enemyInfo.atualizarVida(quantidade: enemy.health)
        playerInfo.atualizarVida(quantidade: player.health)
    }
}

extension GameScene {
    func addPlayerNode() -> SKSpriteNode {
        let textureName = player.spriteName
        let texture = SKTexture(imageNamed: textureName)
        let playerNode = SKSpriteNode(texture: texture)
        playerNode.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        playerNode.name = "player"
        return playerNode
    }
    
    func addEnemyNode() -> SKSpriteNode{
        let textureName = player.spriteName
        let texture = SKTexture(imageNamed: textureName)
        let enemyNode = SKSpriteNode(texture: texture)
        enemyNode.position = CGPoint(x: size.width * 0.8, y: size.height * 0.75)
        enemyNode.name = "enemy"
        return enemyNode
    }
    
    func attackButton(atackName: String, width: CGFloat, height: CGFloat, nodeName: String) -> SKLabelNode {
        let label = SKLabelNode(text: atackName)
        label.fontSize = 24
        label.position = CGPoint(x: size.width * width, y: size.height * height)
        label.name = nodeName
        return label
    }
}

// Logica de teste para o inimigo te atacar
extension GameScene {
    func enemyAtack() {
        let random = Int.random(in: 0...3)
        let atack = enemy.character.atacks[random]
        
        print("Inimigo vai atacar!!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.enemy.character.atackPlayer(player: self.enemy,
                                             enemy: self.player,
                                             with: atack)

            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
        }
    }
}
