//
//  StatusEffect.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 18/01/26.
//

enum StatusEffectType {
    case poison
    case invisibility
    case teleport
    
    var effectTextureName: String {
        switch self {
        case .poison: "Poison"
        case .invisibility: "Invisibility"
        case .teleport: "Teleport"
        }
    }
}

protocol StatusEffect {
    var type: StatusEffectType { get }
    var remainingTurns: Int { get set }

    func onTurnStart(player: Player)
}

extension StatusEffect {
    var textureName: String {
        self.type.effectTextureName
    }
}
