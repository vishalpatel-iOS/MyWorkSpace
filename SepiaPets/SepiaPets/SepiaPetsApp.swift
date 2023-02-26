//
//  SepiaPetsApp.swift
//  SepiaPets
//
//  Created by codiste on 25/02/23.
//

import SwiftUI

@main
struct SepiaPetsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                StartUpVC()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
