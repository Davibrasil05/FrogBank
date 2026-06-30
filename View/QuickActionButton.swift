//
//  QuickActionButton.swift
//  FrogBank
//
//  Created by Davi Sobreira Brasil on 30/06/26.
//
import SwiftUI

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
