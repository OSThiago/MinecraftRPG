//
//  Zombie.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

import SpriteKit

class Zombie: Character {
    var health: Int = 15
    var name: String = "Zombie"
    var spriteName: String = "zombie"
    
    var attacks: [Attack] = [
        Attack(id: 0, name: "Morder Braço", amount: 2, quantity: 10),
        Attack(id: 1, name: "Morder Perna", amount: 3, quantity: 5),
        Attack(id: 2, name: "Morder Cabeça", amount: 4, quantity: 3),
        Attack(id: 3, name: "Comer Carne", amount: 5, quantity: 2)
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
            let damage = attacks[2].damage
            enemy.decreaseHealth(amount: damage)
        case 3:
            let life = attacks[3].damage
            player.increaseHealth(amount: life)
        default: break
        }
    }
}
