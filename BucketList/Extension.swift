//
//  Extension.swift
//  BucketList
//
//  Created by Maurício Costa on 16/02/23.
//

import SwiftUI

extension FileManager {

    func documentsDirectory() -> URL {
       self.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // loads a JSON file from the document directory
    func decodeFromFile<T:Decodable>(name: String) throws -> T {
        // construct filename
        let directory = documentsDirectory()
        let fullFileName = directory.appendingPathComponent(name)

        // load file into data
        let data = try Data(contentsOf: fullFileName)

        // decode data
        let decodedJson = try JSONDecoder().decode(T.self, from: data)

        // return decoded data
        return decodedJson
    }

    // stores a JSON file to the documents directory
    func encodeToFile<T:Encodable>( name: String, content : T ) throws {
        // encode to data
        let jsonEncoded = try JSONEncoder().encode(content)

        // build filename
        let directory = documentsDirectory()
        let fullFileName = directory.appendingPathComponent(name)

        // write data to file
        try jsonEncoded.write(to: fullFileName, options: .atomic)
    }
}
