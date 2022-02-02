

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var getData: [String]!
    var filteredData: [String]!
    @IBOutlet weak var searchBar: UISearchBar!
    //let url =  "https://api.themoviedb.org/3/discover/movie?api_key=a3956525871efa056dd08a0599938f8b"
    
    //Get JSON From API
    var listOfMovies = [MoviesDetails]() {
        didSet {
            DispatchQueue.main.sync {
                filteredData = []
                getData = []
                for i in 0...(listOfMovies.count - 1) {
                    filteredData.append(listOfMovies[i].original_title)
                    getData.append(listOfMovies[i].original_title)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tableView.keyboardDismissMode = .onDrag
        
        //Send Request to API
        let moviesRequset = MoviesRequest()
        moviesRequset.getMovies{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovies = movies
            }
        }
        
        searchBar.delegate = self
    }

    //TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (filteredData != nil) {
            return filteredData.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = "\(filteredData[indexPath.row]) - \(listOfMovies[getData.firstIndex(where: {$0 == filteredData[indexPath.row]})!].release_date.prefix(4))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Detail Screen Action
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailscreen") as? DetailViewController
        vc?.movieId = listOfMovies[getData.firstIndex(where: {$0 == filteredData[indexPath.row]})!].id
        vc?.titleText = listOfMovies[getData.firstIndex(where: {$0 == filteredData[indexPath.row]})!].original_title
        vc?.paragraphText = listOfMovies[getData.firstIndex(where: {$0 == filteredData[indexPath.row]})!].overview
        vc?.imageUrl = listOfMovies[getData.firstIndex(where: {$0 == filteredData[indexPath.row]})!].backdrop_path
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = getData
        } else {
            for filteredString in getData {
                if filteredString.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(filteredString)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    //Navigation and Status Bar Color
    override func viewWillAppear(_ animated: Bool) {
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
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
    //Back Button Action
    @IBAction func backFromSearch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}

//Keyboard Dismiss
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
