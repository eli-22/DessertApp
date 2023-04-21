//
//  LoadingSpinner.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import SwiftUI

struct LoadingSpinner: View  {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(3)
        }
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner()
    }
}
