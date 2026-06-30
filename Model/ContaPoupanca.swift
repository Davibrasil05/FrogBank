//
//  ContaPoupanca.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 29/06/26.
//

import Foundation
import Combine

class ContaPoupanca: ContaBancaria {
    
    override init() {
        super.init()
        self.nome = "Conta Poupança"
    }
    
    // MARK: - Render Juros
    // TODO 4: Implemente a lógica da função renderJuros()
    // rendimento = saldo * 0.01, depois deposite o rendimento
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func renderJuros() {
        // mensagemAlerta = "Render Juros: Não funciona pois a classe está incompleta! Implemente o TODO 4."
        // mostrarAlertaIncompleto = true
        let rendimento = saldo * 0.01
        if rendimento > 0 {
            // Em vez de chamar o depositar() padrão, vamos adicionar manualmente para ter um título melhor
            saldo += rendimento
            transacoes.insert(Transaction(title: "Rendimento", amount: rendimento, isExpense: false), at: 0)
        }
    }
    
    // MARK: - Sacar (Override - Polimorfismo)
    // TODO 5: Faça override da função sacar(valor: Double)
    // Na poupança NÃO tem taxa. Só verifique se saldo >= valor
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    override func sacar(valor: Double) {
        // mensagemAlerta = "Sacar (Poupança): Não funciona pois a classe está incompleta! Implemente o TODO 5."
        // mostrarAlertaIncompleto = true
        if saldo >= valor && valor > 0 {
            saldo -= valor
            transacoes.insert(Transaction(title: "Saque", amount: valor, isExpense: true), at: 0)
        }
    }
}
