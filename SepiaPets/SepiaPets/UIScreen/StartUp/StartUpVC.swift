//
//  StartUpVC.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI

struct StartUpVC: View {
    
    @State var isPetsListClick : Bool = false
    @State var showingWorkingHourAlert : Bool = false
    
    @State var petListDataArr : [PetDetailModel] = [PetDetailModel]()
    @State var startWorkingTime : String = ""
    @State var endWorkingTime : String = ""
    
    var body: some View {
        ZStack{
            btnPetsList
        }//: ZSTACK
        .onAppear{
            self.getWorkingTime()
            self.getPetsList()
        }
    }
}

struct StartUpVC_Previews: PreviewProvider {
    static var previews: some View {
        StartUpVC()
    }
}

// MARK : COMPONENTS
extension StartUpVC {
    private var btnPetsList: some View {
        NavigationLink(destination: PetsListVC(),
                       isActive: $isPetsListClick) {
            Text("Pets List")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.vertical,12)
                .padding(.horizontal,50)
                .background(Color.blue)
                .cornerRadius(10)
                .onTapGesture {
                    if self.startWorkingTime != "" && self.endWorkingTime != "" {
                        let validateWorkingHour = self.checkIfCurrentTimeIsBetween(startTime: self.startWorkingTime, endTime: self.endWorkingTime)
                        if validateWorkingHour {
                            self.isPetsListClick = true
                        }else{
                            self.showingWorkingHourAlert = true
                        }
                    }
                }
                .alert(isPresented: $showingWorkingHourAlert) {
                    Alert(title: Text("Important message"), message: Text("\nYour working Time is not started Yet. please try again in your working time hours.\n"), dismissButton: .default(Text("Got it!")))
                }
        }//: NAV LINK
    }
}

// MARK : FUNCTIONS
extension StartUpVC {
    func getPetsList(){
        if let path = Bundle.main.path(forResource: "config", ofType: "json") {
            do {
                let str = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: str.data(using: .utf8)!, options: .allowFragments) as? [String:Any] {
                    if let settings = dict["settings"] as? [String:Any] {
                        if let workingHoursST = settings["workHours"] as? String {
                            //"workHours" : "M-F 9:00 - 18:00"
                            let onlyHoursST = workingHoursST.replacingOccurrences(of: "M-F ", with: "")
                            let splitSTArr = onlyHoursST.components(separatedBy: " - ")
                            if splitSTArr.count == 2 {
                                self.startWorkingTime = splitSTArr.first ?? ""
                                self.endWorkingTime = "12:00"//splitSTArr.last ?? ""
                            }
                        }
                    }
                }
            } catch let err {
                print("PARSE ERROR:- \(err.localizedDescription)")
            }
        }
    }
    
    func getWorkingTime(){
        if let path = Bundle.main.path(forResource: "pets_list", ofType: "json") {
            do {
                let str = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: str.data(using: .utf8)!, options: .allowFragments) as? [String:Any] {
                    if let dataDict = dict["pets"] as? [[String:Any]] {
                        for petDetail in dataDict{
                            if let image_url = petDetail["image_url"] as? String, let title = petDetail["title"] as? String, let content_url = petDetail["content_url"] as? String, let date_added = petDetail["date_added"] as? String {
                                let petModel = PetDetailModel(image_url: image_url,title: title,content_url: content_url,date_added: date_added)
                                petListDataArr.append(petModel)
                            }
                        }
                    }
                }
            } catch let err {
                print("PARSE ERROR:- \(err.localizedDescription)")
            }
        }
    }
    
    func checkIfCurrentTimeIsBetween(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.today.date(from: startTime),
              let end = Formatter.today.date(from: endTime) else {
            return false
        }
        return DateInterval(start: start, end: end).contains(Date())
    }
}
