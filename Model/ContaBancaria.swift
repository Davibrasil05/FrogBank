//
//  ContaBancaria.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 28/06/26.
//

import Foundation
import Combine

class ContaBancaria: ObservableObject {
    
    // TODO 1: Implemente a lógica da propriedade 'saldo'
    // O saldo deve começar em 0.0 e ser modificado apenas pelos métodos da classe (encapsulamento)
    @Published private(set) var saldo: Double = 0.0
    
    // TODO 2: Implemente a lógica da propriedade 'nome'
    // O nome identifica o tipo de conta
    @Published var nome: String = "Conta Corrente"
    
    // Propriedade para controlar o Alert de "classe incompleta"
    @Published var mostrarAlertaIncompleto: Bool = false
    @Published var mensagemAlerta: String = ""
    
    // MARK: - Depositar
    // TODO 3: Implemente a lógica da função depositar(valor: Double)
    // Se valor > 0, adicione ao saldo
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func depositar(valor: Double) {
        mensagemAlerta = "Depositar: Não funciona pois a classe está incompleta! Implemente o TODO 3."
        mostrarAlertaIncompleto = true
    }
    
    // MARK: - Sacar
    // TODO 4: Implemente a lógica da função sacar(valor: Double)
    // Taxa de R$5.00 por saque (valorComTaxa = valor + 5.0)
    // Só saque se saldo >= valorComTaxa
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func sacar(valor: Double) {
        mensagemAlerta = "Sacar: Não funciona pois a classe está incompleta! Implemente o TODO 4."
        mostrarAlertaIncompleto = true
    }
    
    // MARK: - Transferir
    // TODO 5: Implemente a lógica da função transferir(valor: Double, destino: ContaBancaria)
    // Use sacar() desta conta e depositar() na conta destino
    // Atualmente a função dispara um alerta informando que a classe está incompleta.
    func transferir(valor: Double, destino: ContaBancaria) {
        mensagemAlerta = "Transferir: Não funciona pois a classe está incompleta! Implemente o TODO 5."
        mostrarAlertaIncompleto = true
    }
    
}
