//
//  AtackButton.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 30/12/25.
//

import SpriteKit

final class AttackButton: SKNode {

    private let background: SKSpriteNode
    private let label: SKLabelNode

    init(
        title: String,
        width: CGFloat = 150,
        height: CGFloat = 48
    ) {
        // Fundo do botão (estilo Minecraft)
        background = SKSpriteNode(color: .init(white: 0.25, alpha: 1.0),
                                  size: CGSize(width: width, height: height))
        background.name = "buttonBackground"
        background.zPosition = 0

        // Label
        label = SKLabelNode(fontNamed: "Avenir-Heavy") // se não tiver, use "Avenir-Heavy"
        label.fontSize = 16
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.zPosition = 1

        super.init()

        isUserInteractionEnabled = true

        setupTitle(title)
        setupBorder()

        addChild(background)
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Title com quebra de linha
    private func setupTitle(_ title: String) {
        let words = title.split(separator: " ")

        if words.count >= 2 {
            // Quebra após a primeira palavra
            label.text = "\(words[0])\n\(words[1...].joined(separator: " "))"
            label.numberOfLines = 2
            label.lineBreakMode = .byWordWrapping
        } else {
            label.text = title
        }
    }

    // MARK: - Borda estilo Minecraft
    private func setupBorder() {
        let border = SKShapeNode(rectOf: background.size, cornerRadius: 2)
        border.strokeColor = .black
        border.lineWidth = 2
        border.fillColor = .clear
        border.zPosition = 2
        addChild(border)
    }

    // MARK: - Efeito de clique
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        background.color = .init(white: 0.18, alpha: 1.0)
        run(SKAction.scale(to: 0.97, duration: 0.05))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        background.color = .init(white: 0.25, alpha: 1.0)
        run(SKAction.scale(to: 1.0, duration: 0.05))
        onTap?()
    }

    // Callback
    var onTap: (() -> Void)?
}
