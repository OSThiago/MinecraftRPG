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
        
        var damage = amount
        
        if statusEffects.contains(where: { $0.type == .accuracy }) {
            print("Debug: Entrou no if de conter accuracy")
            damage = self.applyAccuracy(damage: amount)
            print("Debug: Dano original: \(amount) | Dano final: \(damage)")
        }
        
        let result = health - damage
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
        for atack in character.attacks {
            atack.resetAttacksRemaining()
        }
    }
}

// Accuracy
extension Player {
    /// Efeito para diminuir a precisão
    /// - Parameter damage: Dano original
    /// - Returns: Novo Dano com precisão baixa
    func applyAccuracy(damage: Int) -> Int {
        if statusEffects.contains(where: { $0.type == .accuracy }) {
            let effect = statusEffects.first(where: { $0.type == .accuracy })
            guard let accuracy = effect as? Accuracy else { return damage }
            let newDamage = accuracy.calculateDamage(damage: damage)
            return newDamage
        }
        return damage
    }
}
