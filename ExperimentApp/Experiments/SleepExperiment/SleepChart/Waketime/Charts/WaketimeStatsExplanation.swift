//
//  WaketimeStatsExplanation.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import SwiftUI

struct WaketimeStatsExplanation: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 15){
                VStack(alignment: .leading){
                    Text("How is the optimal interval calculated?").font(.headline)
                    Text("First, the range is calculated by taking the earliest and latest wake time.")
                    Text("Then, within each possible interval of the given size within the range, the average of the dependent variable is calculated.")
                    Text("Lastly, the interval with the highest average will be taken as the optimal one, with priority given to earlier times.")
                }
                VStack(alignment: .leading){
                    Text("What does the confidence level mean?").font(.headline)
                    Text("The confidence level is how sure we are that the wake times within the optimal interval are actually, on average, better than the other wake times.")
                    Text("In order to increase the confidence level, add more entries. If there is a best wake time, it will become more clear the more data we have.")
                    Text("Because there's always a chance that the optimal interval happens due to random lucky days, the confidence level will never be 100%")
                    Text("Note: the confidence level is not how sure we are we have the right optimal interval.")
                }
                VStack(alignment: .leading){
                    Text("How is the confidence level calculated?").font(.headline)
                    Text("The entries are split into two groups: one which have wake times within the interval, and one with wake times outside the interval.")
                    Text("Using these two groups, a two sample t-test is conducted to test the hypothesis that the optimal interval has an average dependent variable which is greater than the other wake times.")
                }
            }
        }
    }
}
