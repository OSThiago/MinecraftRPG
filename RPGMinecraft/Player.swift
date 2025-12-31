//
//  PlayerNode.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 27/12/25.
//

import SpriteKit

class Player {
    
    var character: Character
    var spriteName: String
    var health: Int
    
    init(character: Character) {
        self.character = character
        self.health = character.health
        self.spriteName = character.spriteName
    }
    
    // Ataque
    func decreaseHealth(amount: Int) {
        let minHP = 0
        let result = health - amount
        if result < minHP {
            health = minHP
            return
        }
        health = result
    }
    
    // Cura
    func increaseHealth(amount: Int) {
        let maxHP = character.health
        let result = health + amount
        if result > maxHP {
            health = maxHP
            return
        }
        health = result
    }
}
