//
//  TypewriterLabel.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 31/12/25.
//

import SpriteKit

final class TypewriterLabel: SKLabelNode {

    private var fullText: String = ""
    private var typingSpeed: TimeInterval = 0.02
    private var typingTask: Task<Void, Never>?

    // MARK: - Iniciar animação (async)
    func startTyping(
        text: String,
        speed: TimeInterval = 0.02
    ) async {

        // Cancela qualquer digitação em andamento
        typingTask?.cancel()

        fullText = text
        typingSpeed = speed
        self.text = ""

        typingTask = Task { @MainActor in
            for char in fullText {
                if Task.isCancelled { return }

                self.text?.append(char)

                try? await Task.sleep(
                    nanoseconds: UInt64(typingSpeed * 1_000_000_000)
                )
            }
        }

        // Aguarda a task terminar
        await typingTask?.value
        typingTask = nil
    }

    // MARK: - Pular animação
    func skip() {
        typingTask?.cancel()
        typingTask = nil
        text = fullText
    }

    var isTyping: Bool {
        typingTask != nil
    }
}
