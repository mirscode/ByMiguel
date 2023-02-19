import Foundation

struct Quote: Codable {
    var identifier: Int
    var message: String
}

struct Quotes: Codable {
    var quotes: [Quote]
}

/**
 TODO: Move these helper functions to their own class.
 */
func parse(data: Data) -> Quotes? {
    do {
        let decodedData = try JSONDecoder().decode(Quotes.self, from: data)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    
    return nil
}

func readJsonFile(forFileName fileName: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    
    return nil
}
