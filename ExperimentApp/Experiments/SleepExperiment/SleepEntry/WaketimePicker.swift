//
//  BedtimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct WaketimePicker: View {
    @Binding var experiment: SleepExperiment
    
    @State var waketime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    @Binding var timeSelectorPopOver: Bool
    @State var interacted: Bool = false
    var body: some View {
        HStack{
            Image(systemName: "bed.double")
            if let initialValue = experiment.newSleepEntry.bedtime {
                DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
                    .onChange(of: waketime, perform: { newValue in
                        experiment.newSleepEntry.waketime = newValue
                    }).onAppear(){
                        waketime = initialValue
                    }
            } else {
                HStack{
                    Text("Wake time")
                    Spacer().frame(maxWidth: .infinity)
                    Button(action: {
                        withAnimation{
                            timeSelectorPopOver.toggle()
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(UIColor.systemGray6))
                                .frame(width: 100)
                            if(interacted){
                                Text(getTime()).foregroundColor(timeSelectorPopOver ? .blue : .black)
                                    .foregroundColor(timeSelectorPopOver ? .blue : .black)
                            }else {
                                Text("    ")
                                    .foregroundColor(timeSelectorPopOver ? .blue : .black)
                            }
                        }
                    }).popover(isPresented: $timeSelectorPopOver, attachmentAnchor: .point(.leading), arrowEdge: .trailing, content: {
                        CustomDatePicker(date: $waketime, timeSelectorPopOver: $timeSelectorPopOver)
                            .presentationCompactAdaptation(.popover)
                            .padding()
                    })
                }.onChange(of: waketime, perform: { newValue in
                    experiment.newSleepEntry.waketime = newValue
                })
            }
        }
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: waketime)
    }
}

struct WaketimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            WaketimePicker(experiment: .constant(SleepExperiment.waketimeSampleExperiment), timeSelectorPopOver: .constant(false))
        }
    }
}
