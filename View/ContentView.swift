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
		TabView {
			AccountView(conta: contaCorrente, title: "Conta Corrente", contaDestino: contaPoupanca)
				.tabItem {
					Label("Corrente", systemImage: "building.columns.fill")
				}
			
			AccountView(conta: contaPoupanca, title: "Conta Poupança")
				.tabItem {
					Label("Poupança", systemImage: "leaf.fill")
				}
		}
		.tint(.frogDarkGreen)
	}
}

struct AccountView: View {
	@ObservedObject var conta: ContaBancaria
	let title: String
	var contaDestino: ContaBancaria? = nil
	
	@State private var showingTransactionSheet = false
	@State private var transactionType: TransactionType = .deposit
	@State private var activeContaDestino: ContaBancaria? = nil
	
	var body: some View {
		NavigationStack {
			List {
				// Primeira Section: Card de Saldo
				Section {
					VStack(alignment: .leading, spacing: 8) {
						Text("Saldo Disponível")
							.font(.subheadline)
							.foregroundColor(.frogLightGreen)
						
						Text("R$ \(conta.saldo, specifier: "%.2f")")
							.font(.largeTitle)
							.fontWeight(.bold)
							.foregroundColor(.frogLightGreen)
						
						Text(title)
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
				
				// Segunda Section: Ações Rápidas
				Section {
					HStack {
						Spacer()
						QuickActionButton(icon: "plus.circle.fill", title: "Depositar") {
							transactionType = .deposit
							showingTransactionSheet = true
						}
						Spacer()
						QuickActionButton(icon: "minus.circle.fill", title: "Sacar") {
							transactionType = .withdraw
							showingTransactionSheet = true
						}

						if let destino = contaDestino {
							Spacer()
							QuickActionButton(icon: "arrow.left.arrow.right.circle.fill", title: "Transferir") {
								activeContaDestino = destino
								transactionType = .transfer
								showingTransactionSheet = true
							}
						}

						if let poupanca = conta as? ContaPoupanca {
							Spacer()
							QuickActionButton(icon: "chart.line.uptrend.xyaxis", title: "Rendimento") {
								poupanca.renderJuros()
							}
						}
						
						Spacer()
					}
					.padding(.vertical, 4)
				}
				
				// Terceira Section: Extrato (Transações Recentes)
				Section(header: Text("Transações Recentes")) {
                    if conta.transacoes.isEmpty {
                        Text("Nenhuma transação")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(conta.transacoes) { t in
                            TransactionRow(title: t.title, amount: (t.isExpense ? "- R$ " : "+ R$ ") + String(format: "%.2f", t.amount), isExpense: t.isExpense)
                        }
                    }
				}
			}
			.navigationTitle("FrogBank")
			.background(Color(UIColor.systemGroupedBackground))
			.scrollContentBackground(.hidden)
			.sheet(isPresented: $showingTransactionSheet) {
				TransactionSheetView(conta: conta, type: transactionType, contaDestino: activeContaDestino)
			}
			// Alert - dispara quando método incompleto é chamado
			.alert("⚠️ Classe Incompleta", isPresented: $conta.mostrarAlertaIncompleto) {
				Button("OK", role: .cancel) { }
			} message: {
				Text(conta.mensagemAlerta)
			}
		}
	}
}

struct TransactionRow: View {
	let title: String
	let amount: String
	let isExpense: Bool
	
	var body: some View {
		HStack(spacing: 16) {
			Text(title)
				.font(.body)
				.foregroundColor(.primary)
			
			Spacer()
			
			Text(amount)
				.font(.body)
				.fontWeight(.medium)
				.foregroundColor(isExpense ? Color.red.opacity(0.8) : .frogMediumGreen)
		}
	}
}

#Preview {
	ContentView()
}
