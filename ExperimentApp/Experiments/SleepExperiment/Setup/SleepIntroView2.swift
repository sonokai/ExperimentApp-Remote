//
//  SleepIntroView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/20/24.
//

import SwiftUI
import UserNotifications

struct SleepIntroView2: View {
    @State var currentIndex = 1
    @GestureState private var dragOffSet: CGFloat = 0
    @Binding var sleepExperiments: [SleepExperiment]
    @Environment(\.presentationMode) var presentationMode
    @State var goalEntries: Int = 5  
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    @State var independentVariable: SleepExperiment.IndependentVariable = .bedtime //ask user if
    //@State var index: Int = 0
    
    @State var name: String = ""
    @Binding var selectedTabIndex: Int
    
    @State var isCreatingExperiment: Bool = false
    
    let notify = NotificationHandler()
    var body: some View {
        VStack{
            ZStack{
                SleepExplanation(index: $currentIndex).opacity(currentIndex == 1 ? 1.0: 0.5)
                    .offset(x: CGFloat(1-currentIndex) * 380).padding()
                SleepSetup1(independentVariable: $independentVariable, index: $currentIndex).opacity(currentIndex == 2 ? 1.0: 0.5)
                    .offset(x: CGFloat(2-currentIndex) * 380).padding()
                SleepSetup2(dependentVariable: $dependentVariable, index: $currentIndex).opacity(currentIndex == 3 ? 1.0: 0.5)
                    .offset(x: CGFloat(3-currentIndex) * 380).padding()
                SleepSetup3(goalEntries: $goalEntries, index: $currentIndex).opacity(currentIndex == 4 ? 1.0: 0.5)
                    .offset(x: CGFloat(4-currentIndex) * 380).padding()
                SleepSetup3_5(text: $name, index: $currentIndex).opacity(currentIndex == 5 ? 1.0: 0.5)
                    .offset(x: CGFloat(5-currentIndex) * 380).padding()
                SleepSetup4(finishAction: {
                    selectedTabIndex = 0
                    if(name == ""){
                        name = "Sleep Experiment"
                    }
                    sleepExperiments.append(SleepExperiment(goalEntries: goalEntries, dependentVariable: dependentVariable, independentVariable: independentVariable, entries: [], name: name))
                    isCreatingExperiment = true
                    notify.checkNotificationAuthorizationStatus { status in
                        switch status {
                        case .authorized:
                            print("Local notification permissions are authorized.")
                        case .denied:
                            print("Local notification permissions are denied.")
                            notify.askPermission()
                        case .notDetermined:
                            print("Local notification permissions are not determined yet.")
                            notify.askPermission()
                        case .provisional:
                            print("Local notification permissions are provisional.")
                            notify.askPermission()
                        case .ephemeral:
                            notify.askPermission()
                        @unknown default:
                            print("Unknown permission status.")
                            notify.askPermission()
                        }
                    }
                    switch independentVariable {
                    case .bedtime:
                        
                        notify.sendNotifications(hour: 22, minute: 0, duration: goalEntries, title: "Sleep Experiment - Bedtime", body: "Make sure to enter your bedtime and entry for today! :)")
                        break
                    case .waketime:
                        
                        notify.sendNotifications(hour: 6, minute: 0, duration: goalEntries, title: "Sleep Experiment", body: "Make sure to enter your waking time for today! :)", isSilent: true)

                        notify.sendNotifications(hour: 22, minute: 0, duration: goalEntries, title: "Sleep Experiment - Waketime", body: "Make sure to fill out your entry for today! :)")
                        break
                    case .both:

                        notify.sendNotifications(hour: 6, minute: 0, duration: goalEntries, title: "Sleep Experiment", body: "Make sure to enter your waking time for today! :)", isSilent: true)

                        notify.sendNotifications(hour: 22, minute: 0, duration: goalEntries, title: "Sleep Experiment", body: "Make sure to enter your bedtime and entry for today!")
                        break
                    case .hoursSlept:
                        
                        notify.sendNotifications(hour: 22, minute: 0, duration: goalEntries, title: "Sleep Experiment - Time Slept", body: "Make sure to fill out your entry for today! :)")
                    }
                    presentationMode.wrappedValue.dismiss()
                    
                }, independentVariable: independentVariable, dependentVariable: dependentVariable, index: $currentIndex).opacity(currentIndex == 6 ? 1.0: 0.5)
                    .offset(x: CGFloat(6-currentIndex) * 380).padding()
                
            }
            Spacer()
            HStack(spacing: 10){
                Circle()
                    .fill(Color.black.opacity(currentIndex == 1 ? 1:0.1))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.black.opacity(currentIndex == 2 ? 1:0.1))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.black.opacity(currentIndex == 3 ? 1:0.1))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.black.opacity(currentIndex == 4 ? 1:0.1))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.black.opacity(currentIndex == 5 ? 1:0.1))
                    .frame(width: 10, height: 10)
            }
        }/*.gesture(
            DragGesture()
                .onEnded({ value in
                    let threshold: CGFloat = 50
                    if value.translation.width > threshold{
                        withAnimation{
                            currentIndex = max(1,currentIndex-1)
                        }
                    } else if value.translation.width <  -threshold{
                        withAnimation{
                            currentIndex = min(4,currentIndex+1)
                        }
                    }
                })
        )*/
    }
}

struct SleepIntroView2_Previews: PreviewProvider {
    static var previews: some View {
        SleepIntroView2(sleepExperiments: .constant([]),selectedTabIndex: .constant(1))
    }
}
