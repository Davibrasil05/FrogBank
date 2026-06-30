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
	// TODO 5: Faça override da função sacar(valor: Double)
	// Na poupança NÃO tem taxa. Só verifique se saldo >= valor
	// Atualmente a função dispara um alerta informando que a classe está incompleta.
	override func sacar(valor: Double) {
		
		
		
		
		//Pode apagar quando fizer o método
		mensagemAlerta = "Sacar (Poupança): Não funciona pois a classe está incompleta! Implemente o TODO 5."
		mostrarAlertaIncompleto = true
		
		
		//Serve apenas para visualização
		transacoes.insert(Transaction(title: "Saque", amount: valor, isExpense: true), at: 0)
	}
}


