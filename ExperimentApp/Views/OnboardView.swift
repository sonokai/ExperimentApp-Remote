//
//  OnboardView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/21/24.
//

import SwiftUI

struct OnboardView: View {
    @Binding var isFirstLaunch: Bool
    var action: () -> Void
    var body: some View {
        VStack{
            Text("What does logarithm do?")
            
            Button("Let's begin"){
                action()
                isFirstLaunch = false
                print("User onboard complete")
            }
        }
        
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(isFirstLaunch: .constant(false), action: {})
    }
}
