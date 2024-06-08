import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @AppStorage("selectedEnglishLevel") var selectedEnglishLevel: String?
    
    @AppStorage("selectedPurposes") private var selectedPurposesJSON: String = "[]"

    var selectedPurposes: [String] {
        get {
            guard let data = selectedPurposesJSON.data(using: .utf8) else { return [] }
            return (try? JSONDecoder().decode([String].self, from: data)) ?? []
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue),
                  let jsonString = String(data: data, encoding: .utf8) else { return }
            selectedPurposesJSON = jsonString
        }
    }
}
