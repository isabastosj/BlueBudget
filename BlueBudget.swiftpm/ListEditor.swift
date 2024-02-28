import SwiftUI

struct ListEditor: View {
    
    @Binding var list: Listing
    @State var isNew = false
    
    @Environment(\.dismiss) private var dismiss
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var isPickingSymbol = false
    
    @State private var isEditingList = false
    
    @State var oldName = " "
    
    @Binding var darkMode: Bool
    @Binding var sound: Bool
    
    var totalPrice: Double {
        var num = 0.0
        for item in list.items {
            if item.isCompleted {
                num += Double(item.price) * Double(item.quantity)
            }
        }
        return num
    }
    
    @ObservedObject var audioManager = AudioManager()
    
    @State private var howmany: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                
                if list.items.isEmpty {
                    Text("Create a new item!")
                        .foregroundStyle(.secondary)
                } else {
                    
                    Rectangle()
                        .fill(Color(uiColor: .clear))
                        .frame(height: 90)
                    
                    List {
                        
                        Section {
                            
                            ForEach($list.items) { $item in
                                if !item.isCompleted {
                                    ItemRow(item: $item, sound: $sound)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                list.items.remove(atOffsets: indexSet)
                            })
                            .listRowBackground(Color("ListingColor1"))
                            .listRowSeparatorTint(Color("TextColor").opacity(0.2))
                            
                            ForEach($list.items) { $item in
                                if item.isCompleted {
                                    ItemRow(item: $item, sound: $sound)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                list.items.remove(atOffsets: indexSet)
                            })
                            .listRowBackground(Color("ListingColor1"))
                            .listRowSeparatorTint(Color("TextColor").opacity(0.2))
                            
                            
                        } header: {
                            HStack {
                                Text("ITEM")
                                
                                
                                Spacer()
                                
                                Text("QTY")
                                    .padding(.trailing, 24)
                                
                                Text("PRICE")
                                    .padding(.trailing)
                                
                            }
                        }
                        
                    }
                    
                    .scrollContentBackground(.hidden)
                    .shadow(color: Color("ShadowColor").opacity(0.04), radius: 5, x: 0, y: 10)
                    
                    Spacer()
                        .frame(height: 96)
                }
                
                
            }
            .onAppear {
                howmany = list.items.count
            }
            .onChange(of: list.items.count, perform: { newValue in
                if newValue < howmany {
                    if sound {
                        audioManager.playTrash()
                    }
                }
                howmany = newValue
            })
            .ignoresSafeArea()
            .background(Color("ListingColor2"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("ListingColor2"), for: .automatic)
            .toolbarRole(.editor)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Text(list.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                }
                
                ToolbarItem {
                    Button(action: {
                        if sound {
                            audioManager.playTick()
                        }
                        
                        oldName = list.title
                        
                        isEditingList.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("Blue2"))
                            
                            Image(systemName: "pencil")
                                .font(.callout)
                                .padding(6)
                                .foregroundColor(Color("ListingColor2"))
                                .fontWeight(.medium)
                        }
                        .padding(.top, 10)
                    }
                    
                }
                
                ToolbarItem {
                    Button(action: {
                        if sound {
                            audioManager.playTick()
                        }
                        let newItem = Item(text: "", isNew: true)
                        list.items.append(newItem)
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("Blue2"))
                            
                            Image(systemName: "plus")
                                .font(.callout)
                                .padding(6)
                                .foregroundColor(Color("ListingColor2"))
                                .fontWeight(.medium)
                        }
                        .padding(.top, 10)
                    }
                }
                
            }
            .sheet(isPresented: $isEditingList) {
                NavigationStack {
                    
                    NewListView(list: $list, darkMode: $darkMode)
                        .navigationTitle("Editing list")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            
                            ToolbarItem(placement: .cancellationAction) {
                                Button {
                                    list.title = oldName
                                    isEditingList = false
                                } label: {
                                    Label("cancel", systemImage: "xmark")
                                        .labelStyle(.iconOnly)
                                }
                            }
                            
                            ToolbarItem {
                                Button {
                                    isEditingList = false
                                } label: {
                                    Label("Done", systemImage: "checkmark")
                                        .labelStyle(.iconOnly)
                                }
                                .disabled(list.title.isEmpty)
                            }
                        }
                    
                }
                .presentationDetents([.medium])
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    HStack {
                        Text("Total:")
                            .font(.title2)
                            .bold()
                            .padding(16)
                        
                            .padding(.horizontal, 24)
                        
                        Spacer()
                        
                        let formattedTotalPrice = String(format: "%.2f", totalPrice)
                        Text("\(formattedTotalPrice)")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                    }
                    
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Blue2"))
                            .shadow(color: Color("ShadowColor").opacity(0.3), radius: 8, x: 0, y: 10)
                        
                    }
                }
                .padding()
            }
        }
    }
}

struct ListEditor_Previews: PreviewProvider {
    static var previews: some View {
        ListEditor(list: .constant(Listing()), isNew: true, darkMode: .constant(false), sound: .constant(true))
    }
}
