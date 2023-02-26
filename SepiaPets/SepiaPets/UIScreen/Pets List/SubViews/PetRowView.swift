//
//  PetRowView.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI

struct PetRowView: View {
    var pet: PetDetailModel

    @State var isPetDetailsClick: Bool = false
    
    var body: some View {
        NavigationLink(destination: PetDetailVC(pet: pet), isActive: $isPetDetailsClick) {
            HStack(spacing: 10){
                AsyncImage(url: URL(string: pet.image_url ?? ""), transaction:  Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                    if let image = phase.image{
                        image.imageModifire()
                            .transition(.scale)
                    }else if phase.error != nil {
                        Image(systemName: "ant.circle.fill").iconModifire()
                    }else{
                        Image(systemName: "photo.circle.fill").iconModifire()
                    }
                }//: ASYNCIMAGE
                .frame(width: 60,height: 60)
                .cornerRadius(30)
                
                Text(pet.title ?? "")
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            .onTapGesture {
                self.isPetDetailsClick = true
            }
        }
    }
}
