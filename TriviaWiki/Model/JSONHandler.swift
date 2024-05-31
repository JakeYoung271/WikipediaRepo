//
//  JSONHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/30/24.
//

import Foundation

// Write JSON to a file
func writeJSON(name: String, data: [String: Any]) {
    let fileURL = getDocumentsDirectory().appendingPathComponent("\(name).json")
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        try jsonData.write(to: fileURL)
        print("Successfully wrote to \(fileURL)")
    } catch {
        print("Failed to write JSON data: \(error.localizedDescription)")
    }
}

// Read JSON from a file
func readJSON(name: String) -> [String: Any]? {
    let fileURL = getDocumentsDirectory().appendingPathComponent("\(name).json")
    do {
        let jsonData = try Data(contentsOf: fileURL)
        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            return jsonDict
        } else {
            print("Failed to convert JSON data to dictionary")
            return nil
        }
    } catch {
        print("Failed to read JSON data: \(error.localizedDescription)")
        return nil
    }
}

// Check if JSON file exists
func findJSON(name: String) -> Bool {
    let fileURL = getDocumentsDirectory().appendingPathComponent("\(name).json")
    return FileManager.default.fileExists(atPath: fileURL.path)
}

// Helper function to get the documents directory
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func copyPreloadedFilesToDocuments() {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let fileNames = ["dump0", "currRatings"] // Add all file names without extension here
    
    for fileName in fileNames {
        if let bundleFileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let destinationURL = documentsURL.appendingPathComponent("\(fileName).json")
            
            do {
                if !fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.copyItem(at: bundleFileURL, to: destinationURL)
                    print("Copied \(fileName).json to Documents directory")
                }
            } catch {
                print("Error copying file: \(error.localizedDescription)")
            }
        }
    }
}
