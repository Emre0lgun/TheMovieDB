
import UIKit

class DetailViewController: UIViewController {
    
    var movieId : Int = 0
    var titleText : String = ""
    var paragraphText : String = ""
    var imageUrl : String = ""
    var idFavoritiesArray : [Int] = []
    var idWatchListArray : [Int] = []
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var watchlistBtn: UIButton!
    @IBOutlet weak var favoritiesBtn: UIButton!
    let defaultsWatchlist = UserDefaults.standard
    let defaultsFavorities = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        let url = URL(string: "https://image.tmdb.org/t/p/w400\(imageUrl)")!
        
        
        if let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
        
        idFavoritiesArray = []
        idWatchListArray = []
        
        
        if (defaultsFavorities.array(forKey: "favoritiesId") != nil) {
            idFavoritiesArray = defaultsFavorities.array(forKey: "favoritiesId")  as? [Int] ?? [Int]()
        }
        
        if (defaultsWatchlist.array(forKey: "idWatchListArray") != nil) {
            idWatchListArray = defaultsWatchlist.array(forKey: "idWatchListArray")  as? [Int] ?? [Int]()
        }
        
        if (idFavoritiesArray.contains(movieId)) {
            if let image = UIImage(named: "activeheart.png") {
                favoritiesBtn.setImage(image, for: .normal)
            }
        }
        
        if idWatchListArray.contains(movieId) {
            if let image = UIImage(named: "activewatchlist.png") {
                watchlistBtn.setImage(image, for: .normal)
            }
        }
        
        self.title = titleText
        textView.text = "\t\(paragraphText)"

    }
    
    @IBAction func detailWatchList(_ sender: Any) {
        if idWatchListArray.contains(movieId) {
            idWatchListArray.remove(at: idWatchListArray.firstIndex(where: {$0 == movieId})!)
            defaultsWatchlist.removeObject(forKey: "idWatchListArray")
            defaultsWatchlist.set(idWatchListArray, forKey: "idWatchListArray")
            print(idWatchListArray)
            if let image = UIImage(named: "watchlist.png") {
                watchlistBtn.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "activewatchlist.png") {
                watchlistBtn.setImage(image, for: .normal)
            }
            idWatchListArray.append(movieId)
            defaultsWatchlist.removeObject(forKey: "idWatchListArray")
            defaultsWatchlist.set(idWatchListArray, forKey: "idWatchListArray")
        }
    }
    
    @IBAction func detailFavorities(_ sender: Any) {
        if idFavoritiesArray.contains(where: {$0 == movieId}) {
            idFavoritiesArray.remove(at: idFavoritiesArray.firstIndex(where: {$0 == movieId})!)
            defaultsFavorities.removeObject(forKey: "favoritiesId")
            defaultsFavorities.set(idFavoritiesArray, forKey: "favoritiesId")
            if let image = UIImage(named: "heart.png") {
                favoritiesBtn.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "activeheart.png") {
                favoritiesBtn.setImage(image, for: .normal)
            }
            idFavoritiesArray.append(movieId)
            defaultsFavorities.removeObject(forKey: "favoritiesId")
            defaultsFavorities.set(idFavoritiesArray, forKey: "favoritiesId")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

}
