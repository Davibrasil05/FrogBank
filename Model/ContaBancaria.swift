//
//  ContaBancaria.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 28/06/26.
//

import Foundation
import Combine

class ContaBancaria: ObservableObject {
    @Published var saldo: Double = 1000.00
    @Published var nome: String = "Conta de Exemplo"
    @discardableResult
    func depositar(valor: Double) -> Bool {
        // TODO: Implementar lógica na aula
        if valor > 0 {
           saldo += valor
           return true
        }
        return false
    }
    
    @discardableResult
    func sacar(valor: Double) -> Bool {
        // TODO: Implementar lógica na aula
        let valorComTaxa = valor + 5.0
        
        if saldo >= valorComTaxa {
            saldo -= valorComTaxa
            return true
        }
        
        return false
    }
}

