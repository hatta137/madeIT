//
//  SplashScreenView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color("MIT_Black")
            
            //Image("mit_logo_white_icon_nb")
            
            Text("MIT")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SplashScreenView()
}
