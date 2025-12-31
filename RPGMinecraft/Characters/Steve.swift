//
//  Steve.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 30/12/25.
//

import SpriteKit

class Steve: Character {
    var health: Int = 10
    var name: String = "Steve"
    var spriteName = "steve"
    
    var attacks: [Attack] = [
        Attack(id: 0, name: "Ataque rapido", amount: 2, quantity: 10),
        Attack(id: 1, name: "Critico", amount: 3, quantity: 5),
        Attack(id: 2, name: "Encantar Espada", amount: 1, quantity: 2),
        Attack(id: 3, name: "Pocao de cura", amount: 4, quantity: 2)
    ]

    // TODO: Adicionar logica para quantidade de ataques
    func attackPlayer(player: Player, enemy: Player, with attack: Attack) {
        switch attack.name {
        case attacks[0].name:
            let damage = attack.damage + attack.critical
            enemy.decreaseHealth(amount: damage)
        case attacks[1].name:
            let damage = attack.damage + attack.critical
            enemy.decreaseHealth(amount: damage)
        case attacks[2].name:
            attacks[0].increaseCritical(buffer: 1)
            attacks[1].increaseCritical(buffer: 2)
        case attacks[3].name:
            player.increaseHealth(amount: attack.damage)
        default: break
        }
    }
}
