//
//  Accuracy.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 18/01/26.
//

class Accuracy: StatusEffect {
    var type: StatusEffectType = .accuracy
    var remainingTurns: Int
    
    var accuracyPercentage: Int = 0
    
    init(turns: Int, percentage: Int) {
        self.remainingTurns = turns
        self.upPercentage(value: percentage)
    }
    
    func onTurnStart(player: Player) {
        remainingTurns -= 1
        downPercentage(value: 10)
        // Adicionar logica para o inimigo dar menos dano
    }
    
    func upPercentage(value: Int) {
        let maxPercentage = 80
        var result = accuracyPercentage + value
        if result < maxPercentage {
            result = maxPercentage
        }
        self.accuracyPercentage = result
    }
    
    func downPercentage(value: Int) {
        let minPercentage = 0
        var result = self.accuracyPercentage - value
        if result < minPercentage {
            result = minPercentage
        }
        self.accuracyPercentage = result
    }
    
    func calculateDamage(damage: Int) -> Int {
        // Por enquanto faremos ele errar o ataque, futuramente fazer ele também diminuir o dano caso não erre o ataque
        let maxAccuracy = 100
    
        let chanceAttack = Int.random(in: 0...maxAccuracy)
        
        print("Debug: Chache de ataque: \(chanceAttack) | Acuuracy atual: \(accuracyPercentage)")
        
        if chanceAttack <= accuracyPercentage {
            // TODO: - Disparar que errou o ataque
            return 0
        }
        
        return damage
    }
}
