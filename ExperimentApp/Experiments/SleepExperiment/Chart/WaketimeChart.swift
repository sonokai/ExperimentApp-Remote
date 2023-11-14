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
    var interval: Date
    var size: Int
    var showRange: Bool = false
    @Binding var dependentVariable: SleepExperiment.DependentVariable
    
    var body: some View {
        VStack(alignment:.leading){
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
                .onChange(of: picker){ newValue in
                    if(newValue == .quality){
                        dependentVariable = .quality
                    }
                    if(newValue == .productivity){
                        dependentVariable = .productivity
                    }
                }
            }
            Text(experiment.getTitle())
            
            Chart(){
                if(showRange){
                    RectangleMark(
                        xStart: .value("Start of interval", convertDate(from: interval)),
                        xEnd: .value("End of best interval", addMinutesToDate(date: interval, minutesToAdd: size)),
                        yStart: nil,
                        yEnd: nil
                    ).foregroundStyle(.green)
                }
                ForEach(experiment.entries){ entry in
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
                
            }
            
            .chartXScale()
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Waketime")
            .chartForegroundStyleScale(legendStyle())
            .frame(height: 300)
            
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
    func addMinutesToDate(date: Date, minutesToAdd: Int) -> Date {
        let calendar = Calendar.current
        let updatedDate = calendar.date(byAdding: .minute, value: minutesToAdd, to: date)
        return convertDate(from: updatedDate!)
        
    }
    
    
}

struct WaketimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        WaketimeChart(experiment: SleepExperiment.waketimeSampleExperiment, interval: testInterval, size: 15, dependentVariable: .constant(.productivity))
    }
}
