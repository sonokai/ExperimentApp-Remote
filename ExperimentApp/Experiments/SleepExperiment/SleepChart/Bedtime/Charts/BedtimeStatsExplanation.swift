//
//  BedtimeStatsExplanation.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import SwiftUI

struct BedtimeStatsExplanation: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 15){
                VStack(alignment: .leading, spacing: 5){
                    Text("How is the optimal interval calculated?").font(.headline)
                    Text("Given a range, we take 30 minute intervals and calculate the average of the dependent variable.")
                    Text("The interval with the highest average will be marked optimal.")
                    Text("Exceptions").font(.headline)
                    Text("If there are less than 2 entries in an interval, it won't be considered for an optimal interval. You can change this requirement in the settings.")
                    Text("If there are multiple intervals with the same highest average, we take the first one.")
                }.padding()
                /*
                VStack(alignment: .leading){
                    Text("What does the confidence level mean?").font(.headline)
                    Text("The confidence level is how sure we are that the bedtimes within the optimal interval are actually, on average, better than the other bedtimes.")
                    Text("In order to increase the confidence level, add more entries. If there is a best bedtime, it will become more clear the more data we have.")
                    Text("Because there's always a chance that the optimal interval happens due to random lucky days, the confidence level will never be 100%")
                    Text("Note: the confidence level is not how sure we are we have the right optimal interval.")
                }
                VStack(alignment: .leading){
                    Text("How is the confidence level calculated?").font(.headline)
                    Text("The entries are split into two groups: one which have bedtimes within the interval, and one with bedtimes outside the interval.")
                    Text("Using these two groups, a two sample t-test is conducted to test the hypothesis that the optimal interval has an average dependent variable which is greater than the other bedtimes.")
                }
                */
            }
        }
    }
}

struct BedtimeStatsExplanation_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeStatsExplanation()
    }
}
