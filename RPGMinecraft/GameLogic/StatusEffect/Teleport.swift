//
//  Teleport.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 22/02/26.
//

class Teleport: StatusEffect {
    var type: StatusEffectType = .teleport
    var remainingTurns: Int
    
    var accuracyPercentage: Int = 0
    
    init(turns: Int, percentage: Int) {
        self.remainingTurns = turns
        self.upPercentage(value: percentage)
    }
    
    func onTurnStart(player: Player) {
        setRemainingTurns(to: remainingTurns - 1)
        downPercentage(value: 10)
        // Adicionar logica para o inimigo dar menos dano
    }
    
    func upPercentage(value: Int) {
        let maxPercentage = 80
        var result = accuracyPercentage + value
        if result > maxPercentage {
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
    
    func setRemainingTurns(to turns: Int) {
        self.remainingTurns = turns
    }
    
    func calculateDamage(damage: Int) -> Int {
        // Por enquanto faremos ele errar o ataque, futuramente fazer ele também diminuir o dano caso não erre o ataque
        let maxAccuracy = 80
    
        let chanceAttack = Int.random(in: 0...maxAccuracy)
        
        logDebug("Chache de ataque: \(chanceAttack) | Chance de ataque atual: \(accuracyPercentage)")
        logDebug("Quantidade de turnos com Teleport: \(remainingTurns)")
        if chanceAttack <= accuracyPercentage {
            // TODO: - Disparar que errou o ataque
            return 0
        }
        
        return damage
    }
}
