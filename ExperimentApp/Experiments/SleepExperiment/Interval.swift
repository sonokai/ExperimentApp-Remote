//
//  Tester.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/20/23.
//

import SwiftUI

struct Interval: View {
    
    var experiment: SleepExperiment
    @Binding var bestStartingInterval: Date
    @Binding var intervalSize: Int
    
    var body: some View {
        
        VStack{
            
            HStack{
               // Text("Best bedtime: \(convertDate(from: bestStartingInterval)) - \(addMinutesToDate(date: bestStartingInterval, minutesToAdd: intervalSize))")
                
                
                
            }.onAppear(){
                if let interval = experiment.getOptimalBedtimeInterval(size: intervalSize){
                    bestStartingInterval = interval
                } else {
                    bestStartingInterval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
                }
            }
            SliderView(name: "Interval size (minutes)",value: $intervalSize, lowValue: 5, highValue: 30)
                .onChange(of: intervalSize){ _ in
                if let interval = experiment.getOptimalBedtimeInterval(size: intervalSize){
                    bestStartingInterval = interval
                } else {
                    bestStartingInterval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
                }
            }
            
     
        }
    }
    func convertDate(from date: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
    func addMinutesToDate(date: Date, minutesToAdd: Int) -> String {
            let calendar = Calendar.current
            let updatedDate = calendar.date(byAdding: .minute, value: minutesToAdd, to: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: updatedDate ?? date)
    }
}

struct Tester_Previews: PreviewProvider {
    static let testDate = Calendar.current.date(bySettingHour: 15, minute: 10, second: 0, of: Date())!
    static var previews: some View {
        Interval(experiment: SleepExperiment.bedtimeSampleExperiment, bestStartingInterval: .constant(Date()), intervalSize: .constant(15))
    }
}
