//
//  TransactionSheetView.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 30/06/26.
//
import SwiftUI
enum TransactionType {
    case deposit, withdraw
}

struct TransactionSheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var conta: ContaBancaria
    let type: TransactionType
    
    @State private var amountString: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text(type == .deposit ? "Quanto você quer depositar?" : "Quanto você quer sacar?")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("R$")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.frogDarkGreen)
                        
                        TextField("0,00", text: $amountString)
                            .font(.system(size: 40, weight: .bold))
                            .keyboardType(.decimalPad)
                            .foregroundColor(.frogDarkGreen)
                    }
                    .padding()
                    .background(Color.frogLightGreen.opacity(0.3))
                    .cornerRadius(16)
                    
                    if showError {
                        Text(type == .deposit ? "Valor inválido." : "Saldo insuficiente ou valor inválido.")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    let formattedString = amountString.replacingOccurrences(of: ",", with: ".")
                    if let amount = Double(formattedString), amount > 0 {
                        if type == .deposit {
                            conta.depositar(valor: amount)
                        } else {
                            conta.sacar(valor: amount)
                        }
                        dismiss()
                    } else {
                        showError = true
                    }
                }) {
                    Text("Confirmar")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.frogDarkGreen)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top, 32)
            .navigationTitle(type == .deposit ? "Depósito" : "Saque")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.frogDarkGreen)
                }
            }
        }
    }
}
