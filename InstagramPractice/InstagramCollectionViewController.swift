//
//  InstagramCollectionViewController.swift
//  InstagramPractice
//
//  Created by HSIEH CHIH YU on 2020/8/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class InstagramCollectionViewController: UICollectionViewController {
    
    var igPhotos = [InstagramInfo.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    var igData: InstagramInfo!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlStr = "https://www.instagram.com/inoriminase.official/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let photoResults = try?decoder.decode(InstagramInfo.self, from: data) {
                    self.igData = photoResults
                    self.igPhotos = photoResults.graphql.user.edge_owner_to_timeline_media.edges
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    }
            }.resume()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return igPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as!InstagramCollectionViewCell
        let photo = igPhotos[indexPath.row]
        if let url = photo.node.thumbnail_src {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.photoImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
