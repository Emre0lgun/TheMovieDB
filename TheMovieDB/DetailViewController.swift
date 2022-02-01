
import UIKit

class DetailViewController: UIViewController {
    
    var titleText : String = ""
    var paragraphText : String = ""
    var imageUrl : String = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var watchlistBtn: UIButton!
    @IBOutlet weak var favoritiesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: imageUrl)!
        
        if let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
        
        self.title = titleText
        textView.text = paragraphText

    }
    
    @IBAction func detailWatchList(_ sender: Any) {
        print("detailWatchList")
    }
    
    @IBAction func detailFavorities(_ sender: Any) {
        print("detailFavorities")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

}
