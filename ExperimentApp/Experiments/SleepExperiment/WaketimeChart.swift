//
//  WaketimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct WaketimeChart: View {
    @State var picker: pickerValues = .none
    enum pickerValues : String{
        case none = ""
        case quality = "Quality"
        case productivity = "Productivity"
        case compare = "Compare"
    }
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment:.leading){
            Text(experiment.getTitle())
            if(experiment.dependentVariable == .both){
                Picker("Chart Y axis",selection: $picker){
                    Text("Quality").tag(pickerValues.quality)
                    Text("Productivity").tag(pickerValues.productivity)
                    Text("Compare").tag(pickerValues.compare)
                }
                .pickerStyle(.segmented)
                .onAppear(){
                    picker = .quality
                }
            }
            Chart(experiment.entries){ entry in
                if(experiment.dependentVariable == .quality || picker == .quality || picker == .compare){
                    PointMark(
                        x: .value("Waketime", convertDate(from: entry.waketime)),
                        y: .value("Quality", entry.quality)
                    ).foregroundStyle(.red)
                }
                if(experiment.dependentVariable == .productivity || picker == .productivity || picker == .compare){
                    PointMark(
                        x: .value("Waketime", convertDate(from: entry.waketime)),
                        y: .value("Productivity", entry.productivity)
                    ).foregroundStyle(.blue)
                }
                
            }
            
            .chartXScale()
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Waketime")
            .chartForegroundStyleScale(legendStyle())
            .frame(height: 300)
            Spacer().frame(minHeight:100)
        }
        .padding()
    }
    
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
    private func legendStyle() -> KeyValuePairs<String, Color> {
        if (experiment.dependentVariable == .both) {
            return [
                "Productivity": .blue, "Quality": .red
            ]
        } else {
            return [:] // Empty KeyValuePairs if the condition is not met
        }
    }
    func convertDate(from date: Date) -> Date{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        let newDate = dateformatter.date(from: dateString)
        return newDate!
        
    }
    
    
}

struct WaketimeChart_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeChart(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
