//
//  FoodiApp.swift
//  Foodi
//
//  Created by Braden Smith on 2/28/24.
//

import SwiftUI

@main
struct FoodiApp: App {
    
    //Connect the App Delegate to our SwiftUI lifecycle
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RecipeListView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Initialize the Appsmiths Font Package
        self.registerFonts()
        
        return true
    }
    
    ///This function initializes and registers the custom DMSans font i added.
    private func registerFonts() {
        guard let urls: [URL] = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil) else {
            print(NSError(domain: "io.appsmiths.foodi", code: 404, userInfo: [NSLocalizedDescriptionKey: "No fonts were found in the bundle."]))
            return
        }
        for fontName in urls {
            CTFontManagerRegisterFontsForURL(fontName as CFURL, CTFontManagerScope.process, nil)
        }
    }
    
}
