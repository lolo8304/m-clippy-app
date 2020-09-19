//
//  mClippyAPI.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//
import Foundation
import SwiftUI
import Swift
import Combine


// random numbers: https://learnappmaking.com/random-numbers-swift/
// post message: https://www.youtube.com/watch?v=EuNThe245nk


struct Habits:Codable {
    var bio:Bool
    var vegetarian:Bool
    var vegan:Bool
    var casher:Bool
    var halal:Bool
}

struct Location:Codable {
    var regional:Int = 1
    var national:Int = 2
    var outside:Int = 3
    var exclusion1:String?
    var exclusion2:String?
}


class User: Decodable, Encodable, ObservableObject, Identifiable, Hashable, Equatable {
    static var UserId:String = "b6adb9a1-9f93-49b9-8793-d6f91d44e4a3"

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id:String = UserId
    var firstName:String? = "-"
    var lastName:String? = "-"
    var clientId:String?
    var configured:Bool? = false
    var cumulus:String?
    var points:String?
    var habits:Habits?
    
    public func Name() -> String {
        let firstChar = (self.firstName ?? "M").substring(to: String.Index(encodedOffset: 1))
        return "\(firstChar). \(self.lastName ?? "Tester")";
    }
}

class OnboardingAPI {
    static var titles:[String] = [
        "Verkehrsunfall / Kollision",
        "Marderschaden",
        "Glassschaden",
        "Assistance"
    ]
    static var Instance:OnboardingAPI = OnboardingAPI()
    var currentUser:User?;
    
    public init() {
        GetUser(completion: { (user) in
            self.currentUser = user
        })
    }
    
    func GetUser(completion: @escaping (User) ->()) {
        guard let url = URL(string: "https://m-clippy.azurewebsites.net/api/onboarding/users/\(User.UserId)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let user = try! JSONDecoder().decode(User.self, from: data!)
            DispatchQueue.main.async {
                completion(user)
            }
            
        }.resume()
    }
    
    enum APIError:Error {
        case responseProblem
        case decodingProblem
        case encodingProblem
    }
    
    func UpdateUser(user: User, completion: @escaping (Result<User, APIError>) ->()) {
        do {
            guard let url = URL(string: "https://m-clippy.azurewebsites.net/api/onboarding/users/\(User.UserId)") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, _) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let interaction = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.success(interaction))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
}


