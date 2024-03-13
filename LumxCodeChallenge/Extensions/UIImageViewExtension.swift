//
//  UIImageViewExtension.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 12/03/24.
//

// https://stackoverflow.com/questions/37018916/swift-async-load-image

import UIKit

extension UIImageView {


  func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {

    self.image = nil
    let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""


    if let url = URL(string: imageServerUrl) {
      URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

        if error != nil {
          print("ERROR LOADING IMAGES FROM URL: \(String(describing: error?.localizedDescription))")
          DispatchQueue.main.async {
            self.image = placeHolder
          }
          return
        }
        DispatchQueue.main.async {
          if let data = data {
            if let downloadedImage = UIImage(data: data) {

              self.image = downloadedImage
            }
          }
        }
      }).resume()
    }
  }
}
