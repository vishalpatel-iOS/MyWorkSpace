//
//  PetsListVC.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI

struct PetsListVC: View {
    var petListDataArr : [PetDetailModel] = [PetDetailModel]()
    
    var body: some View {
        if petListDataArr.count > 0 {
            List {
                ForEach(petListDataArr) { pet in
                    PetRowView(pet: pet)
                        .padding(.horizontal)
                        .padding(.vertical,5)
                }
            }
        }else{
            Text("No pets details available!")
                .foregroundColor(.black)
                .font(.title)
                .bold()
        }
    }
}

struct PetsListVC_Previews: PreviewProvider {
    static var previews: some View {
        PetsListVC()
    }
}

struct PetRowView: View {
    var pet: PetDetailModel

    var body: some View {
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
    }
}
