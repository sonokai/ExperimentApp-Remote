//
//  BedtimeChartHeader.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/27/23.
//

import SwiftUI

struct ChartHeaderAndSettings: View {
    
    @Binding var showTheThingy: Bool
    
    var body: some View {
        Button(action: {
            showTheThingy.toggle()
        }, label: {
            Image(systemName: "gearshape.fill")
        }).font(Font.caption)
            .foregroundColor(.accentColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .overlay(
                Text("Chart"),
                alignment: .leading
            )
    }
}

struct BedtimeChartHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChartHeaderAndSettings(showTheThingy: .constant(false))
    }
}
