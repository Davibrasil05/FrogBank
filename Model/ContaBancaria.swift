//
//  ContaBancaria.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 28/06/26.
//

import Foundation
import Combine

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let isExpense: Bool
}

class ContaBancaria: ObservableObject {
    
	//Encapsulamento com internal(set), significa que apenas a classe pode alterar os atributos de dentro
    @Published var saldo: Double = 0.0
    
    @Published var transacoes: [Transaction] = []
    
    @Published var nome: String = "Conta Corrente"
	
    @Published var mostrarAlertaIncompleto: Bool = false
    @Published var mensagemAlerta: String = ""
    
	// MARK: - Depositar
	// TODO 1: Implemente a lógica da função depositar(valor: Double)
	// Se valor > 0, adicione ao saldo
	// Atualmente a função dispara um alerta informando que a classe está incompleta.
	func depositar(valor: Double) {
		mensagemAlerta = "Depositar: Não funciona pois a classe está incompleta! Implemente o TODO 3."
		mostrarAlertaIncompleto = true
		
	}
    
    // MARK: - Sacar
    // TODO 2: Implemente a lógica da função sacar(valor: Double)
    // Taxa de R$5.00 por saque (valorComTaxa = valor + 5.0)
    // Só saque se saldo >= valorComTaxa
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func sacar(valor: Double) {
        mensagemAlerta = "Sacar: Não funciona pois a classe está incompleta! Implemente o TODO 2."
		mostrarAlertaIncompleto = true
		
		transacoes.insert(Transaction(title: "Saque", amount: valor, isExpense: true), at: 0)
		transacoes.insert(Transaction(title: "Taxa de Saque", amount: 5.0, isExpense: true), at: 0)
    }
    
    // MARK: - Transferir
    // TODO 3: Implemente a lógica da função transferir(valor: Double, destino: ContaBancaria)
    // Use sacar() desta conta e depositar() na conta destino
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func transferir(valor: Double, destino: ContaBancaria) {
        mensagemAlerta = "Transferir: Não funciona pois a classe está incompleta! Implemente o TODO 3."
        mostrarAlertaIncompleto = true

    }
    
}
