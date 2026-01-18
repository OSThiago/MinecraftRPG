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
    var statusEffects: [StatusEffect] = []
    
    weak var battleHud: BattleHud?
    
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
    
    // Efeitos
    func addStatusEffects(effect: StatusEffect) {
        self.statusEffects.append(effect)
    }
    
    func processStatusEffects() async {
        for status in statusEffects {
            status.onTurnStart(player: self)
            await displayStatus(status: status)
            await sleep(seconds: 2)
        }
        
        statusEffects.removeAll { $0.remainingTurns <= 0 }
    }
    
    private func displayStatus(status: StatusEffect) async {
        guard let battleHud else { return }
        switch status.type {
        case .poison:
            await battleHud.updateDialog(text: "\(character.name) esta envenado")
        default: break
        }
    }
    
    private func sleep(seconds: TimeInterval) async {
        try? await Task.sleep(
            nanoseconds: UInt64(seconds * 1_000_000_000)
        )
    }
}

// Logica para resetar todo os status do Player
extension Player {
    func reset() {
        statusEffects.removeAll()
        self.health = character.health
    }
}
