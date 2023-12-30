//
//  BedtimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct BedtimePicker: View {
    @Binding var experiment: SleepExperiment
    @State var bedtime: Date = Calendar.current.startOfDay(for: Date())
    @Binding var timeSelectorPopOver: Bool
    @State var interacted: Bool = false
    var body: some View {
        HStack{
            Image(systemName: "bed.double")
            if let initialValue = experiment.newSleepEntry.bedtime {
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
                    .onChange(of: bedtime, perform: { newValue in
                        experiment.newSleepEntry.bedtime = newValue
                    }).onAppear(){
                        bedtime = initialValue
                    }
            } else {
                HStack{
                    Text("Bedtime")
                    Spacer().frame(maxWidth: .infinity)
                    Button(action: {
                        withAnimation{
                            timeSelectorPopOver.toggle()
                            interacted = true
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
                                Text("   ")
                                    .foregroundColor(timeSelectorPopOver ? .blue : .black)
                            }
                        }
                    }).popover(isPresented: $timeSelectorPopOver, attachmentAnchor: .point(.leading), arrowEdge: .trailing, content: {
                        CustomDatePicker(date: $bedtime, timeSelectorPopOver: $timeSelectorPopOver)
                            .presentationCompactAdaptation(.popover)
                            .padding()
                    })
                }.onChange(of: bedtime, perform: { newValue in
                    experiment.newSleepEntry.bedtime = newValue
                })
            }
        }
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: bedtime)
    }
}

struct BedtimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            BedtimePicker(experiment: .constant(SleepExperiment.bedtimebothExperiment), timeSelectorPopOver: .constant(false))
        }
    }
}
