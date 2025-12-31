//
//  Steve.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 30/12/25.
//

import SpriteKit

class Attack {
    let name: String
    let damage: Int
    var critical: Int = 0
    let quantity: Int
    
    init(name: String, amount: Int, quantity: Int) {
        self.name = name
        self.damage = amount
        self.quantity = quantity
    }
    
    func increaseCritical(buffer: Int) {
        critical += buffer
    }
}

protocol Character {
    var health: Int { get set }
    var name: String { get set }
    var spriteName: String { get set }
    var attacks: [Attack] { get set }
    func attackPlayer(player: Player, enemy: Player, with: Attack)
}

class Steve: Character {
    var health: Int = 10
    var name: String = "Steve"
    var spriteName = "steve"
    
    var attacks: [Attack] = [
        Attack(name: "Ataque rapido", amount: 2, quantity: 10),
        Attack(name: "Critico", amount: 3, quantity: 5),
        Attack(name: "Encantar Espada", amount: 1, quantity: 2),
        Attack(name: "Pocao de cura", amount: 4, quantity: 2)
    ]

    // TODO: Adicionar logica para quantidade de ataques
    func attackPlayer(player: Player, enemy: Player, with atack: Attack) {
        switch atack.name {
        case attacks[0].name:
            let damage = atack.damage + atack.critical
            enemy.decreaseHealth(amount: damage)
        case attacks[1].name:
            let damage = atack.damage + atack.critical
            enemy.decreaseHealth(amount: damage)
        case attacks[2].name:
            attacks[0].increaseCritical(buffer: 1)
            attacks[1].increaseCritical(buffer: 2)
        case attacks[3].name:
            player.increaseHealth(amount: atack.damage)
        default: break
        }
    }
}
