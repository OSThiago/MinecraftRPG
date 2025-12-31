//
//  PlayerStatus.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 27/12/25.
//

import SpriteKit

//class QuadroPersonagem: SKNode {
//
//    private let larguraQuadro: CGFloat = 200
//    private let alturaQuadro: CGFloat = 80
//    private var coracoes: [SKShapeNode] = []
//    
//    init(nome: String) {
//        super.init()
//        setupQuadro(nome: nome)
//        setupCoracoes()
//    }
//    
//    private func setupQuadro(nome: String) {
//        let rect = CGRect(x: -larguraQuadro/2, y: -alturaQuadro/2, width: larguraQuadro, height: alturaQuadro)
//        let fundo = SKShapeNode(rect: rect, cornerRadius: 10)
//        fundo.fillColor = SKColor(white: 0.15, alpha: 0.9)
//        fundo.strokeColor = .cyan
//        fundo.lineWidth = 2
//        addChild(fundo)
//        
//        let labelNome = SKLabelNode(text: nome.uppercased())
//        labelNome.fontName = "Futura"
//        labelNome.fontSize = 16 // Fonte reduzida
//        labelNome.position = CGPoint(x: 0, y: 12)
//        labelNome.fontColor = .white
//        addChild(labelNome)
//    }
//    
//    private func setupCoracoes() {
//        // Com largura 200, o espaçamento ideal é de 18px entre corações
//        let spacing: CGFloat = 18
//        let inicioX: CGFloat = -((spacing * 9) / 2)
//        
//        for i in 0..<10 {
//            let coracao = criarShapeCoracao()
//            coracao.position = CGPoint(x: inicioX + CGFloat(i) * spacing, y: -18)
//            
//            // Reduzimos o scale para 0.35 para caberem os 10 lado a lado
//            coracao.setScale(0.35)
//            
//            addChild(coracao)
//            coracoes.append(coracao)
//        }
//    }
//    
//    private func criarShapeCoracao() -> SKShapeNode {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: -10))
//        path.addCurve(to: CGPoint(x: 0, y: 15),
//                      controlPoint1: CGPoint(x: -25, y: 15),
//                      controlPoint2: CGPoint(x: -15, y: 30))
//        path.addCurve(to: CGPoint(x: 0, y: -10),
//                      controlPoint1: CGPoint(x: 15, y: 30),
//                      controlPoint2: CGPoint(x: 25, y: 15))
//        
//        let shape = SKShapeNode(path: path.cgPath)
//        shape.fillColor = .systemRed
//        shape.strokeColor = .white
//        shape.lineWidth = 1.5
//        return shape
//    }
//    
//    func atualizarVida(quantidade: Int) {
//        for (index, coracao) in coracoes.enumerated() {
//            coracao.fillColor = (index < quantidade) ? .systemRed : .clear
//            coracao.strokeColor = (index < quantidade) ? .white : .gray
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) { fatalError() }
//}

import SpriteKit

final class CharacterStatusPanel: SKNode {

    // MARK: - Nodes
    private let nameLabel: SKLabelNode
    private let backgroundBar: SKSpriteNode
    private let foregroundBar: SKSpriteNode
    private let hpLabel: SKLabelNode

    // MARK: - Properties
    private let barWidth: CGFloat
    private let barHeight: CGFloat

    private(set) var maxHealth: Int
    private(set) var currentHealth: Int

    // MARK: - Init
    init(
        characterName: String,
        maxHealth: Int,
        initialHealth: Int,
        width: CGFloat = 200,
        barHeight: CGFloat = 14
    ) {
        self.maxHealth = maxHealth
        self.currentHealth = min(initialHealth, maxHealth)
        self.barWidth = width
        self.barHeight = barHeight

        // Name
        nameLabel = SKLabelNode(fontNamed: "Minecraft")
        nameLabel.text = characterName.uppercased()
        nameLabel.fontSize = 14
        nameLabel.fontColor = .white
        nameLabel.horizontalAlignmentMode = .left
        nameLabel.verticalAlignmentMode = .center

        // HP text
        hpLabel = SKLabelNode(fontNamed: "Minecraft")
        hpLabel.fontSize = 10
        hpLabel.fontColor = .white
        hpLabel.horizontalAlignmentMode = .right
        hpLabel.verticalAlignmentMode = .center

        // Bars
        backgroundBar = SKSpriteNode(
            color: .darkGray,
            size: CGSize(width: width, height: barHeight)
        )

        foregroundBar = SKSpriteNode(
            color: .green,
            size: CGSize(width: width, height: barHeight)
        )

        super.init()

        setupLayout()
        updateHealth(animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupLayout() {
        // Name position
        nameLabel.position = CGPoint(x: 0, y: barHeight + 10)

        // Bars
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        foregroundBar.anchorPoint = CGPoint(x: 0, y: 0.5)

        backgroundBar.position = .zero
        foregroundBar.position = .zero

        // HP label
        hpLabel.position = CGPoint(x: barWidth, y: -12)

        addChild(nameLabel)
        addChild(backgroundBar)
        addChild(foregroundBar)
        addChild(hpLabel)

        // Border (optional)
        let border = SKShapeNode(
            rect: CGRect(
                x: 0,
                y: -barHeight / 2,
                width: barWidth,
                height: barHeight
            ),
            cornerRadius: 2
        )
        border.strokeColor = .black
        border.lineWidth = 2
        border.fillColor = .clear
        border.zPosition = 5

        addChild(border)
    }

    // MARK: - Health Control
    func setHealth(_ value: Int, animated: Bool = true) {
        currentHealth = max(0, min(value, maxHealth))
        updateHealth(animated: animated)
    }

    func takeDamage(_ amount: Int) {
        setHealth(currentHealth - amount)
    }

    func heal(_ amount: Int) {
        setHealth(currentHealth + amount)
    }

    // MARK: - Visual Update
    private func updateHealth(animated: Bool) {
        let percentage = CGFloat(currentHealth) / CGFloat(maxHealth)
        let newWidth = barWidth * percentage

        let resizeAction = SKAction.resize(
            toWidth: newWidth,
            duration: animated ? 0.15 : 0
        )

        foregroundBar.run(resizeAction)

        updateBarColor(percentage)
        updateHPText()
    }

    private func updateBarColor(_ percentage: CGFloat) {
        switch percentage {
        case 0.6...1.0:
            foregroundBar.color = .green
        case 0.3..<0.6:
            foregroundBar.color = .yellow
        default:
            foregroundBar.color = .red
        }
    }

    private func updateHPText() {
        hpLabel.text = "HP \(currentHealth) / \(maxHealth)"
    }
}
