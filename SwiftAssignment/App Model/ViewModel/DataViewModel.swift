//
//  DataViewModel.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation

class DataViewModel {

    /// Callback to pass the selected place.
    var dataModel: DataModel?

    /// Callback to Update map.
    var updateUI: ()->() = { }

    var numberOfRows = 0
    var navTitle: String = ""
    var rowsArray: [Row] = []

    init() {
        self.getApiData(complete: {  [weak self] (dataModel) in
            self?.dataModel = dataModel
            self?.preparedTableCellCount()
            self?.updateUI()
        })
    }

    private func preparedTableCellCount() {
        guard let count = self.dataModel?.rows.count, count > 0 else { return }
        self.numberOfRows = count
        self.navTitle = self.dataModel?.title ?? ""
        self.rowsArray = self.dataModel?.rows ?? []
    }
    
    func getApiData(complete:@escaping (DataModel?) -> Void) {
        
          let apiConfiguration = APIConfiguration(api_SubDomain: "", api_EndPoint: "", httpMethod: .get)
        
          RequestManager.sharedInstance.withGet(apiConfiguration: apiConfiguration) { (json, error) in
              if let response = json {
                  let jsonData = response.data(using: .utf8)!
                  let dataModel = try! JSONDecoder().decode(DataModel.self, from: jsonData)
                  complete(dataModel)
              }
              else {
                  complete(nil)
              }
          }
      }
}
