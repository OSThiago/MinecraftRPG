//
//  PlayerStatus.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 27/12/25.
//

import SpriteKit

class QuadroPersonagem: SKNode {

    private let larguraQuadro: CGFloat = 200
    private let alturaQuadro: CGFloat = 80
    private var coracoes: [SKShapeNode] = []
    
    init(nome: String) {
        super.init()
        setupQuadro(nome: nome)
        setupCoracoes()
    }
    
    private func setupQuadro(nome: String) {
        let rect = CGRect(x: -larguraQuadro/2, y: -alturaQuadro/2, width: larguraQuadro, height: alturaQuadro)
        let fundo = SKShapeNode(rect: rect, cornerRadius: 10)
        fundo.fillColor = SKColor(white: 0.15, alpha: 0.9)
        fundo.strokeColor = .cyan
        fundo.lineWidth = 2
        addChild(fundo)
        
        let labelNome = SKLabelNode(text: nome.uppercased())
        labelNome.fontName = "Futura"
        labelNome.fontSize = 16 // Fonte reduzida
        labelNome.position = CGPoint(x: 0, y: 12)
        labelNome.fontColor = .white
        addChild(labelNome)
    }
    
    private func setupCoracoes() {
        // Com largura 200, o espaçamento ideal é de 18px entre corações
        let spacing: CGFloat = 18
        let inicioX: CGFloat = -((spacing * 9) / 2)
        
        for i in 0..<10 {
            let coracao = criarShapeCoracao()
            coracao.position = CGPoint(x: inicioX + CGFloat(i) * spacing, y: -18)
            
            // Reduzimos o scale para 0.35 para caberem os 10 lado a lado
            coracao.setScale(0.35)
            
            addChild(coracao)
            coracoes.append(coracao)
        }
    }
    
    private func criarShapeCoracao() -> SKShapeNode {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: -10))
        path.addCurve(to: CGPoint(x: 0, y: 15),
                      controlPoint1: CGPoint(x: -25, y: 15),
                      controlPoint2: CGPoint(x: -15, y: 30))
        path.addCurve(to: CGPoint(x: 0, y: -10),
                      controlPoint1: CGPoint(x: 15, y: 30),
                      controlPoint2: CGPoint(x: 25, y: 15))
        
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = .systemRed
        shape.strokeColor = .white
        shape.lineWidth = 1.5
        return shape
    }
    
    func atualizarVida(quantidade: Int) {
        for (index, coracao) in coracoes.enumerated() {
            coracao.fillColor = (index < quantidade) ? .systemRed : .clear
            coracao.strokeColor = (index < quantidade) ? .white : .gray
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }
}
