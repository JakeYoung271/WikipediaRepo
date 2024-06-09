//
//  TriviaWikiApp.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Database.database().isPersistenceEnabled = true
    copyPreloadedFilesToDocuments()
      Task { await DataManager.shared.updateRatings()}
    return true
  }
    func applicationDidEnterBackground(_ application: UIApplication) {
        HistoryManager.shared.save()
        }

    func applicationWillTerminate(_ application: UIApplication) {
        HistoryManager.shared.save()
        }
}

class Globals : ObservableObject {
    static var shared = Globals()
    @Published var loading : Bool
    @Published var firstTime : Bool
    @Published var showTutorial : Bool
    @Published var BrowseLoadingText: String
    private init(){
        loading = true
        firstTime = UserDefaultsManager.shared.isFirstLaunch
        showTutorial = UserDefaultsManager.shared.isFirstLaunch
        BrowseLoadingText = "Uh oh, it looks like we ran out of questions to show you. Please email me at youngjakecubes@g.ucla.edu so I can go upload some more."
    }
    
    
    func initialize(){
        Task {
            await self.initializeGlobals()
        }
    }
    
    @MainActor
    func initializeGlobals() async{
        _ = qRec.pub
        _ = HistoryManager.shared
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loading = false
        }
    }
}


@main
struct TriviaWikiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
        }
    }
}
