
import UIKit

class FavoritiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var idFavoritiesArray : [Int] = []
    var getFavoritiesTitle : [String] = []
    var getFavoritiesImg : [String] = []
    var runTimes : Bool = true
    
    //Get JSON From API and fill Favorities title and image
    var listOfMovies = [MoviesDetails]() {
        didSet {
            DispatchQueue.main.sync {
                if (idFavoritiesArray.count != 0) {
                    for i in 0...listOfMovies.count - 1 {
                        for x in 0...idFavoritiesArray.count - 1 {
                            if (listOfMovies[i].id == idFavoritiesArray[x]) {
                                getFavoritiesTitle.append(listOfMovies[i].original_title)
                                getFavoritiesImg.append(listOfMovies[i].poster_path)
                                tableView.reloadData()
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        //Run one time when start page
        if runTimes == true {
            idFavoritiesArray = []
            runTimes = false
            let defaults = UserDefaults.standard
            if (defaults.array(forKey: "favoritiesId") != nil) {
                idFavoritiesArray = defaults.array(forKey: "favoritiesId")  as? [Int] ?? [Int]()
            }
            let moviesRequset = MoviesRequest()
            moviesRequset.getMovies{[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let movies):
                    self?.listOfMovies = movies
                }
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (getFavoritiesTitle != nil) {
            return getFavoritiesTitle.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritiescell" , for: indexPath as IndexPath) as! FavoritiesTableViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/w200\(getFavoritiesImg[indexPath.row])")!
        if let data = try? Data(contentsOf: url) {
            cell.imageCell.image = UIImage(data: data)
        }
        cell.titleCell.text = getFavoritiesTitle[indexPath.row]
        
        return cell
    }
    
    //Navigation and Status Bar Color
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        
        //reload tableview when page open everytime
        if runTimes == false {
            idFavoritiesArray = []
            getFavoritiesImg = []
            getFavoritiesTitle = []
            let defaults = UserDefaults.standard
            if (defaults.array(forKey: "favoritiesId") != nil) {
                idFavoritiesArray = defaults.array(forKey: "favoritiesId")  as? [Int] ?? [Int]()
            }
            if (idFavoritiesArray.count != 0) {
                if (listOfMovies.count != 0) {
                    for i in 0...listOfMovies.count - 1 {
                        for x in 0...idFavoritiesArray.count - 1 {
                            if (listOfMovies[i].id == idFavoritiesArray[x]) {
                                getFavoritiesTitle.append(listOfMovies[i].original_title)
                                getFavoritiesImg.append(listOfMovies[i].poster_path)
                                tableView.reloadData()
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    //Back Button Action
    @IBAction func backFromFavorities(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
