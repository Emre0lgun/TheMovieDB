
import Foundation

//JSON column names
struct Movies: Decodable {
    var results: [MoviesDetails]
}

struct MoviesDetails: Decodable {
    var id : Int
    var backdrop_path : String
    var original_title : String
    var overview : String
    var poster_path : String
    var release_date : String
}
