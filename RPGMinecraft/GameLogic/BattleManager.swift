//
//  BattleManager.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

import SpriteKit

class BattleManager {
    let player: Player
    let enemy: Player
    
    var isPlayerTurn = true
    
    var turnEndAction: ((Int, Int) -> Void)?
    var dialogAction: ((String) -> Void)?
    
    init(player: Player, enemy: Player) {
        self.player = player
        self.enemy = enemy
    }
    
    // Adicionar update de UI
    func playerAttack(attackIndex: Int) {
        let attack = player.character.attacks[attackIndex]
        
        player.character.attackPlayer(
            player: player,
            enemy: enemy,
            with: attack
        )
        
        isPlayerTurn = false
        dialogAction?("Player: \(player.character.name) usou \(attack.name)")
        turnEndAction?(player.health, enemy.health)
        enemyTurn()
    }
    
    // Adicionar update de UI
    func enemyTurn() {
        let attack = enemy.character.attacks.randomElement()!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.enemy.character.attackPlayer(
                player: self.enemy,
                enemy: self.player,
                with: attack
            )
         
            self.dialogAction?("Enemy: \(self.enemy.character.name) usou \(attack.name)")
            self.isPlayerTurn = true
            self.turnEndAction?(self.player.health, self.enemy.health)
        }
    }
}
