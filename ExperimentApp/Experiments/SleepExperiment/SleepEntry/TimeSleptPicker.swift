//
//  TimeSelectingButton.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct TimeSleptPicker: View {
    @Binding var experiment: SleepExperiment
    @Binding var timeSelectorPopOver: Bool
    @State var hoursSlept: Int = 0
    @State var minutesSlept: Int = 0
    @State var interacted = false
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                
                    //Image(systemName: "clock")
                    Text("Time slept")
                    Spacer().frame(maxWidth: .infinity)
                    
                    Button(action: {
                        withAnimation{
                            timeSelectorPopOver.toggle()
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(UIColor.systemGray6))
                                .frame(width: 75)
                            
                            Text(getTime())
                                .onAppear(){
                                    if let hours = experiment.newSleepEntry.hoursSlept, let minutes = experiment.newSleepEntry.minutesSlept{
                                        hoursSlept = hours
                                        minutesSlept = minutes
                                    } else {
                                        hoursSlept = 0
                                    }
                                }
                        }
                    })
                
            }
        }
        if(timeSelectorPopOver){
            TimeSelector(hours: $hoursSlept, minutes: $minutesSlept)
                .padding().onChange(of: hoursSlept) { newHoursSlept in
                    experiment.newSleepEntry.hoursSlept = newHoursSlept
                }
                .onChange(of: minutesSlept){ newMinutesSlept in
                    experiment.newSleepEntry.minutesSlept = newMinutesSlept
                }
        }
        
        
        
    }
    func getTime() -> String{
        if(minutesSlept == 0){
            return "\(hoursSlept):\(minutesSlept)0"
        }
        if(minutesSlept < 10){
            return "\(hoursSlept):0\(minutesSlept)"
        }
        return "\(hoursSlept):\(minutesSlept)"
    }
}

struct TimeSelectingButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                TimeSleptPicker(experiment: .constant(SleepExperiment.hoursSleptSampleExperiment), timeSelectorPopOver: .constant(true))
            }
        }
    }
}
