//
//  SleepEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepEditView: View {
    @Binding var entry: IntEntry
    @State var independent: String = ""
    @State var dependent: String = ""
    @State var date: String = ""
    
    
    var body: some View {
        VStack {
            TextField("Entry date:", text: $date)
            TextField("Hours of sleep:", text: $independent)
            TextField("Quality of day:", text: $dependent)
            
        }
        .padding()

    }
}

struct SleepEditView_Previews: PreviewProvider {
    static var previews: some View {
        SleepEditView(entry: .constant(IntEntry.sampleData[0]))
    }
}
