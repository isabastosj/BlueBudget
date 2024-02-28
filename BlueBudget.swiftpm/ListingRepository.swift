//
//  ListingRepository.swift
//  MangoList
//
//  Created by Isabela Bastos Jastrombek on 21/02/24.
//

import Foundation
import SwiftUI

class ListingRepository: ObservableObject {
    let defaults = UserDefaults.standard
    
    @Published var lists: [Listing] {
        didSet {
            saveInUserDefaults()
        }
    }
    
    init() {
        self.lists = ListingRepository.getFromUserDefaults()
    }
    
    func createList(list: Listing) {
        lists.append(list)
    }
    
    func deleteList(id: UUID) {
        lists.removeAll { p in
            p.id == id
        }
    }
    
    func getBindingToList(_ list: Listing) -> Binding<Listing>? {
            Binding<Listing>(
                get: {
                    guard let index = self.lists.firstIndex(where: { $0.id == list.id }) else { return Listing.delete }
                    return self.lists[index]
                },
                set: { list in
                    guard let index = self.lists.firstIndex(where: { $0.id == list.id }) else { return }
                    self.lists[index] = list
                }
            )
        }
    
    func updateList(id: UUID, newList: Listing) {
        lists = lists.map { p in
            if p.id == id {
                return newList
            }
            return p
        }
    }
    
    static func getFromUserDefaults() -> [Listing] {
        if let lists = UserDefaults.standard.object(forKey: "lists") as? Data {
            let decoder = JSONDecoder()
            if let loadedLists = try? decoder.decode([Listing].self, from: lists) {
                return loadedLists
            }
        }
        
        return []
    }
    
    func saveInUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lists) {
            UserDefaults.standard.set(encoded, forKey: "lists")
        }
    }
}

