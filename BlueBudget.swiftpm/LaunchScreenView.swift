//
//  LaunchScreenView.swift
//  BlueBudget
//
//  Created by Isabela Bastos Jastrombek on 22/02/24.
//

import SwiftUI

struct LaunchScreenView: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image("BlueBudgetTransparent")
                        .resizable()
                        .frame(width: 200, height: 191)
                    Text("BlueBudget")
                        .font(.title)
                        .foregroundStyle(.white)
                        .bold()
                        .shadow(color: Color("ShadowColor").opacity(0.8), radius: 8, x: 0, y: 8)
                }
                Spacer()
            }
            Spacer()
        }
        .background(LinearGradient(colors: [Color("Blue1"), Color("Blue3")], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    LaunchScreenView()
}
