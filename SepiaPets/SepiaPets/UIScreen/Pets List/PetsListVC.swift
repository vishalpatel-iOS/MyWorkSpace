//
//  PetsListVC.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI

struct PetsListVC: View {
    var petListDataArr : [PetDetailModel] = [PetDetailModel]()
    @State var isPetSelected : Bool = false
    
    var body: some View {
        ZStack{
            if petListDataArr.count > 0 {
                List {
                    ForEach(petListDataArr) { pet in
                        PetRowView(pet: pet)
                            .padding(.horizontal,8)
                            .padding(.vertical,5)
                            .onTapGesture {
                                self.isPetSelected = true
                            }
                    }
                }
            }else{
                Text("No pets list available!")
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
            }
        }//: ZSTACK
        .navigationBarTitle("Pets List", displayMode: .inline)
    }
}

struct PetsListVC_Previews: PreviewProvider {
    static var previews: some View {
        PetsListVC()
    }
}

