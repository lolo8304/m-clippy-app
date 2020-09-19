//
//  OnboardingAllergens.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

public class AllergenBool : Codable, ObservableObject {
    init(allergen: Allergen, flag: Bool) {
        self.allergen = allergen
        self.flag = flag
    }
    var allergen: Allergen
    var flag: Bool
}

public class AllergensBool : Codable, ObservableObject {
    init(allergens: Allergens) {
        self.allergens = allergens.list.map { (allergen) -> AllergenBool in
            return AllergenBool(allergen: allergen, flag: false)
        }
    }
    var allergens: [AllergenBool]
}


struct OnboardingAllergies: View {
    @EnvironmentObject var api: ClippyAPI
    @State var allergens: AllergensBool = AllergensBool(allergens: ClippyAPI.Instance.staticAllergenes)

    var body: some View {
        ClippyBox(title: "My allergies", subTitle:"You select and Clippy will alert you while buying", backColor: SettingsView.MigrosColor, foreColor: Color.white, image: Image("allergy-OK") ) {
            
            ForEach(allergens.allergens.indices) { i in

                Toggle(isOn: $allergens.allergens[i].flag) {
                    Text(self.allergens.allergens[i].allergen.Text)
                }
            }
        }
    }
}

struct OnboardingAllergies_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        OnboardingAllergies().environmentObject(api)
    }
}
