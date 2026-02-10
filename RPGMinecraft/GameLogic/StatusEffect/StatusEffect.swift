//
//  StatusEffect.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 18/01/26.
//

enum StatusEffectType {
    case poison
    case accuracy
}

protocol StatusEffect {
    var type: StatusEffectType { get }
    var remainingTurns: Int { get set }

    func onTurnStart(player: Player)
}
