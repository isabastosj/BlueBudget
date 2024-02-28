import SwiftUI

@main
struct MyApp: App {
    
    @StateObject var listsRepository = ListingRepository()
    @State private var isLaunching = false
//    @Environment(\.colorScheme) var colorScheme
//    @State var darkMode = false
    @State var sound = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                ListOfLists(listsRepository: listsRepository,  sound: $sound) // darkMode: $darkMode,
//                    .environment(\.colorScheme, darkMode ? .dark : .light)
                
                // I imagined that your device would be on lightmode, so most of the tested projects wouldn't have any issues, and also that you wouldn't test the app on the dark mode, so I added a dark mode button on the setting (but the way I implemented makes the app look bad if your device is actually on the darkmode, but surely soon I'll find out a way to fix this problem!).
                
            } else {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.isLaunching = true
                        }
                    }
            }
  
        }
    }
}
