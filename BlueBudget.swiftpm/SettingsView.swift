//
//  SettingsView.swift
//  BlueBudget
//
//  Created by Isabela Bastos Jastrombek on 22/02/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var sound: Bool
//    @Binding var darkMode: Bool
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack {
            List {
                
//                Section("Appearance", content: {
//                    Toggle(isOn: $darkMode) {
//                        HStack {
//                            Image(systemName: "sun.max.fill")
//                                .font(.callout)
//                                .padding(6)
//                                .foregroundColor(Color("ListingColor2"))
//                                .fontWeight(.medium)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color("Blue2"))
//                                        .frame(width: 30, height: 30)
//                                }
//                                
//                            
//                            Text("Dark Mode")
//                                .fontWeight(.medium)
//                                .padding(.leading, 10)
//                        }
//                    }
//                    .toggleStyle(SwitchToggleStyle(tint: Color("Blue1")))
//                    .frame(height: 38)
//                })
//                .listRowBackground(Color("ListingColor1"))
                
                Section("Sound", content: {
                    Toggle(isOn: $sound) {
                        HStack {
                            Image(systemName: "speaker.wave.2")
                                .font(.callout)
                                .padding(6)
                                .foregroundColor(Color("ListingColor2"))
                                .fontWeight(.medium)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("Blue2"))
                                        .frame(width: 30, height: 30)
                                }
                            Text("Sound Effects")
                                .fontWeight(.medium)
                                .padding(.leading, 8)
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color("Blue1")))
                    .frame(height: 38)
                })
                .listRowBackground(Color("ListingColor1"))
                
                Section("Information", content: {
                    Toggle(isOn: $showOnboarding) {
                        HStack {
                            Image(systemName: "info")
                                .font(.callout)
                                .padding(6)
                                .foregroundColor(Color("ListingColor2"))
                                .fontWeight(.medium)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("Blue2"))
                                        .frame(width: 30, height: 30)
                                }
                            Text("Show Onboarding")
                                .fontWeight(.medium)
                                .padding(.leading)
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color("Blue1")))
                    .frame(height: 38)
                })
                .listRowBackground(Color("ListingColor1"))
                
            }
            .scrollContentBackground(.hidden)
            .shadow(color: Color("ShadowColor").opacity(0.02), radius: 5, x: 0, y: 10)
            .padding(.horizontal, 24)
            .padding(.vertical)
            
            Text("For the best experience, use this app on landscape!")
                .foregroundStyle(.secondary)
                .padding(.bottom, 32)
        }
        .background(Color("ListingColor2"))
//        .environment(\.colorScheme, darkMode ? .dark : .light)
        
    }
}

#Preview {
    SettingsView(sound: .constant(true), showOnboarding: .constant(false)) //  darkMode: .constant(false),
}
