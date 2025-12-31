//
//  CharacterProtocol.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

protocol Character {
    var health: Int { get set }
    var name: String { get set }
    var spriteName: String { get set }
    var attacks: [Attack] { get set }
    func attackPlayer(player: Player, enemy: Player, with: Attack)
}
