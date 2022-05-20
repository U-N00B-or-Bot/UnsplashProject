//U-N00B-or-Bot

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var modelsArray: [MainModel] = []
    var timer: Timer?
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = NetworkService()
        network.fetch(dataType: [MainModel].self, from: nil) { result in
            switch result {
            case .success(let models):
                self.modelsArray = models
                self.photoCollection.reloadData()
                return
            case .failure(let error):
                print(error)
            }
        }
        
        self.photoCollection.dataSource = self
        self.photoCollection.delegate = self
        self.searchBar.delegate = self
        
    }
    
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
   

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailsViewController
        let cell = sender as! CollectionViewPhotoCell
        
        detailVC.model = cell.model
    }
    
    
}


// extension //
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                               UISearchBarDelegate
{
    
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            
            let network = NetworkService()
            network.fetch(dataType: [MainModel].self, from: searchText) { result in
                switch result {
                case .success(let models):
                    self.modelsArray = models
                    self.photoCollection.contentOffset = CGPoint(x: 0, y: 0)
                    self.photoCollection.reloadData()
                    return
                case .failure(let error):
                    print(error)
                    
                }
            }
            
            
        })
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewPhotoCell", for: indexPath) as! CollectionViewPhotoCell
        
        
        let model = modelsArray[indexPath.row]
        cell.configur(model: model)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemInRow: CGFloat = 2
        
        let paddingWidth = 20*(itemInRow+1)
        
        let constWidth = photoCollection.frame.width - paddingWidth
        
        let itemWidth = constWidth/itemInRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
