//
//  Steve.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 30/12/25.
//

import SpriteKit

class Atack {
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
    var atacks: [Atack] { get set }
    func atackPlayer(player: Player, enemy: Player, with: Atack)
}

class Steve: Character {
    var health: Int = 10
    var name: String = "Steve"
    var spriteName = "steve"
    
    var atacks: [Atack] = [
        Atack(name: "Ataque rapido", amount: 2, quantity: 10),
        Atack(name: "Critico", amount: 3, quantity: 5),
        Atack(name: "Encantar Espada", amount: 1, quantity: 2),
        Atack(name: "Pocao de cura", amount: 4, quantity: 2)
    ]

    // TODO: Adicionar logica para quantidade de ataques
    func atackPlayer(player: Player, enemy: Player, with atack: Atack) {
        switch atack.name {
        case atacks[0].name:
            let damage = atack.damage + atack.critical
            enemy.decreaseHealth(amount: damage)
        case atacks[1].name:
            let damage = atack.damage + atack.critical
            enemy.decreaseHealth(amount: damage)
        case atacks[2].name:
            atacks[0].increaseCritical(buffer: 1)
            atacks[1].increaseCritical(buffer: 2)
        case atacks[3].name:
            player.increaseHealth(amount: atack.damage)
        default: break
        }
        print("Usou: \(atack.name)")
    }
}
