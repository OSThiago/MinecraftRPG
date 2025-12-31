//
//  TypewriterLabel.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

import SpriteKit

final class TypewriterLabel: SKLabelNode {

    private var fullText: String = ""
    private var currentIndex: String.Index?
    private var typingSpeed: TimeInterval = 0.02
    private var typingActionKey = "typing"

    // MARK: - Iniciar animação
    func startTyping(
        text: String,
        speed: TimeInterval = 0.02
    ) {
        removeAction(forKey: typingActionKey)

        fullText = text
        typingSpeed = speed
        self.text = ""
        currentIndex = fullText.startIndex

        let action = SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run { [weak self] in
                    self?.appendNextCharacter()
                },
                SKAction.wait(forDuration: typingSpeed)
            ])
        )

        run(action, withKey: typingActionKey)
    }

    // MARK: - Próximo caractere
    private func appendNextCharacter() {
        guard let index = currentIndex else { return }

        if index < fullText.endIndex {
            text?.append(fullText[index])
            currentIndex = fullText.index(after: index)
        } else {
            removeAction(forKey: typingActionKey)
        }
    }

    // MARK: - Pular animação
    func skip() {
        removeAction(forKey: typingActionKey)
        text = fullText
    }

    var isTyping: Bool {
        action(forKey: typingActionKey) != nil
    }
}
