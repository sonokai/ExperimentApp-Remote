//
//  DayChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/13/23.
//

import SwiftUI
import Charts

struct DayChart: View {
    var experiment: DayExperiment
    var body: some View {
        //independent variable: different times tracked
        //depedendent varaible: time of productivity tracked
        //plan: put the average of the different times tracked into an array
        // use experiment.independentVariable.times to keep things in order
        let averages: [Double] = experiment.getAverageArray()
        VStack{
            Text("this is a chart")
            Chart(experiment.independentVariable.timesOfDay.indices, id: \.self){ index in
                BarMark(
                    x: .value("Time of day", experiment.independentVariable.timesOfDay[index].name),
                    y: .value(experiment.dependentVariable.name, averages[index])
                )
            }
        }
        
    }
    
}

struct DayChart_Previews: PreviewProvider {
    static var previews: some View {
        DayChart(experiment: DayExperiment.sampleExperiment)
    }
}
