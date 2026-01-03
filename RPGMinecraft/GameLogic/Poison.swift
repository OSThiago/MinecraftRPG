//
//  Poison.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 02/01/26.
//

enum StatusEffectType {
    case poison
}

protocol StatusEffect {
    var type: StatusEffectType { get }
    var remainingTurns: Int { get set }

    func onTurnStart(player: Player)
}

class PoisonStatus: StatusEffect {
    let type: StatusEffectType = .poison
    var remainingTurns: Int
    let damagePerTurn: Int

    init(turns: Int, damage: Int) {
        self.remainingTurns = turns
        self.damagePerTurn = damage
    }

    func onTurnStart(player: Player) {
        player.decreaseHealth(amount: damagePerTurn)
        remainingTurns -= 1
    }
}
