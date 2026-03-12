//
//  Enderman.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 21/02/26.
//

import SpriteKit

class Enderman: Character {
    var health = 20
    var name = "Enderman"
    var spriteName = "enderman"
    
    var attacks: [Attack] = [
        Attack(id: 0, name: "Ataque simples", amount: 2, quantity: 10),
        Attack(id: 1, name: "Ataque pelas costas", amount: 5, quantity: 5),
        Attack(id: 2, name: "Teletransportar", amount: 20, quantity: 3),
        Attack(id: 3, name: "Roubar", amount: 2, quantity: 3)
    ]
    
    func attackPlayer(player: Player, enemy: Player, with attack: Attack) {
        switch attack.id {
        case 0:
            let damage = attacks[0].damage
            enemy.decreaseHealth(amount: damage)
        case 1:
            let damage = attacks[1].damage
            enemy.decreaseHealth(amount: damage)
        case 2:
            teleportMove(player: player)
        case 3:
            stealMove(enemy: enemy, stealQuantity: 2)
        default: break
        }
    }
    
    func teleportMove(player: Player) {
        if player.statusEffects.contains(where: { $0.type == .invisibility }) {
            var effect = player.statusEffects.first(where: { $0.type == .invisibility })
            guard let accuracy = effect as? Invisibility else {
                print("Error: teleportMove")
                return
            }
            accuracy.setRemainingTurns(to: 3)
            accuracy.upPercentage(value: 30)
            // Pega o já existente e aplica mais efeito
            print("Debug: Aumentando a porcentagem de teloport para: \(accuracy.accuracyPercentage)%")
            return
        }
        
        print("Debug: Criando teleport com porcentagem de: 40%")
        // Se não tiver efeito ainda cria um novo
        player.addStatusEffects(effect: Invisibility(turns: 3, percentage: 40))
    }
    
    func stealMove(enemy: Player, stealQuantity: Int) {
        let random = Int.random(in: 0..<3)
        enemy.character.attacks[random].decraseAttacksRemaining(quantity: stealQuantity)
        let attackName = enemy.character.attacks[random].name
        print("Debug: Roubando \(stealQuantity) ataques: \(attackName)")
        enemy.character.attacks[random].setAttackdialog("\(enemy.character.name) roubou \(attackName) | Quantidade: \(stealQuantity)")
    }
}
