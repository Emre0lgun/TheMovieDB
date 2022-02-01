//
//  SearchTableViewController.swift
//  TheMovieDB
//
//  Created by Emre OLGUN on 27.01.2022.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    let data = ["Movie1", "Movie2", "Movie3", "Movie4", "Movie5"]
    var filteredData: [String]!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        filteredData = data
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailscreen") as? DetailViewController
        vc?.titleText = filteredData[indexPath.row]
        vc?.paragraphText = filteredData[indexPath.row]
        vc?.imageUrl = "https://www.karel.com.tr/sites/default/files/pictures/ik-film-onerileri-a.jpg"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //Mark: SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        } else {
            for filteredString in data {
                if filteredString.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(filteredString)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
    @IBAction func backFromSearch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
