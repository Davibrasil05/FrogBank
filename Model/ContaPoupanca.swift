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
	// TODO 4: Completa
	func renderJuros() {
		
		let rendimento: Double = saldo * 0.01
		saldo += rendimento
		transacoes.insert(Transaction(title: "Rendimento", amount: rendimento, isExpense: false), at: 0)
		
	}
	
	
	// MARK: - Sacar (Override - Polimorfismo)
	// TODO 5: Completo
	override func sacar(valor: Double) {
		
		if saldo >= valor {
			saldo -= valor
		}
		
		//Serve apenas para visualização
		transacoes.insert(Transaction(title: "Saque", amount: valor, isExpense: true), at: 0)
	}
}


