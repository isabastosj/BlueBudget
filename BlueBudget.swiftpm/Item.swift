import SwiftUI

struct Item: Identifiable, Hashable, Codable {

    var id = UUID()
    var text: String 
    var isCompleted = false
    var isNew = false
//    var quantity: Double?
//    var price: Double?
    var quantity = Double()
    var price = Double()
}
