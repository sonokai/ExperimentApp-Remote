//
//  NotesExplanationView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/14/24.
//

import SwiftUI

struct NotesExplanationView: View {
    @Binding var sheet: Bool
    var body: some View {
        NavigationStack {
            Form {
                Text("Write here what you were doing immediately before making this entry. This will help you establish connections between events in your daily life and your mood.")
            }.toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Done"){
                        sheet.toggle()
                    }
                }
            }.navigationTitle("Purpose")
        }
        
    }
}

#Preview {
    NotesExplanationView(sheet: .constant(true))
}
