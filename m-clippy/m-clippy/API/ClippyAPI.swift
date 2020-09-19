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


public class Allergen : Codable, ObservableObject {
    var Code: String
    var Text: String
}
public class Allergens : Codable, ObservableObject {
    var list: [Allergen] = []
}

public class Habits : Codable, ObservableObject {
    var bio:Bool = true
    var vegetarian:Bool = false
    var vegan:Bool = false
    var casher:Bool = false
    var halal:Bool = false
}

public class Locations: Codable, ObservableObject {
    var regional:Int = 1
    var national:Int = 2
    var outside:Int = 3
    var exclusion1:String?
    var exclusion2:String?
}

public class Allergies:Codable, ObservableObject {
    var matching:[String] = []
}

public class User: Decodable, Encodable, ObservableObject, Identifiable, Hashable, Equatable {
    static var UserId:String = "b6adb9a1-9f93-49b9-8793-d6f91d44e4a3"

    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var id:String = UserId
    var firstName:String? = "-"
    var lastName:String? = "-"
    var clientId:String? = "-"
    var configured:Bool? = false
    var cumulus:String? = "-"
    var points:String? = "-"
    
    var habits:Habits = Habits()
    var locations:Locations = Locations()
    var allergies:Allergies = Allergies()
    
    public func Name() -> String {
        let firstChar = (self.firstName ?? "M").substring(to: String.Index(encodedOffset: 1))
        return "\(firstChar). \(self.lastName ?? "Tester")"
    }
}

public class ClippyAPI: ObservableObject {
    static var Instance:ClippyAPI = ClippyAPI()

    static var staticExcludedCountries:[String] = [
        "China",
        "USA",
        "Belarus",
        "Frankreich"
    ]

    public var objectWillChange = PassthroughSubject<Void, Never>()
    @ObservedObject var user:User = DemoUser() { didSet { objectWillChange.send() }}
    @ObservedObject var staticAllergenes:Allergens = Allergens() { didSet { objectWillChange.send() }}
    @ObservedObject var reportings:Reportings = Reportings() { didSet { objectWillChange.send() }}

    public init() {
        GetUser(completion: { (newUser) in
            self.user = newUser
        })
        GetMetaDataAllergens(completion: { (allergens) in
            self.staticAllergenes = allergens
        })
        GetReportings(completion: { (reportings) in
            self.reportings = reportings
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
    
    func GetReportings(completion: @escaping (Reportings) ->()) {
        guard let url = URL(string: "https://m-clippy.azurewebsites.net/api/reporting/purchases/\(User.UserId)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let reporting = try! JSONDecoder().decode(Reportings.self, from: data!)
            DispatchQueue.main.async {
                completion(reporting)
            }
            
        }.resume()
    }
    
    func GetMetaDataAllergens(completion: @escaping (Allergens) ->()) {
        guard let url = URL(string: "https://m-clippy.azurewebsites.net/api/metadata/allergens") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let allergens = try! JSONDecoder().decode(Allergens.self, from: data!)
            allergens.list = allergens.list.sorted {
                $0.Code < $1.Code
            }
            DispatchQueue.main.async {
                completion(allergens)
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
    
    public static func DemoUser() -> User {
        let user = User()
        user.firstName = "Lolo"
        user.lastName = "Haha"
        user.cumulus = "4242"
        user.points = "2222"
        user.habits = Habits()
        user.locations = Locations()
        user.allergies = Allergies()
        return user
    }
    
}





public class Reportings : Codable, ObservableObject {
    var list:[Violation] = []
    var Score:Int = 91
    var HabitsCounter: Int = 0
    var LocationCounter: Int = 0
    var AllergyCounter: Int = 0
    var CountriesCounter: Int = 0
    var NationalSum:Double = 5.0
    var RegionalSum:Double = 78.0
    var OutsideSum: Double = 14.0
    var allergens = Dictionary<String, Int>()
    
}

public class Violation : Codable, ObservableObject {
    var Thumbnail:String = ""
    var Image:String = ""
    var Price:Double = 0.0
    var Quantity:String = "100g"
    var ArticleID:String = "104223700000"
    var LocationAlert:Bool = false
    var HabitsAlert:Bool = true
    var AllergyAlert:Bool = false
}



struct OnboardingAPI_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
