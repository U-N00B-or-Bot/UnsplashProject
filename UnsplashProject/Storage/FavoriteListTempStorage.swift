//U-N00B-or-Bot

import Foundation

class FavoriteListTempStorage: Codable{
    static let shared = FavoriteListTempStorage()

    var favoriteModels: [MainModel] = []
    var likeChecker = Set<String>()
    var likeChekerDict = [String:Int]()
    
    private init(){}
}
