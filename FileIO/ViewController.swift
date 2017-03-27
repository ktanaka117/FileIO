//
//  ViewController.swift
//  FileIO
//
//  Created by 田中賢治 on 2017/03/27.
//  Copyright © 2017年 田中賢治. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage()
    }

    func downloadImage() {
        let imageURL = URL(string: "https://pbs.twimg.com/profile_images/836130575224201216/ykkPUBOE.jpg")!
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            if let data = data {
                self?.saveToLocalDirectory(imageData: data)
            }
        }
        task.resume()
    }
    
    func saveToLocalDirectory(imageData: Data) {
        let imageFileName = "ktanaka117.jpg"
        
        if let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let targetImageFilePath = documentDirectoryURL.appendingPathComponent(imageFileName)
            
            print("targetImageFilePath: \(targetImageFilePath)")
            
            do {
                try imageData.write(to: targetImageFilePath)
            } catch let error {
                print(error)
            }
        }
    }
    
}

