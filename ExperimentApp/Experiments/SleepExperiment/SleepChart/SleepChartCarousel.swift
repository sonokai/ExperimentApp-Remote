//
//  SleepChartCarousel.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/6/24.
//

import SwiftUI
import Charts

struct SleepChartCarousel: View {
    @State var currentIndex = 0
    @GestureState private var dragOffSet: CGFloat = 0
    var experiment: SleepExperiment
    @State var availableCharts: [AnyView] = []
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    ForEach(0..<availableCharts.count, id:\.self){ index in
                        self.availableCharts[index]
                            .opacity(currentIndex == index ? 1.0: 0.5)
                            .offset(x: CGFloat(index-currentIndex) * 380)
                    }
                }.padding()
                HStack(spacing: 10){
                    ForEach(availableCharts.indices, id:\.self){ index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1:0.1))
                            .frame(width: 10, height: 10)
                    }
                }
            }.gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold{
                            withAnimation{
                                currentIndex = max(0,currentIndex-1)
                            }
                        } else if value.translation.width <  -threshold{
                            withAnimation{
                                currentIndex = min(availableCharts.count-1,currentIndex+1)
                            }
                        }
                    })
            )
        }.onAppear(){
            availableCharts = []
            
            switch(experiment.independentVariable){
            case .bedtime:
                availableCharts.append(AnyView(SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .quality)))
                availableCharts.append(AnyView(SimpleBedtimeHistory(experiment: experiment)))
                
            case .waketime:
                availableCharts.append(AnyView(SimpleWaketimeHistory(experiment: experiment)))
                availableCharts.append(AnyView(SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .quality)))
            case .hoursSlept:
                availableCharts.append(AnyView(SimpleSleepTimeHistory(experiment: experiment)))
                availableCharts.append(AnyView(SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .quality)))
            case .both:
                availableCharts.append(AnyView(SimpleBedtimeHistory(experiment: experiment)))
                availableCharts.append(AnyView(SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .quality)))
                availableCharts.append(AnyView(SimpleWaketimeHistory(experiment: experiment)))
                availableCharts.append(AnyView(SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .quality)))
                availableCharts.append(AnyView(SimpleSleepTimeHistory(experiment: experiment)))
                availableCharts.append(AnyView(SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .quality)))
            }
            
            if(experiment.dependentVariable == .quality || experiment.dependentVariable == .both){
                availableCharts.append(AnyView(SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .quality)))
            }
            if(experiment.dependentVariable == .productivity || experiment.dependentVariable == .both){
                availableCharts.append(AnyView(SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .productivity)))
            }
           
            
        }
    }
}

struct SleepChartCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SleepChartCarousel(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
