//
//  Witch.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 02/01/26.
//

class Witch: Character {
    var health: Int = 10
    var name: String = "Witch"
    var spriteName: String = "witch"
    
    var attacks: [Attack] = [
        Attack(id: 0, name: "Pocao de Dano", amount: 2, quantity: 10),
        Attack(id: 1, name: "Pocao de Veneno", amount: 3, quantity: 5),
        Attack(id: 2, name: "Pocao de Invisibilidade", amount: 1, quantity: 5),
        Attack(id: 3, name: "Pocao de Cura", amount: 4, quantity: 5)
    ]
    
    func attackPlayer(player: Player, enemy: Player, with attack: Attack) {
        switch attack.id {
        case 0:
            let damage = attacks[0].damage
            enemy.decreaseHealth(amount: damage)
        case 1:
            let damage = attacks[1].damage
            enemy.decreaseHealth(amount: damage)
            posionAttack(enemy: enemy)
        case 2:
//            let invisibility = attacks[2].damage
            // TODO: - Implementar forma do inimigo errar os ataques com uma porcentagem
            break
        case 3:
            let health = attacks[3].damage
            player.increaseHealth(amount: health)
        default: break
        }
    }
    
    private func posionAttack(enemy: Player) {
        let poisonChance = 0.8
        
        if Double.random(in: 0...1) <= poisonChance {
            enemy.addStatusEffects(effect: PoisonStatus(turns: 3, damage: 2))
        }
    }
}
