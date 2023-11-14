//
//  BedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct BedtimeChart: View {
    var experiment: SleepExperiment
    @State var picker: pickerValues = .none
    var interval: Date
    var size: Int
    var showRange: Bool = false
    @Binding var dependentVariable: SleepExperiment.DependentVariable
    enum pickerValues : String{
        case none = ""
        case quality = "Quality"
        case productivity = "Productivity"
        case compare = "Compare"
    }
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
            if(experiment.dependentVariable == .both){
                switch(picker){
                case .none:
                    Text("Loading chart...")
                case .quality:
                    Text("Bedtime vs. quality of day")
                case .productivity:
                    Text("Bedtime vs. productivity")
                case .compare:
                    Text("Bedtime vs. quality of day and productivity")
                }
            }else{
                Text(experiment.getTitle())
            }
            
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
                    if(experiment.dependentVariable == .quality || picker == .quality || picker == .compare ){
                        PointMark(
                            x: .value("Bedtime", convertDate(from: entry.bedtime)),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(experiment.dependentVariable == .productivity || picker == .productivity || picker == .compare){
                        PointMark(
                            x: .value("Bedtime", convertDate(from: entry.bedtime)),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
                
                
            }
            
            .chartXScale()
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Bedtime")
            .chartForegroundStyleScale(legendStyle())
            .frame(height:300)
            Spacer()
        }
        .padding()
        
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
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
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

struct BedtimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        BedtimeChart(experiment: SleepExperiment.bedtimeSampleExperiment, interval: testInterval, size: 15, dependentVariable: .constant(.quality))
    }
}
