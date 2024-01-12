//
//  SleepExperimentHeader.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/22/23.
//

import SwiftUI

struct SleepExperimentHeader: View {
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isOn.toggle()
            }
        }, label: {
            if isOn {
                Image(systemName: "chevron.down")
            } else {
                Image(systemName: "chevron.up")
            }
        })
        .font(Font.caption)
        .foregroundColor(.accentColor)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .overlay(
            Text(title),
            alignment: .leading
        )
    }
}

struct SleepExperimentHeader_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            Section(header: SleepExperimentHeader(title: "Experiment", isOn:.constant(false))){
                Text("Form stuff here")
            }
        }
        
    }
}
