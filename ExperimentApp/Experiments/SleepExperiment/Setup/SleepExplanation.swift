//
//  SleepExplanation.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/24/24.
//

import SwiftUI

struct SleepExplanation: View {
    @Binding var index: Int
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                Text("Overview").font(.largeTitle).bold()
                VStack(alignment:.leading){
                    Text("What will you be doing in this experiment?")
                        .padding(.vertical, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    Text("The question we'll try to answer is: \"What are the best sleeping habits for you?\" ").padding(.vertical, 1)
                    Text("First, you'll choose how you'll be tracking your sleep.").padding(.vertical, 1)
                    Text("Then, you'll choose what type of outcome to track, depending on which you think is more important. ").padding(.vertical, 1)
                    Text("After you enter enough data, we'll calculate the best sleeping habits for you!").padding(.vertical, 1)
                }
                Text("Important note:").padding(.vertical, 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                Text("This technically isn't an experiment!").padding(.vertical, 1)
                Text("Because we're not telling you to intentionally sleep at different times, we aren't actually doing an experiment with your sleep.").padding(.vertical, 1)
                Text("We decided on a correlation design because intentionally changing our sleeping patterns might cause more harm than good.").padding(.vertical, 1)
                Text("Despite being unable to establish causality, we'll still be able to find patterns that predict better outcomes.")
                Spacer()
                HStack{
                    Spacer()
                    Button("Let's begin"){
                        withAnimation{
                            index = 2
                        }
                    }
                }
            }.padding()
        }
    }
}

struct SleepExplanation_Previews: PreviewProvider {
    static var previews: some View {
        SleepExplanation(index: .constant(0))
    }
}
