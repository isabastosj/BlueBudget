//
//  OnboardingView.swift
//  BlueBudget
//
//  Created by Isabela Bastos Jastrombek on 24/02/24.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var audioManager = AudioManager()
    @Binding var showOnboarding: Bool
    @Binding var sound: Bool
    var body: some View {
        VStack {
            
            TabView() {
                OnboardingView1()
                OnboardingView2()
                OnboardingView3(showOnboarding: $showOnboarding, sound: $sound)
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
            .tabViewStyle(PageTabViewStyle())
            .tabViewStyle(PageTabViewStyle())
                    .onAppear {
                      setupAppearance()
                    }
            
        }
        .background(LinearGradient(colors: [.white, Color("OnboardingColor"), Color("OnboardingColor")], startPoint: .top, endPoint: .bottom))
        
    }
    func setupAppearance() {
          UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("Blue3"))
          UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("Blue3")).withAlphaComponent(0.3)
        }
}

struct OnboardingView1: View {
    var body: some View {
        VStack {
            
            Text("Stay Organized")
                .font(.largeTitle)
                .foregroundStyle(Color("Blue3"))
                .bold()
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 8, x: 0, y: 8)
            
            Image("squirrel1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 700)
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 6, x: 0, y: 10)
                
            
            
            Text("Create and organize multiple lists.")
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.title2)
            
        }
        .padding(.bottom, 56)
    }
}

struct OnboardingView2: View {
    var body: some View {
        VStack {
            
            Text("Stay on Budget")
                .font(.largeTitle)
                .foregroundStyle(Color("Blue3"))
                .bold()
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 8, x: 0, y: 8)
            
            Image("squirrel2")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 700)
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 6, x: 0, y: 10)
                
            
            
            Text("Add items, quantities and track prices as you shop.")
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.title2)
            
        }
        .padding(.bottom, 56)
    }
}

struct OnboardingView3: View {
    @ObservedObject var audioManager = AudioManager()
    @Binding var showOnboarding: Bool
    @Binding var sound: Bool
    var body: some View {
        VStack {
            
            Text("Get Started")
                .font(.largeTitle)
                .foregroundStyle(Color("Blue3"))
                .bold()
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 8, x: 0, y: 8)
            
            Image("squirrel3")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 700)
                .shadow(color: Color("ShadowColor").opacity(0.2), radius: 6, x: 0, y: 10)
                
            
            
            
            Button(action: {
                if sound {
                    audioManager.playTick()
                }
                showOnboarding.toggle()
            }) {
                
                Text("Let's go!")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("Blue2"))
                            
                    }
            }
            .shadow(color: Color("ShadowColor").opacity(0.2), radius: 6, x: 0, y: 6)
            
        }
        .padding(.bottom, 56)
    }
}

#Preview {
    OnboardingView(showOnboarding: .constant(true), sound: .constant(true))
}
