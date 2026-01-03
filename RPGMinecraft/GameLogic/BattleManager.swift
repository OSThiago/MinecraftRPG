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
    
    // TODO: - Mudar para criar logica de atualizar vida e status na tela (renomar funcao)
    var turnEndAction: ((Int, Int) -> Void)?
    
    var dialogAction: ((String) async -> Void)?
    
    weak var BattleHud: BattleHud?
    
    init(player: Player, enemy: Player) {
        self.player = player
        self.enemy = enemy
    }
    
    func playerAttack(attackIndex: Int) {
        Task {
            let attack = player.character.attacks[attackIndex]
            
            player.character.attackPlayer(
                player: player,
                enemy: enemy,
                with: attack
            )
            
            BattleHud?.updatePlayerHeart(value: player.health)
            BattleHud?.updateEnemyHeart(value: enemy.health)
            
            isPlayerTurn = false
            BattleHud?.enableAttacks(isAnabled: false)
            
            await dialogAction?("\(player.character.name) usou \(attack.name)")
            
            await sleep(seconds: 2)
            enemyTurn()
        }
    }

    func enemyTurn() {
        Task {
            // 1. Processa o status assim que começa o turno
            await self.enemy.processStatusEffects()
            BattleHud?.updateEnemyHeart(value: enemy.health)
            
            // tempo antes de começar o ataque
            await sleep(seconds: 2)
            
            // 2. Começa o ataque
            let attack = enemy.character.attacks.randomElement()!
            await self.dialogAction?("\(self.enemy.character.name) usou \(attack.name)")
            
            self.enemy.character.attackPlayer(
                player: self.enemy,
                enemy: self.player,
                with: attack
            )
            // Finaliza o Ataque
            BattleHud?.updateEnemyHeart(value: enemy.health)
            BattleHud?.updatePlayerHeart(value: player.health)
            
            // 3. Começa o ataque do Player
            await sleep(seconds: 2)
            startPlayerTurn()
        }
    }
    
    func startPlayerTurn() {
        Task {
            // Processa o efeitos do Player
            await self.player.processStatusEffects()
            BattleHud?.updatePlayerHeart(value: player.health)

            self.isPlayerTurn = true

            BattleHud?.enableAttacks(isAnabled: true)
            
            await BattleHud?.updateDialog(text: "O que \(player.character.name) quer fazer?")
        }
    }
    
    func sleep(seconds: TimeInterval) async {
        try? await Task.sleep(
            nanoseconds: UInt64(seconds * 1_000_000_000)
        )
    }
}
