//U-N00B-or-Bot

import UIKit

class FavoriteListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StorageManager.shared.getData()
        tableView.rowHeight = 150
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //StorageManager.shared.getData()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        FavoriteListTempStorage.shared.favoriteModels.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        as! FavoriteCell
        
        
        let model = FavoriteListTempStorage.shared.favoriteModels[indexPath.row]
        cell.configur(model: model)
        
     

        return cell
    }
    

  
     
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
              if editingStyle == .delete {
                  
                
                  let cell = FavoriteListTempStorage.shared.favoriteModels.remove(at: indexPath.row)
                  FavoriteListTempStorage.shared.likeChecker.remove(cell.id)
                  FavoriteListTempStorage.shared.likeChekerDict.removeValue(forKey: cell.id)
                  
                
                  
                  StorageManager.shared.saveData()
                 
                  
                  self.tableView.reloadData()
                  
                  
                  
              }
           }
    

  

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let detailVC = segue.destination as! DetailsViewController
       let cell = sender as! FavoriteCell
        detailVC.model = cell.model
        
    }
    

}
