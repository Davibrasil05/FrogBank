//
//  ContaPoupanca.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 29/06/26.
//

import Foundation
import Combine

// TODO 6: A classe ContaPoupanca já herda de ContaBancaria (Herança - pilar da POO)
// Agora implemente os métodos abaixo para que a poupança funcione de verdade.
class ContaPoupanca: ContaBancaria {
    
    override init() {
        super.init()
        self.nome = "Conta Poupança"
    }
    
    // MARK: - Render Juros
    // TODO 7: Implemente a lógica da função renderJuros()
    // rendimento = saldo * 0.01, depois deposite o rendimento
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func renderJuros() {
        mensagemAlerta = "Render Juros: Não funciona pois a classe está incompleta! Implemente o TODO 7."
        mostrarAlertaIncompleto = true
    }
    
    // MARK: - Sacar (Override - Polimorfismo)
    // TODO 8: Faça override da função sacar(valor: Double)
    // Na poupança NÃO tem taxa. Só verifique se saldo >= valor
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    override func sacar(valor: Double) {
        mensagemAlerta = "Sacar (Poupança): Não funciona pois a classe está incompleta! Implemente o TODO 8."
        mostrarAlertaIncompleto = true
    }
}
