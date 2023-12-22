//
//  SleepExperimentHeader.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/22/23.
//

import SwiftUI

struct SleepExperimentHeader: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        HStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
            
        }
    }
}

struct SleepExperimentHeader_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            Section(header: SleepExperimentHeader(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))){
                Text("Form stuff here")
            }
        }
        
    }
}
