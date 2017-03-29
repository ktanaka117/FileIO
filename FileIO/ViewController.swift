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
        
        makeDirectory()
        downloadImage()
    }

    func makeDirectory() {
        if let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let url = URL(string: documentDirectoryURL.absoluteString + "/hoge")!
            let fm = FileManager.default
            do {
                try fm.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("failed to create directory.")
            }
        }
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
            let targetImageFilePath = documentDirectoryURL.appendingPathComponent("hoge/\(imageFileName)")
            
            print("targetImageFilePath: \(targetImageFilePath)")
            
            do {
                try imageData.write(to: targetImageFilePath)
            } catch let error {
                print(error)
            }
            
            readFile()
        }
    }
    
    func readFile() {
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return }
        
        let targetImageFilePath = documentDirectoryURL.appendingPathComponent("hoge/ktanaka117.jpg")
        let data = try! Data(contentsOf: targetImageFilePath)
        
        print(data)
    }
    
}

