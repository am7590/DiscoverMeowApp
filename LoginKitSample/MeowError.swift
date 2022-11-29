//
//  MeowError.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

public enum EncodingError: Error {
    case decodeFailed(error: String)
}
