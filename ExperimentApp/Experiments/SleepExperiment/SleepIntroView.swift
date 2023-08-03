//
//  SleepIntroView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import SwiftUI

struct SleepIntroView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Let's set up your sleep experiment.")
                NavigationLink(destination: SleepConfig1()){
                    Text("Begin")
                }
                
                
            }
        }
    }
}

struct SleepIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SleepIntroView()
    }
}
