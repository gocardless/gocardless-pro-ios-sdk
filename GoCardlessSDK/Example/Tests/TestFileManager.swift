//
//  TestFileManager.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 05/03/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class TestFileManager {
    static func loadFile(name: String, withExtension: String = "json") -> Data? {
        let bundle = Bundle(for: TestFileManager.self)
        guard let url = bundle.url(forResource: name, withExtension: withExtension) else {
            return nil
        }
        
        return try! Data(contentsOf: url)
    }
}
