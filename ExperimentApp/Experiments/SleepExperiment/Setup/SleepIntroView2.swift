//
//  SleepIntroView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/20/24.
//

import SwiftUI

struct SleepIntroView2: View {
    @State var currentIndex = 1
    @GestureState private var dragOffSet: CGFloat = 0
    @Binding var sleepExperiments: [SleepExperiment]
    @Environment(\.presentationMode) var presentationMode
    @State var goalEntries: Int = 5  
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    @State var independentVariable: SleepExperiment.IndependentVariable = .bedtime //ask user if
    @State var index: Int = 0
    
    @State var name: String = ""
    @Binding var selectedTabIndex: Int
    
    @State var isCreatingExperiment: Bool = false
    var body: some View {
        VStack{
            ZStack{
                SleepSetup1(independentVariable: $independentVariable, index: $currentIndex).opacity(currentIndex == 1 ? 1.0: 0.5)
                    .offset(x: CGFloat(1-currentIndex) * 380).padding()
                SleepSetup2(dependentVariable: $dependentVariable, index: $currentIndex).opacity(currentIndex == 2 ? 1.0: 0.5)
                    .offset(x: CGFloat(2-currentIndex) * 380).padding()
                SleepSetup3(goalEntries: $goalEntries, index: $currentIndex).opacity(currentIndex == 3 ? 1.0: 0.5)
                    .offset(x: CGFloat(3-currentIndex) * 380).padding()
                
                
                SleepSetup4(finishAction: {
                    sleepExperiments.append(SleepExperiment(goalEntries: goalEntries, dependentVariable: dependentVariable, independentVariable: independentVariable, entries: [], name: name))
                    isCreatingExperiment = true
                    presentationMode.wrappedValue.dismiss()
                    
                }, independentVariable: independentVariable, dependentVariable: dependentVariable).onDisappear(){
                    selectedTabIndex = 0
                }.opacity(currentIndex == 4 ? 1.0: 0.5)
                    .offset(x: CGFloat(4-currentIndex) * 380).padding()
                
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
