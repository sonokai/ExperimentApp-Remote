//
//  IntEntryView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/20/23.
//

import SwiftUI

struct IntEntryView: View {
    var independentName : String
    var dependentName : String
    @Binding var entry : IntEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(entry.date)")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(independentName): \(entry.independent)", systemImage: "clock")
                    .accessibilityLabel("\(entry.independent) \(independentName)")
                Spacer()
                Label("\(dependentName): \(entry.dependent)", systemImage: "person")
                    .accessibilityLabel("\(entry.dependent)\(dependentName)")
                    
            }
            .font(.caption)
        }
        .padding()
    }
}

struct IntEntryView_Previews: PreviewProvider {
    static var previews: some View {
        IntEntryView(independentName: "Hours slept", dependentName: "Quality of day", entry: .constant(IntEntry.sampleData[0]))
    }
}
