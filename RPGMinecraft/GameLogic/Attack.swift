//
//  Attack.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

class Attack {
    let id: Int
    let name: String
    let damage: Int
    var critical: Int = 0
    var remainingAttacks: Int = 0
    var attackDiolog: String = ""
    
    private let quantityAttacks: Int
    
    init(id: Int,
         name: String,
         amount: Int,
         quantity: Int
    ) {
        self.id = id
        self.name = name
        self.damage = amount
        self.quantityAttacks = quantity
        self.remainingAttacks = quantity
    }
    
    func increaseCritical(buffer: Int) {
        critical += buffer
    }
    
    func decraseAttacksRemaining(quantity: Int) {
        let min = 0
        self.remainingAttacks -= quantity
        if self.remainingAttacks < min {
            self.remainingAttacks = min
        }
    }
    
    func resetAttacksRemaining() {
        self.remainingAttacks = quantityAttacks
    }
    
    func setAttackdialog(_ dialog: String) {
        self.attackDiolog = dialog
    }
}
