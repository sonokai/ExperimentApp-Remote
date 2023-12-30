//
//  EntryProgressView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI

struct EntryProgressView: View {
    let count: Int
    let needed: Int
    let text: String
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "lock.fill")
                Text("You need \(needed-count) more entries \(text)")
            }
            ProgressView(value: Double(count)/Double(needed)) { Text("\(count*100/needed)% progress") }.padding()
        }
    }
}

struct EntryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        EntryProgressView(count:5, needed: 7, text: "to create this chart")
    }
}
