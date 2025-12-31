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
    
    lazy var dialogLabel = TypewriterLabel(fontNamed: "Futura")
    
    lazy var button1 = attackButton(atackName: player.character.attacks[0].name,
                                    xPosition: 0.25,
                                    yPosition: 0.25,
                                    nodeName: "button1")
    
    lazy var button2 = attackButton(atackName: player.character.attacks[1].name,
                                    xPosition: 0.7,
                                    yPosition: 0.25,
                                    nodeName: "button2")
    
    lazy var button3 = attackButton(atackName: player.character.attacks[2].name,
                                    xPosition: 0.25,
                                    yPosition: 0.15,
                                    nodeName: "button3")
    
    lazy var button4 = attackButton(atackName: player.character.attacks[3].name,
                                    xPosition: 0.7,
                                    yPosition: 0.15,
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
        
        setButtonsActions()
        
        // Dialogo
        dialogLabel.fontSize = 16
        dialogLabel.fontColor = .white
        dialogLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        dialogLabel.numberOfLines = 1
        addChild(dialogLabel)
        
        dialogLabel.startTyping(text: "O que Steve vai fazer?", speed: 0.03)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touche = touches.first else { return }
        let location = touche.location(in: self)
        
        let touchedNode = self.atPoint(location)
//        print(touchedNode.name)
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
        let textureName = player.spriteName
        let texture = SKTexture(imageNamed: textureName)
        let enemyNode = SKSpriteNode(texture: texture)
        enemyNode.position = CGPoint(x: size.width * 0.8, y: size.height * 0.75)
        enemyNode.name = "enemy"
        enemyNode.size = CGSize(width: 64, height: 64)
        return enemyNode
    }
}

// Botoes de atack
extension GameScene {
    func attackButton(atackName: String, xPosition: CGFloat, yPosition: CGFloat, nodeName: String) -> AttackButton {
        let button = AttackButton(title: atackName)
        button.name = nodeName
        button.position = CGPoint(x: size.width * xPosition, y: size.height * yPosition)
        return button
    }
    
    func setButtonsActions() {
        button1.onTap = {
            self.player.character.attackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.attacks[0])
            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
            
            self.dialogLabel.startTyping(text: "Player: \(self.player.character.attacks[0].name)",
                                    speed: 0.03)
            self.enemyAtack()
        }
        
        button2.onTap = {
            self.player.character.attackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.attacks[1])
            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
            
            self.dialogLabel.startTyping(text: "Player: \(self.player.character.attacks[1].name)",
                                    speed: 0.03)
            self.enemyAtack()
        }
        
        button3.onTap = {
            self.player.character.attackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.attacks[2])
            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
            
            self.dialogLabel.startTyping(text: "Player: \(self.player.character.attacks[2].name)",
                                    speed: 0.03)
            self.enemyAtack()
        }
        
        button4.onTap = {
            self.player.character.attackPlayer(player: self.player,
                                              enemy: self.enemy,
                                              with: self.player.character.attacks[3])
            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
            
            self.dialogLabel.startTyping(text: "Player: \(self.player.character.attacks[3].name)",
                                    speed: 0.03)
            self.enemyAtack()
        }
    }
}

// Logica de teste para o inimigo te atacar
extension GameScene {
    func enemyAtack() {
        let random = Int.random(in: 0...3)
        let atack = enemy.character.attacks[random]

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dialogLabel.startTyping(text: "Inimigo: \(atack.name)", speed: 0.03)
            self.enemy.character.attackPlayer(player: self.enemy,
                                             enemy: self.player,
                                             with: atack)

            self.enemyInfo.atualizarVida(quantidade: self.enemy.health)
            self.playerInfo.atualizarVida(quantidade: self.player.health)
        }
    }
}
