import SwiftUI

struct ListOfLists: View {
    @ObservedObject var listsRepository: ListingRepository
    @State private var isAddingNewList = false
    @State private var newList = Listing()
    
    @State private var selection: Listing? 
    
    @State private var isEditingSettings = false
    
    @ObservedObject var audioManager = AudioManager()
    
    @Environment(\.colorScheme) var colorScheme
    
//    @Binding var darkMode: Bool
    @Binding var sound: Bool
    
    @State private var howmany: Int = 0
    
    @AppStorage("showOnboarding") private var showOnboarding = true
    
    var body: some View {
        
        NavigationSplitView {
            VStack {
                if listsRepository.lists.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("Create a new list!")
                                    .foregroundStyle(.secondary)
                                
                                Button {
                                    if sound {
                                        audioManager.playTick()
                                    }
                                    newList = Listing()
                                    isAddingNewList = true
                                } label: {
                                    HStack {
                                        Image(systemName: "plus")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .fontWeight(.medium)
                                        
                                        Text("Add a list")
                                            .foregroundStyle(.white)
                                    }
                                    .background {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Blue2"))
                                            .frame(width: 130, height: 40)
                                    }
                                }
                                .padding(.top)
                            }
                                
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        
                        Button {
                            if sound {
                                audioManager.playTick()
                            }
                            newList = Listing()
                            isAddingNewList = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue2"))
                                    .frame(height: 40)
                                
                                HStack {
                                    Image(systemName: "plus")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .fontWeight(.medium)
                                    
                                    Text("Add a list")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                        
                        List(selection: $selection) {
                            
                            ForEach(listsRepository.lists.reversed(), id: \.self) { list in
                                ListRow(list: list)
                                    .tag(list)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            selection = nil
                                            listsRepository.deleteList(id: list.id)
                                            if !listsRepository.lists.isEmpty {
                                                selection = listsRepository.lists.last
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .padding(.vertical, 6)
                            }
                            
                        }
                        .listStyle(.automatic)
                        .scrollContentBackground(.hidden)
                        .listSectionSeparatorTint(Color.secondary)
                        .listSectionSeparator(.hidden, edges: .top)
                        
                    }
                }
                    .background(Color("ListingColor3"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(Color("ListingColor3"), for: .automatic)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("BlueBudget")
                                .font(.title)
                                .bold()
                                .padding(.top, 15)
                        }
                        
                        ToolbarItem {
                            
                            Button(action: {
                                if sound {
                                    audioManager.playTick()
                                }
                                isEditingSettings.toggle()
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color("Blue2"))
                                    
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 13))
                                        .padding(6)
                                        .foregroundColor(Color("ListingColor2"))
                                        .fontWeight(.medium)
                                }
                                .padding(.top, 10)
                            }
                            
                        }
                        
                    }
                    .fullScreenCover(isPresented: $showOnboarding) {
                        ZStack {
                            OnboardingView(showOnboarding: $showOnboarding, sound: $sound)
                        }
                        
                    }
                    .sheet(isPresented: $isAddingNewList) {
                        NavigationStack {
                            NewListView(list: $newList, isNew: true) // , darkMode: $darkMode
                                .navigationTitle("New list")
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button {
                                            isAddingNewList = false
                                        } label: {
                                            Label("cancel", systemImage: "xmark")
                                                .labelStyle(.iconOnly)
                                        }
                                    }
                                    ToolbarItem {
                                        Button {
                                            listsRepository.createList(list: newList)
                                            selection = listsRepository.lists.last
                                            
                                            isAddingNewList = false
                                        } label: {
                                            Label("Done", systemImage: "checkmark")
                                                .labelStyle(.iconOnly)
                                        }
                                        .disabled(newList.title.isEmpty)
                                    }
                                }
                        }
                        .presentationDetents([.medium])
                    }
                    .sheet(isPresented: $isEditingSettings) {
                        NavigationStack {
                            SettingsView(sound: $sound, showOnboarding: $showOnboarding) // , darkMode: $darkMode
                                .navigationTitle("Settings")
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button {
                                            isEditingSettings = false
                                        } label: {
                                            Label("cancel", systemImage: "xmark")
                                                .labelStyle(.iconOnly)
                                        }
                                    }
                                    
                                    ToolbarItem {
                                        Button {
                                            
                                            isEditingSettings = false
                                        } label: {
                                            Label("Done", systemImage: "checkmark")
                                                .labelStyle(.iconOnly)
                                        }
                                    }
                                }
                        }
                        .presentationDetents([.medium])
                    }
            } detail: {
                ZStack {
                    if let list = selection, let listBinding = listsRepository.getBindingToList(list) {
                        ListEditor(list: listBinding, sound: $sound) //, darkMode: $darkMode
                    }
                    else {

                        VStack {
                            if listsRepository.lists.isEmpty {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        
                                        VStack {
                                            Text("Welcome to BlueBudget.")
                                                .font(.title)
                                                .padding(.bottom, 24)

                                            
                                            Text("Create a new list!")
                                                .foregroundStyle(.secondary)
                                            
                                            Button {
                                                if sound {
                                                    audioManager.playTick()
                                                }
                                                newList = Listing()
                                                isAddingNewList = true
                                            } label: {
                                                HStack {
                                                    Image(systemName: "plus")
                                                        .font(.caption)
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.medium)
                                                    
                                                    Text("Add a list")
                                                        .foregroundStyle(.white)
                                                }
                                                .background {
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .fill(Color("Blue2"))
                                                        .frame(width: 130, height: 40)
                                                }
                                            }
                                            .padding(.top)
                                        }
                                        
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .background(Color("ListingColor2"))
                    }
                }
                
                .background(Color("ListingColor2"))
            }
            .onAppear(perform: {
                selection = listsRepository.lists.last
            })
            .environmentObject(listsRepository)
            .onAppear {
                howmany = listsRepository.lists.count
            }
            .onChange(of: listsRepository.lists.count, perform: { newValue in
                if newValue < howmany {
                    if sound {
                        audioManager.playTrash()
                    }
                }
                howmany = newValue
            })
        
        }
    }
    
    struct ListOfLists_Previews: PreviewProvider {
        static var previews: some View {
            ListOfLists(listsRepository: ListingRepository(),  sound: .constant(true)) //darkMode: .constant(false),
        }
    }
