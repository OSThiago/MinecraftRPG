//
//  BattleHud.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

import SpriteKit

class BattleHud: SKNode {
    
    let dialogLabel = TypewriterLabel(fontNamed: "Futura")
    var attacks: [AttackButton] = []
    
    let playerStatus: CharacterStatusPanel
    let enemyStatus: CharacterStatusPanel
 
    var onAttackSelected: ((Int) ->Void)?
    
    init(player: Player, enemy: Player, sceneSize: CGSize) {
        
        playerStatus = CharacterStatusPanel(
            characterName: player.character.name,
            maxHealth: player.character.health,
            initialHealth: player.character.health,
            width: 160)
        
        enemyStatus = CharacterStatusPanel(
            characterName: enemy.character.name,
            maxHealth: enemy.character.health,
            initialHealth: enemy.character.health,
            width: 160
        )
        
        super.init()
        
        setupLayout(sceneSize: sceneSize)
        setupButtons(sceneSize: sceneSize,
                     atacks: player.character.attacks)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(sceneSize: CGSize) {
        // Barra de status
        playerStatus.position = CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.52)
        enemyStatus.position = CGPoint(x: sceneSize.width * 0.15, y: sceneSize.height * 0.77)
        
        // Texto de dialago
        dialogLabel.fontSize = 16
        dialogLabel.fontColor = .white
        dialogLabel.numberOfLines = 1
        dialogLabel.position = CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.3)
        
        addChild(playerStatus)
        addChild(enemyStatus)
        addChild(dialogLabel)
    }
    
    func setupButtons(sceneSize: CGSize, atacks: [Attack]) {
        let positions: [(x: CGFloat, y: CGFloat)] = [
            (0.25, 0.25),
            (0.7, 0.25),
            (0.25, 0.15),
            (0.7, 0.15)
        ]
        
        for (index, attack) in atacks.enumerated() {
            let button = AttackButton(attack: attack)
            let position = positions[index]
            button.position = CGPoint(
                x: sceneSize.width * position.x,
                y: sceneSize.height * position.y
            )
            
            button.onTap = {
                self.onAttackSelected?(index)
            }
            
            self.attacks.append(button)
            addChild(button)
        }
    }
    
    func updatePlayerHeart(value: Int) {
        playerStatus.setHealth(value)
    }
    
    func updateEnemyHeart(value: Int) {
        enemyStatus.setHealth(value)
    }
    
    func updateDialog(text: String) async {
        await dialogLabel.startTyping(text: text, speed: 0.03)
    }
    
    func enableAttacks(isAnabled: Bool) {
        for attack in attacks {
            attack.isUserInteractionEnabled = isAnabled
            attack.isHidden = !isAnabled
        }
    }
    
    func updateAttackRemaning(attack: Attack) {
        for attack in attacks {
            attack.updateQuantity(to: attack.attack.remainingAttacks)
        }
    }
    
    func resetAttacksButtons() {
        for attack in attacks {
            attack.reset()
        }
    }
}
