//
//  LoadingView.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .tint(Color.black)
        }
    }
}
