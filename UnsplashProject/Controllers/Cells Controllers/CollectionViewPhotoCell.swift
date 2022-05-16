//U-N00B-or-Bot

import UIKit

class CollectionViewPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var image: UIImage?
    var model: MainModel?
    
    
    func configur(model: MainModel){
        self.model = model
        
        guard let url = URL(string: model.urls.small) else {return}
       
        photoImageView.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground], completed: nil)
   
        
     
    }
}
