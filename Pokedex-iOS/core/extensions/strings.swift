//
//  strings.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 13/01/23.
//

import Foundation

extension String {
    
    mutating func firstUpper() -> String {
        let firstUpper: String = self.first?.uppercased() ?? ""
        self.removeFirst()
        return firstUpper.appending(self)
    }
    func getPokemonIdByUrl() -> String {
        var id = ""
        var cont = 2
        var flag = true
        if self.count > 2 {
            while (flag) {
                let number: Character = self[String.Index(encodedOffset: self.count - cont) ]
                if (number != "/") {
                    id.append(number)
                    cont += 1
                } else {
                    flag = false
                }
            }
        }
        
        return id
    }
}
