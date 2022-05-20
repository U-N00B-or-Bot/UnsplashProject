//U-N00B-or-Bot

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    var model: MainModel?
    var date: String?
    var newDate = ""
    var isLiked = false
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if FavoriteListTempStorage.shared.likeChecker.contains(model!.id){
            isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        date = model?.created_at ?? ""
        
        guard let url = URL(string: model!.urls.full) else {return}
        image.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground,.forceTransition], completed: nil)
        
        getDate()
        label.text = "Author: \(model?.user.name ?? "noname")\nLocation: \(model?.location?.name ?? "unknown")\nDate: \(newDate)\nDownloads: \(model?.downloads ?? 0)"
        
    }
    
 
    
    @IBAction func dubleTap(_ sender: Any) {
        if isLiked == true{
            isLiked = false
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            modelRemoveFromSingleTon(model: model!)
            StorageManager.shared.saveData()
            alert(title: "Removed", message: "photo removed from list", actionTitle: "Ok")
            
        }else{
            isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            modelAddToSingleTon(model: model!)
            StorageManager.shared.saveData()
            alert(title: "Added", message: "Photo added to favorite photo list", actionTitle: "Ok")
            
        }
        
        
        
        }
    
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if isLiked == true{
            isLiked = false
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            modelRemoveFromSingleTon(model: model!)
            StorageManager.shared.saveData()
            alert(title: "Removed", message: "photo removed from list", actionTitle: "Ok")
            
        }else{
            isLiked = true
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            modelAddToSingleTon(model: model!)
            StorageManager.shared.saveData()
            alert(title: "Added", message: "Photo added to favorite photo list", actionTitle: "Ok")
            
        }
        
    }
    
    
    

    private func getDate(){
        if  date != "" {
            let dateString = date!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ-00:00"
            let date = formatter.date(from: dateString)
            formatter.dateFormat = "dd-MM-yyyy"
            newDate = formatter.string(from: date!)
        }
    }
    private func modelAddToSingleTon(model: MainModel){
        FavoriteListTempStorage.shared.favoriteModels.append(model)
        FavoriteListTempStorage.shared.likeChecker.insert(model.id)
        FavoriteListTempStorage.shared.likeChekerDict[model.id] = FavoriteListTempStorage.shared.favoriteModels.count - 1
    }
    private func modelRemoveFromSingleTon(model: MainModel){
        FavoriteListTempStorage.shared.favoriteModels.remove(at: FavoriteListTempStorage.shared.likeChekerDict[model.id]!)
        FavoriteListTempStorage.shared.likeChecker.remove(model.id)
        FavoriteListTempStorage.shared.likeChekerDict.removeValue(forKey: model.id)
    }
    
    private func alert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
