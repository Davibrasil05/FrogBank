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
	// TODO 1: Completa
	func depositar(valor: Double) {
		//verifica se o valor pedido é maior que 0
		if valor > 0 {
			saldo += valor
		}
		
		transacoes.insert(Transaction(title: "Deposito", amount: valor, isExpense: false), at: 0)
	}
    
    // MARK: - Sacar
    // TODO 2: Completa
    func sacar(valor: Double) {
		guard valor > 0 else { return }
		let valorComTaxa: Double = valor + 5.0
		if saldo >= valorComTaxa {
			saldo -= valorComTaxa
			transacoes.insert(Transaction(title: "Saque", amount: valor, isExpense: true), at: 0)
			transacoes.insert(Transaction(title: "Taxa de Saque", amount: 5.0, isExpense: true), at: 0)
		}
    }
    
    // MARK: - Transferir
    // TODO 3: Completo
    func transferir(valor: Double, destino: ContaBancaria) {
		if valor > 0 && saldo >= valor {
			saldo -= valor
			destino.saldo += valor
			
			
			transacoes.insert(Transaction(title: "Transferência Enviada", amount: valor, isExpense: true), at: 0)
			destino.transacoes.insert(Transaction(title: "Transferência Recebida", amount: valor, isExpense: false), at: 0)
		}
    }
    
}
