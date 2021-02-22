//
//  ApiImageService.swift
//  Reciplease
//
//  Created by Elie Arquier on 21/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import Foundation

final class ApiImageService {

    private let imageRequest: ImageRequest
    
    init(imageRequest: ImageRequest = AlamofireSession()) {
        self.imageRequest = imageRequest
    }

    /// Alamofire request    
    func getImage(imageUrl: String, completion: @escaping (Bool, Data?) -> Void ) {
        imageRequest.getImage(imageUrl: imageUrl) { responseImage in
            guard responseImage.response?.statusCode == 200 else {
                completion(false, nil)
                return
            }
            guard let data = responseImage.data else {
                completion(false, nil)
                return
            }

            completion(true, data)
        }
    }
}
