//
//  NewListView.swift
//  MangoList
//
//  Created by Isabela Bastos Jastrombek on 22/02/24.
//

import SwiftUI

struct NewListView: View {
    
    @Binding var list: Listing
    @State var isNew = false
    
    @Environment(\.dismiss) private var dismiss
//    @FocusState var focusedItem: Item?
    @State private var isPickingSymbol = false
//    @Binding var darkMode: Bool
    
    var body: some View {
        Form {
            Section("List Title") {
                TextField("New List...", text: $list.title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .listRowBackground(Color("ListingColor1"))
            
        }
        .padding(.horizontal, 16)
        .scrollContentBackground(.hidden)
        .background(Color("ListingColor2"))
//        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    NewListView(list: .constant(Listing()), isNew: true) //, darkMode: .constant(false)
}
