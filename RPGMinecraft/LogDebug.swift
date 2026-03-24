//
//  LogDebug.swift
//  RPGMinecraft
//
//  Created by Thiago de Oliveira Sousa on 23/03/26.
//

import Foundation

func logDebug(_ mensagem: String, linha: Int = #line, funcName: String = #function) {
    print("[Linha: \(linha) - \(funcName)] \(mensagem)")
}
