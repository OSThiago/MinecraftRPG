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
    let quantity: Int
    
    init(id: Int,
         name: String,
         amount: Int,
         quantity: Int
    ) {
        self.id = id
        self.name = name
        self.damage = amount
        self.quantity = quantity
    }
    
    func increaseCritical(buffer: Int) {
        critical += buffer
    }
}
