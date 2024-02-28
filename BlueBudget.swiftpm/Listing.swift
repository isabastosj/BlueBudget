import SwiftUI
import Foundation

struct Listing: Identifiable, Hashable, Codable {

    var id = UUID()
    var title = ""
    var items = [Item(text: "")]
    var date = Date.now
    
    var remainingItemCount: Int {
        items.filter { !$0.isCompleted && !$0.text.isEmpty }.count
    }
    
    var isComplete: Bool {
        items.allSatisfy { $0.isCompleted || $0.text.isEmpty }
    }
    
    static var delete = Listing()
    
    init(id: UUID = UUID(), title: String = "", items: [Item] = [Item(text: "")], date: Foundation.Date = Date.now) {
        self.id = id
        self.title = title
        self.items = items
        self.date = date
    }
    
    mutating func createItem(item: Item) {
        items.append(item)
    }
    
    func getItems() -> [Item] {
        return items
    }
    
    mutating func deleteItem(id: UUID) {
        items.removeAll{ t in
            t.id == id
        }
    }

    
    mutating func updateItem(id: UUID, newItem: Item) {
        items = items.map { item in
            if item.id == id {
                return newItem
            }
            return item
        }
        
    }
}
