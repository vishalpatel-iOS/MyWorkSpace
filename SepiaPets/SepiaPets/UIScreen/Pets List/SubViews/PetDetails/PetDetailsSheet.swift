//
//  PetDetailsSheet.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI

struct PetDetailVC: View {
    @Environment(\.dismiss) var dismiss
    var pet: PetDetailModel
    @State var workState = WebView.WorkState.initial
    @State var urlstr = ""
    
    var body: some View {
//        WebView(url: pet.content_url ?? "")
        ZStack {
            WebView(url: self.$urlstr, workState: self.$workState)
            if workState != .done {
                ZStack {
                    VStack {
                        Text("Loading...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }//: VSTACK
                    .frame(width: 120,height: 120)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(8)
                }//: ZSTACK
            }
        }//: ZSTACK
        .onAppear{
            self.urlstr = pet.content_url ?? ""
        }
    }
}


