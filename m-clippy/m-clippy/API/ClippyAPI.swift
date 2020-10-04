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
    var isRegional:Bool {
        return self.regional == 1
    }
}

public class Allergies:Codable, ObservableObject {
    var matching:[String] = []
}

public class User: Decodable, Encodable, ObservableObject, Identifiable, Hashable, Equatable {
    //static var UserIds:[Int] = [102356, 102958, 102532, 102910, 102231, 102049, 102215, 102215, 102418, 102445]
    static var UserIds:[Int] = []
    static var UserId:String = "\(UserIds.randomElement() ?? 102532)"

    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static public func RandomizeUserId() {
        UserId = "\(UserIds.randomElement() ?? 102000)"
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
        let firstChar = (self.lastName ?? "M").substring(to: String.Index(encodedOffset: 1))
        return "\(self.firstName ?? "Lolo") \(firstChar)."
    }
}

public class ClippyAPI: ObservableObject {
    static var Instance:ClippyAPI = ClippyAPI()
    static var Endpoint:String = "https://m-clippy.azurewebsites.net";
    //static var Endpoint:String = "http://localhost:5000";

    public var staticExcludedCountries:[String] = [
        "China",
        "USA",
        "Belarus",
        "Frankreich"
    ]

    public var objectWillChange = PassthroughSubject<Void, Never>()
    @ObservedObject var user:User = DemoUser() { didSet { objectWillChange.send() }}
    @ObservedObject var staticAllergenes:Allergens = Allergens() { didSet { objectWillChange.send() }}
    @ObservedObject var reportings:Reportings = Reportings() { didSet { objectWillChange.send() }}
    public var loaded:Bool = false
    public var loadedUser:Bool = false

    public init() {
        self.loaded = false
        self.loadedUser = false
        GetUser(completion: { (newUser) in
            self.user = newUser
        })
        GetMetaDataAllergens(completion: { (allergens) in
            DispatchQueue.main.async {
                self.staticAllergenes = allergens
                self.loadedUser = true
            }
        })
        GetReportings(completion: { (reportings) in
            DispatchQueue.main.async {
                self.reportings = reportings
                self.loaded = true
            }
        })
    }
    
    func GetUser(completion: @escaping (User) ->()) {
        guard let url = URL(string: "\(Self.Endpoint)/api/onboarding/users/\(User.UserId)") else {
            DispatchQueue.main.async {
                completion(Self.DemoUser())
            }
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if (data == nil) {
                DispatchQueue.main.async {
                    completion(Self.DemoUser())
                }
                return;
            }
            let user = try! JSONDecoder().decode(User.self, from: data!)
            DispatchQueue.main.async {
                completion(user)
            }
        }.resume()
    }
    
    func GetReportings(completion: @escaping (Reportings) ->()) {
        guard let url = URL(string: "\(Self.Endpoint)/api/reporting/purchases/\(User.UserId)") else {
            DispatchQueue.main.async {
                completion(Reportings())
            }
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let localData = data
            if (localData == nil || localData!.isEmpty) {
                DispatchQueue.main.async {
                    completion(Reportings())
                }
                return;
            }
            let reporting = try! JSONDecoder().decode(Reportings.self, from: localData!)
            DispatchQueue.main.async {
                completion(reporting)
            }
        }.resume()

    }
    
    func GetMetaDataAllergens(completion: @escaping (Allergens) ->()) {
        guard let url = URL(string: "\(Self.Endpoint)/api/metadata/allergens") else { return }
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
            guard let url = URL(string: "\(Self.Endpoint)/api/onboarding/users/\(User.UserId)") else { return }
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
    var list:[ProductViolation] = []
    
    var ProductsAnalyzed:Int = 91
    
    var Score:Int = 91
    
    var HabitsCounter: Int = 0
    var LocationCounter: Int = 0
    var AllergyCounter: Int = 0
    
    var CountriesCounter: Int = 0
    var PlanesKm:String = "100km"
    var CarKm:String = "71km"
    
    var NationalSum:Double = 5.0
    var RegionalSum:Double = 78.0
    var OutsideSum: Double = 14.0
    
    var NotVeganCounter:Double = 0.0
    var VeganCounter:Double = 0.0
    
    var NotVegetarianCounter:Double = 0.0
    var VegetarianCounter:Double = 0.0
    
    var NotBioCounter:Double = 5.0
    var BioCounter:Double = 1.0
    
    var NoAllergensCounter:Double = 5.0
    var AllergensCounter:Double = 6.0
    
    
    var allergens = Dictionary<String, Int>()
    var ProducingCountries = Dictionary<String, Int>()

}

public class ProductViolation : Codable, ObservableObject {
    var Name:String = ""
    var Thumbnail:String? = "https://alexdunndev.files.wordpress.com/2020/01/empty_app_icon_512.png?w=512&h=510&crop=1"
    var Original:String = "https://alexdunndev.files.wordpress.com/2020/01/empty_app_icon_512.png?w=512&h=510&crop=1"

    var Image:String? = "https://alexdunndev.files.wordpress.com/2020/01/empty_app_icon_512.png?w=512&h=510&crop=1"
    
    var Price:Double = 0.0
    var Quantity:String = "100g"
    var ArticleID:String = "4042448470942"
    var LocationAlert:Bool = false
    var HabitsAlert:Bool = false
    var AllergyAlert:Bool = false
    
    
    public static func EmptyProduct() -> ProductViolation {
        let p = ProductViolation()
        p.Quantity = ""
        return p
    }
}



struct OnboardingAPI_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
