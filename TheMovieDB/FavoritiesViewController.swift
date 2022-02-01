
import UIKit

class FavoritiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let desF = [("Nomadland"),
                ("Judas and the Black Messiah"),
                ("The Father"),
                ("Spider-Man: No Way Home"),
                ("In the Heights"),
                ("Summer of Soul"),
                ("Pig")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desF.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritiescell" , for: indexPath as IndexPath) as! FavoritiesTableViewCell
        cell.imageCell.image = UIImage(named: "heart")
        cell.titleCell.text = desF[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        super.viewWillAppear(animated)
    }
    
    @IBAction func backFromFavorities(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
