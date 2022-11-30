//
//  String+Country&Flag.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/29/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

extension String {
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func countryName() -> String {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: self) ?? ""
    }
}
