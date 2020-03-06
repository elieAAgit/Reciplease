//
//  UIImage.swift
//  Reciplease
//
//  Created by Elie Arquier on 04/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

extension UIImageView {
    /// Display image on custom table view cell. Method that allows a more fluid display of images
    func load(image: String) {
        fetchImage(from: image) { (imageData) in
            if let data = imageData {
                // referenced imageView from main thread
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                // show as an alert
                print("Error loading image");
            }
        }
    }

    /// Method that allows a more fluid display of images
    private func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
}
