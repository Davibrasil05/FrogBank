//
//  ContaPoupanca.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 29/06/26.
//

import Foundation
import Combine

class ContaPoupanca: ContaBancaria {
    func renderJuros(){
        let rendimento = saldo * 0.01
        depositar(valor: rendimento)
    }
    
    override func sacar(valor: Double) {
        if saldo >= valor {
            saldo -= valor
        }
    }
}
