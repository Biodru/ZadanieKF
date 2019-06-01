//
//  City.swift
//  ZadanieK
//
//  Created by Piotr_Brus on 29/05/2019.
//  Copyright © 2019 Piotr_Brus. All rights reserved.
//

import UIKit

class Cities: Codable {
    let cities: [City]
    
    init(cities: [City]) {
        self.cities = cities
    }
}

class City: Codable {
    let name: String
    let description: String
    let photo: String
    
    init(name: String, description: String, photo: String) {
        self.name = name
        self.description = description
        self.photo = photo
    }
}

class Tickets: Codable {
    
    let tickets: [Ticket]
    
    init(tickets: [Ticket]) {
        self.tickets = tickets
    }
    
}

class Ticket: Codable {
    
    let city: String
    let tName: String
    let tType: String
    let tDescription: String
    let tIcon: String
    
    init(city: String, tName: String, tType: String, tDescription: String, tIcon: String) {
        
        self.city = city
        self.tName = tName
        self.tType = tType
        self.tDescription = tDescription
        self.tIcon = tIcon
        
    }
    
}
