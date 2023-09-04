//
//  TimeView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct TimeView: View {
    var time: DayExperiment.Time
    var body: some View {
        Text(time.rawValue)
            .padding(4)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(time: .morning)
    }
}
