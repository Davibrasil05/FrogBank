//
//  ContaBancaria.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 28/06/26.
//

import Foundation
import Combine

class ContaBancaria: ObservableObject {
    
	//Encapsulamento com private(set), significa que apenas a classe pode alterar os atributos de dentro
    @Published private(set) var saldo: Double = 0.0
    
    @Published var nome: String = "Conta Corrente"
    
    // Isso é apenas para função de alerta
    @Published var mostrarAlertaIncompleto: Bool = false
    @Published var mensagemAlerta: String = ""
    
	// MARK: - Depositar
	// Depositar completo com validação
	func depositar(valor: Double) {
		if valor > 0 {
			saldo += valor
		}
	}
    
    // MARK: - Sacar
    // TODO 2: Implemente a lógica da função sacar(valor: Double)
    // Taxa de R$5.00 por saque (valorComTaxa = valor + 5.0)
    // Só saque se saldo >= valorComTaxa
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func sacar(valor: Double) {
        mensagemAlerta = "Sacar: Não funciona pois a classe está incompleta! Implemente o TODO 2."
        mostrarAlertaIncompleto = true
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
