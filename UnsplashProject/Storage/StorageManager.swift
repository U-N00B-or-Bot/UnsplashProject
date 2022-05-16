//U-N00B-or-Bot

import Foundation



class StorageManager {
    static let shared = StorageManager()
    private init(){}
    
     func getData(){
        guard let data = UserDefaults.standard.object(forKey: "model") as? Data else {return}
        guard let array = try? JSONDecoder().decode([MainModel].self, from: data) else {return}
        
        guard let data1 = UserDefaults.standard.object(forKey: "likeCheckerDict") as? Data else {return}
        guard let dict = try? JSONDecoder().decode([String:Int].self, from: data1) else {return}
        
        guard let data2 = UserDefaults.standard.object(forKey: "likeChecker") as? Data else {return}
        guard let set = try? JSONDecoder().decode(Set<String>.self, from: data2) else {return}
        
        FavoriteListTempStorage.shared.favoriteModels = array
        FavoriteListTempStorage.shared.likeChekerDict = dict
        FavoriteListTempStorage.shared.likeChecker = set
    }
    
    func saveData(){
        guard let data = try? JSONEncoder().encode(FavoriteListTempStorage.shared.favoriteModels) else {return}
        UserDefaults.standard.set(data, forKey: "model")
        guard let data = try? JSONEncoder().encode(FavoriteListTempStorage.shared.likeChekerDict) else {return}
        UserDefaults.standard.set(data, forKey: "likeCheckerDict")
        guard let data = try? JSONEncoder().encode(FavoriteListTempStorage.shared.likeChecker) else {return}
        UserDefaults.standard.set(data, forKey: "likeChecker")
    }
}
