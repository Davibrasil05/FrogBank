//
//  TransactionSheetView.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 30/06/26.
//
import SwiftUI
enum TransactionType {
    case deposit, withdraw, transfer
}

struct TransactionSheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var conta: ContaBancaria
    let type: TransactionType
    var contaDestino: ContaBancaria? = nil
    
    @State private var amountString: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text(type == .deposit ? "Quanto você quer depositar?" : (type == .withdraw ? "Quanto você quer sacar?" : "Quanto você quer transferir?"))
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
                            .onChange(of: amountString) { newValue in
                                if newValue.count > 6 {
                                    amountString = String(newValue.prefix(6))
                                }
                            }
                    }
                    .padding()
                    .background(Color.frogLightGreen.opacity(0.3))
                    .cornerRadius(16)
                    
                    if hasInsufficientBalance {
                        Text("Saldo insuficiente.")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding(.top, 4)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    if let amount = parsedAmount, amount > 0 {
                        if type == .deposit {
                            conta.depositar(valor: amount)
                        } else if type == .withdraw {
                            conta.sacar(valor: amount)
                        } else if type == .transfer, let destino = contaDestino {
                            conta.transferir(valor: amount, destino: destino)
                        }
                        dismiss()
                    }
                }) {
                    Text("Confirmar")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isButtonEnabled ? Color.frogDarkGreen : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(!isButtonEnabled)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top, 32)
            .navigationTitle(type == .deposit ? "Depósito" : (type == .withdraw ? "Saque" : "Transferência"))
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
    
    // MARK: - Validation Helpers
    
    private var parsedAmount: Double? {
        let formattedString = amountString.replacingOccurrences(of: ",", with: ".")
        return Double(formattedString)
    }
    
    private var hasInsufficientBalance: Bool {
        guard type == .withdraw || type == .transfer, let amount = parsedAmount, amount > 0 else { return false }
        if conta is ContaPoupanca {
            return amount > conta.saldo
        } else {
            return amount > (conta.saldo - 5.0)
        }
    }
    
    private var isButtonEnabled: Bool {
        guard let amount = parsedAmount, amount > 0 else { return false }
        if type == .withdraw {
            return !hasInsufficientBalance
        }
        return true
    }
}
