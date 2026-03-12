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
    
    // TODO: - Mudar para criar logica de atualizar vida e status na tela (renomear funcao)
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
            
            attack.decraseAttacksRemaining(quantity: 1)
            BattleHud?.updateAttackRemaning(attack: attack)
            
            print("Debug: quantidade de ataques do \(attack.name): \(attack.remainingAttacks)")
            
            BattleHud?.updatePlayerHeart(value: player.health)
            BattleHud?.updateEnemyHeart(value: enemy.health)
            
            isPlayerTurn = false
            BattleHud?.enableAttacks(isAnabled: false)
            
//            await dialogAction?("\(player.character.name) usou \(attack.name)")
            await dialogAction?("\(attack.attackDiolog)")
            
            attack.setAttackdialog("")
            
            await sleep(seconds: 2)
            
            if checkIsEnd() {
                await endGame()
                return
            }
            
            startEnemyTurn()
        }
    }

    func startEnemyTurn() {
        Task {
            // 1. Processa o status assim que começa o turno
            await self.enemy.processStatusEffects()
            BattleHud?.updateStatusEffectPanel(playerStatus: player.statusEffects,
                                               enemyStatus: enemy.statusEffects)
            BattleHud?.updateEnemyHeart(value: enemy.health)
            
            
            if checkIsEnd() {
                await endGame()
                return
            }
            
            // tempo antes de começar o ataque
            await sleep(seconds: 2)
            
            // 2. Começa o ataque
            var attack = enemy.character.attacks.randomElement()!
            
            while attack.remainingAttacks <= 0 {
                print("Debug: trocando de ataque pois o selecionado não está habilitado")
                attack = enemy.character.attacks.randomElement()!
            }
            
            await self.dialogAction?("\(self.enemy.character.name) usou \(attack.name)")
            
            self.enemy.character.attackPlayer(
                player: self.enemy,
                enemy: self.player,
                with: attack
            )
            
            attack.decraseAttacksRemaining(quantity: 1)
            BattleHud?.updateAttackRemaning(attack: attack)
            
            print("Debug: quantidade de ataques do \(attack.name): \(attack.remainingAttacks)")
            
            
            // Finaliza o Ataque
            BattleHud?.updateEnemyHeart(value: enemy.health)
            BattleHud?.updatePlayerHeart(value: player.health)
            
            if checkIsEnd() {
                await endGame()
                return
            }
            
            // 3. Começa o ataque do Player
            await sleep(seconds: 2)
            startPlayerTurn()
        }
    }
    
    func startPlayerTurn() {
        Task {
            // Processa o efeitos do Player
            await self.player.processStatusEffects()
            BattleHud?.updateStatusEffectPanel(playerStatus: player.statusEffects,
                                               enemyStatus: enemy.statusEffects)
            BattleHud?.updatePlayerHeart(value: player.health)

            if checkIsEnd() {
                await endGame()
                return
            }
            
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

// Resetar o game
extension BattleManager {
    func checkIsEnd() -> Bool {
        return player.health <= 0 || enemy.health <= 0
    }

    func endGame() async {
        await sleep(seconds: 3)
        
        BattleHud?.enableAttacks(isAnabled: false)
        if player.health <= 0 {
            print("Inimigo ganhou")
            await BattleHud?.updateDialog(text: "\(enemy.character.name) ganhou!!")
        }

        if enemy.health <= 0 {
            print("Player ganhou")
            await BattleHud?.updateDialog(text: "\(player.character.name) ganhou!!")
        }
        
        await sleep(seconds: 3)
        player.reset()
        enemy.reset()
        BattleHud?.resetAttacksButtons()
        BattleHud?.updateEnemyHeart(value: enemy.health)
        BattleHud?.updatePlayerHeart(value: player.health)

        startPlayerTurn()
    }
}
