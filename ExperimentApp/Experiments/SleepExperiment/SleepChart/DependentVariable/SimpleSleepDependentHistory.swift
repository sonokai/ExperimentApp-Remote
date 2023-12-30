//
//  SimpleSleepDependentHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI

struct SimpleSleepDependentHistory: View {
    let experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable = .both
    @State var average: Double = 0
    var body: some View {
        HStack(alignment: .top){
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(color())
                .frame(width: 300, height: 60)
                .overlay {
                    HStack{
                        Text("\(average.formatted(.number.precision(.fractionLength(1))))")
                            .font(.title)
                            .bold()
                        Spacer()
                        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                            Text("Quality of day").bold()
                        }else {
                            Text("Productivity").bold()
                        }
                    }.padding()
                    
                        
                }
            
        }.onAppear(){
            if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                average = experiment.getAverageQualityDouble()
            }else {
                average = experiment.getAverageProductivityDouble()
            }
        }
    }
    func color()-> Color{
        switch(average){
        case 0..<1:
            return .red
        case 1..<3:
            return .orange
        case 3..<6:
            return .yellow
        case 6..<11:
            return .green
        default:
            return .white
        }
    }
}

struct SimpleSleepDependentHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSleepDependentHistory(experiment: SleepExperiment.bedtimeSampleExperiment, dependentVariable: .quality)
    }
}
