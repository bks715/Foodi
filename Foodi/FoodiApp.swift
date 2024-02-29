//
//  FoodiApp.swift
//  Foodi
//
//  Created by Braden Smith on 2/28/24.
//

import SwiftUI
import AppsmithsEssentials

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
    
    ///This function initializes and registers the fonts included in my custom Appsmiths Package.
    private func registerFonts(){
        //Run in Do-Catch Block to handle errors
        do{
            try AppsmithsEssentials.registerFonts()
        }catch{
            //If the fonts don't register print the error
            print(error)
        }
    }
    
}
