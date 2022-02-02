
import Foundation

//Return Error Values
enum MoviesError : Error {
    case noDataAvailable
    case canNotProcessData
}

//GET API
struct MoviesRequest {
    let url = "https://api.themoviedb.org/3/discover/movie?api_key=a3956525871efa056dd08a0599938f8b"
    func getMovies (completion: @escaping(Result<[MoviesDetails], MoviesError>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _, _ in
                    guard let jsonData = data else {
                        completion(.failure(.noDataAvailable))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let moviesResponse = try decoder.decode(Movies.self, from: jsonData)
                        let moviesdetails = moviesResponse.results
                        completion(.success(moviesdetails))
                    } catch {
                        completion(.failure(.canNotProcessData))
                    }
                    
                })
                
                task.resume()
    }
        
}
