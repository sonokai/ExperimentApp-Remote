//
//  DescriptionView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/8/23.
//

import SwiftUI

struct DescriptionView: View {
    let headline: String
    let description: String
    var body: some View {
        VStack{
            Text(headline)
                .frame(maxWidth:.infinity,alignment: .leading)
                .font(.headline)
                .padding(1)
                
            Text(description)
                .frame(maxWidth:.infinity,alignment: .leading)
                .font(.caption)
        }.padding(1)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(headline: "headline", description: "A very long description")
    }
}
