//
//  QuestionsDataService.swift
//  question_api
//
//  Created by Daniel Apps on 12/09/22.
//

import Foundation

typealias Callback<T:Any> = (_ value:T)->Void;

class QuestionsDataService{
    static let instance: QuestionsDataService = QuestionsDataService()
    let userDefaults = UserDefaults()

    func getFromApi<T : Decodable >(url: String,type: T.Type,onComplete: @escaping Callback<T> )  {
            let url = URL(string:url )!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return }

            do{
                print("##Data obtenida")
                let dataDecoded : T = try JSONDecoder().decode(T.self,from: data)
                DispatchQueue.global().async {
                    onComplete( dataDecoded )
                }
            }catch{
                print("###### ERROR : \(error)")
            }
            }
            task.resume()
    }
}
