
import UIKit

class WatchlistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var idWatchListArray : [Int] = []
    var getWatchlistTitle : [String] = []
    var getWatchlistImg : [String] = []
    var runTimes : Bool = true
    var listOfMovies = [MoviesDetails]() {
        didSet {
            DispatchQueue.main.sync {
                if (idWatchListArray.count != 0) {
                    for i in 0...listOfMovies.count - 1 {
                        for x in 0...idWatchListArray.count - 1 {
                            if (listOfMovies[i].id == idWatchListArray[x]) {
                                getWatchlistTitle.append(listOfMovies[i].original_title)
                                getWatchlistImg.append(listOfMovies[i].poster_path)
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
        
        if runTimes == true {
            idWatchListArray = []
            runTimes = false
            let defaults = UserDefaults.standard
            if (defaults.array(forKey: "idWatchListArray") != nil) {
                idWatchListArray = defaults.array(forKey: "idWatchListArray")  as? [Int] ?? [Int]()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (getWatchlistTitle != nil) {
            return getWatchlistTitle.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchlistcell" , for: indexPath as IndexPath) as! WatchListTableTableViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/w200\(getWatchlistImg[indexPath.row])")!
        if let data = try? Data(contentsOf: url) {
            cell.imageViewCell.image = UIImage(data: data)
        }
        cell.titleCell.text = getWatchlistTitle[indexPath.row]
        
        return cell
    }
    
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
        
        //reload tableview
        if runTimes == false {
            idWatchListArray = []
            getWatchlistImg = []
            getWatchlistTitle = []
            let defaults = UserDefaults.standard
            if (defaults.array(forKey: "idWatchListArray") != nil) {
                idWatchListArray = defaults.array(forKey: "idWatchListArray")  as? [Int] ?? [Int]()
            }
            if (idWatchListArray.count != 0) {
                if (listOfMovies.count != 0) {
                    for i in 0...listOfMovies.count - 1 {
                        for x in 0...idWatchListArray.count - 1 {
                            if (listOfMovies[i].id == idWatchListArray[x]) {
                                getWatchlistTitle.append(listOfMovies[i].original_title)
                                getWatchlistImg.append(listOfMovies[i].poster_path)
                                tableView.reloadData()
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backFromWatchlist(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
