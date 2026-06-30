//
//  ContentView.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 26/06/26.
//

import SwiftUI

// Extension para as cores solicitadas
extension Color {
    static let frogDarkGreen = Color(red: 0/255, green: 62/255, blue: 31/255)     // #003E1F
    static let frogMediumGreen = Color(red: 115/255, green: 186/255, blue: 155/255) // #73BA9B
    static let frogLightGreen = Color(red: 213/255, green: 242/255, blue: 227/255)  // #D5F2E3
}

struct ContentView: View {
    @StateObject var contaCorrente = ContaBancaria()
    @StateObject var contaPoupanca = ContaPoupanca()
    
	
    var body: some View {
        NavigationStack {
            List {
                // Primeira Section: Card de Saldo - Conta Corrente
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Saldo Disponível")
                            .font(.subheadline)
                            .foregroundColor(.frogLightGreen)
                        
                        Text("R$ \(contaCorrente.saldo, specifier: "%.2f")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.frogLightGreen)
                        
                        Text("Conta Corrente")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.frogLightGreen)
                            .clipShape(Capsule())
                    }
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color.frogDarkGreen)
                
                // Section: Saldo da Poupança
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Conta Poupança")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("R$ \(contaPoupanca.saldo, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.frogDarkGreen)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                
                // Section: Ações Rápidas
                Section {
                    HStack {
                        Spacer()
                        QuickActionButton(icon: "plus.circle.fill", title: "Depositar") {
                            contaCorrente.depositar(valor: 100.0)
                        }
                        Spacer()
                        QuickActionButton(icon: "minus.circle.fill", title: "Sacar") {
                            contaCorrente.sacar(valor: 50.0)
                        }
                        Spacer()
                        QuickActionButton(icon: "arrow.left.arrow.right.circle.fill", title: "Transferir") {
                            contaCorrente.transferir(valor: 50.0, destino: contaPoupanca)
                        }
                        Spacer()
                        QuickActionButton(icon: "chart.line.uptrend.xyaxis.circle.fill", title: "Rendimento") {
                            contaPoupanca.renderJuros()
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                
                // Section: Extrato (Transações Recentes)
                Section(header: Text("Transações Recentes")) {
                    TransactionRow(icon: "cup.and.saucer.fill", title: "Cafeteria", amount: "- R$ 15,00", isExpense: true)
                    TransactionRow(icon: "cart.fill", title: "Supermercado", amount: "- R$ 150,00", isExpense: true)
                    TransactionRow(icon: "briefcase.fill", title: "Salário", amount: "+ R$ 5.000,00", isExpense: false)
                }
            }
            .navigationTitle("FrogBank")
            .background(Color(UIColor.systemGroupedBackground))
            .scrollContentBackground(.hidden)
            // Alert para Conta Corrente - dispara quando método incompleto é chamado
            .alert("⚠️ Classe Incompleta", isPresented: $contaCorrente.mostrarAlertaIncompleto) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(contaCorrente.mensagemAlerta)
            }
            // Alert para Conta Poupança - dispara quando método incompleto é chamado
            .alert("⚠️ Classe Incompleta", isPresented: $contaPoupanca.mostrarAlertaIncompleto) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(contaPoupanca.mensagemAlerta)
            }
        }
    }
}

// MARK: - Subcomponents

struct QuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.frogMediumGreen)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
    }
}

struct TransactionRow: View {
    let icon: String
    let title: String
    let amount: String
    let isExpense: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.frogMediumGreen)
                .frame(width: 40, height: 40)
                .background(Color.frogMediumGreen.opacity(0.15))
                .cornerRadius(8)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(amount)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(isExpense ? .primary : .frogMediumGreen)
        }
    }
}

#Preview {
    ContentView()
}
