//
//  SleepInsightEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/21/24.
//

import SwiftUI

struct SleepInsightEditView: View {
    @Binding var insight: Insight
    @State var text: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            TextEditor(text: $text).frame(minHeight: 100)
                .toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button("Save"){
                            insight.text = text
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }.navigationTitle("Edit insight")
            
    }
}

struct SleepInsightEditView_Previews: PreviewProvider {
    static var previews: some View {
        SleepInsightEditView(insight:.constant(Insight(text: "This is an insight that can be edited", date: Date())), text: "This is an insight that can be edited")
    }
}
