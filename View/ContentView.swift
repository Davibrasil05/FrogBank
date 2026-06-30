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
							// Testa se o método está implementado
							conta.mostrarAlertaIncompleto = false
							conta.depositar(valor: 0)
							if !conta.mostrarAlertaIncompleto {
								// Método implementado! Abre o sheet
								transactionType = .deposit
								showingTransactionSheet = true
							}
							// Se mostrarAlertaIncompleto == true, o .alert exibe automaticamente
						}
						Spacer()
						QuickActionButton(icon: "minus.circle.fill", title: "Sacar") {
							// Testa se o método está implementado
							conta.mostrarAlertaIncompleto = false
							conta.sacar(valor: 0)
							if !conta.mostrarAlertaIncompleto {
								// Método implementado! Abre o sheet
								transactionType = .withdraw
								showingTransactionSheet = true
							}
						}

						if let destino = contaDestino {
							Spacer()
							QuickActionButton(icon: "arrow.left.arrow.right.circle.fill", title: "Transferir") {
								conta.mostrarAlertaIncompleto = false
								conta.transferir(valor: 0, destino: destino)
								if !conta.mostrarAlertaIncompleto {
									// TODO: Abrir sheet de transferência quando implementado
								}
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
					TransactionRow(icon: "cup.and.saucer.fill", title: "Cafeteria", amount: "- R$ 15,00", isExpense: true)
					TransactionRow(icon: "cart.fill", title: "Supermercado", amount: "- R$ 150,00", isExpense: true)
					TransactionRow(icon: "briefcase.fill", title: "Salário", amount: "+ R$ 5.000,00", isExpense: false)
				}
			}
			.navigationTitle("FrogBank")
			.background(Color(UIColor.systemGroupedBackground))
			.scrollContentBackground(.hidden)
			.sheet(isPresented: $showingTransactionSheet) {
				TransactionSheetView(conta: conta, type: transactionType)
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
