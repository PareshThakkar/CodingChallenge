import Foundation

class APIManager {
    
    class func loadData(forURL url:URL, completion:@escaping(Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse
            else {
                completion(data, response, error)
                return
            }
            if (200..<300) ~= response.statusCode {
                completion(data, response,error)
            }
            else {
                let jsonDecoder = JSONDecoder()
                let customError = try!jsonDecoder.decode(CustomError.self, from: data)
                let error = NSError(domain: "", code: Int(customError.cod) ?? 001, userInfo: [ NSLocalizedDescriptionKey: customError.message ?? "Something went wrong"])
                completion(data, response,error)
            }
        }.resume()
    }
}
