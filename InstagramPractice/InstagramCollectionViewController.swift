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
        //加入UI元件、位置及大小
        let postLabel = UILabel()
        let followersLabel = UILabel()
        let followingLabel = UILabel()
        let postNumberLabel = UILabel()
        let follwersNumberLabel = UILabel()
        let followingNumberLabel = UILabel()
        let userPhotoImageView = UIImageView()
        let fullNameLabel = UILabel()
        let typeLabel = UILabel()
        let biographyLabel = UILabel()
        let externalUrlLabel = UILabel()
        let editProfileButton = UIButton()
        let middleLinePath = UIBezierPath()
        let selectLinePath = UIBezierPath()
        let gridButton = UIButton()
        let taggedButton = UIButton()
        
        //畫線
        var middleLinePoint = CGPoint(x: 0, y: 250.5)
        middleLinePath.move(to: middleLinePoint)
        middleLinePoint = CGPoint(x: 374, y: 250.5)
        middleLinePath.addLine(to: middleLinePoint)
        let mdiddleLineLayer = CAShapeLayer()
        mdiddleLineLayer.path = middleLinePath.cgPath
        mdiddleLineLayer.lineWidth = 1
        mdiddleLineLayer.strokeColor = UIColor(red: 220 / 255, green: 221 / 255, blue: 220 / 255, alpha: 1).cgColor
        
        var selectLinePoint = CGPoint(x: 0, y: 293.5)
        selectLinePath.move(to: selectLinePoint)
        selectLinePoint = CGPoint(x: 188, y: 293.5)
        selectLinePath.addLine(to: selectLinePoint)
        let selectLineLayer = CAShapeLayer()
        selectLineLayer.path = selectLinePath.cgPath
        selectLineLayer.lineWidth = 1
        selectLineLayer.strokeColor = UIColor(white: 0, alpha: 1).cgColor
        
        //Label文字
        postLabel.text = "Posts"
        followersLabel.text = "Followers"
        followingLabel.text = "Following"
        
        //Button圖案
        editProfileButton.setImage(UIImage(named: "editProfile"), for: .normal)
        gridButton.setImage(UIImage(named: "grid"), for: .normal)
        taggedButton.setImage(UIImage(named: "tagged"), for: .normal)
        
        //Label字型樣式大小
        postLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        followersLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        followingLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        postNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        follwersNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        followingNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        fullNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        typeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        biographyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        externalUrlLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        //ImageView模式
        userPhotoImageView.contentMode = .scaleAspectFit
        
        //元件位置
        postLabel.frame = CGRect(x: 141, y: 49, width: 37, height: 18)
        followersLabel.frame = CGRect(x: 208, y: 49, width: 63, height: 18)
        followingLabel.frame = CGRect(x: 288, y: 49, width: 63, height: 18)
        postNumberLabel.frame = CGRect(x: 143, y: 29, width: 27, height: 21)
        follwersNumberLabel.frame = CGRect(x: 207, y: 29, width: 42, height: 21)
        followingNumberLabel.frame = CGRect(x: 313, y: 29, width: 32, height: 21)
        fullNameLabel.frame = CGRect(x: 16, y: 106, width: 36, height: 18)
        typeLabel.frame = CGRect(x: 16, y: 124, width: 145, height: 18)
        biographyLabel.frame = CGRect(x: 16, y: 142, width: 290, height: 18)
        userPhotoImageView.frame = CGRect(x: 15, y: 5, width: 87, height: 87)
        externalUrlLabel.frame = CGRect(x: 16, y: 178, width: 290, height: 18)
        editProfileButton.frame = CGRect(x: 16, y: 210, width: 343, height: 29)
        gridButton.frame = CGRect(x: 82, y: 262.5, width: 23, height: 23)
        taggedButton.frame = CGRect(x: 269, y: 262.5, width: 23, height: 23)

        //Label隨text做調整
        postLabel.sizeToFit()
        followersLabel.sizeToFit()
        followingLabel.sizeToFit()
        
        //Label行數
        biographyLabel.numberOfLines = 2
        
        //Label字型顏色
        externalUrlLabel.textColor = UIColor(red: 0, green: 53 / 255, blue: 105 / 255, alpha: 1)
        
        //將元件加入collectionView
        collectionView.addSubview(postLabel)
        collectionView.addSubview(followersLabel)
        collectionView.addSubview(followingLabel)
        collectionView.addSubview(postNumberLabel)
        collectionView.addSubview(follwersNumberLabel)
        collectionView.addSubview(followingNumberLabel)
        collectionView.addSubview(userPhotoImageView)
        collectionView.addSubview(fullNameLabel)
        collectionView.addSubview(typeLabel)
        collectionView.addSubview(biographyLabel)
        collectionView.addSubview(externalUrlLabel)
        collectionView.addSubview(editProfileButton)
        collectionView.layer.addSublayer(mdiddleLineLayer)
        collectionView.layer.addSublayer(selectLineLayer)
        collectionView.addSubview(gridButton)
        collectionView.addSubview(taggedButton)
        
        //連到IG API
        if let urlStr = "https://www.instagram.com/inoriminase.official/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let photoResults = try?decoder.decode(InstagramInfo.self, from: data) {
                    //將資料加入
                    self.igData = photoResults
                    self.igPhotos = photoResults.graphql.user.edge_owner_to_timeline_media.edges
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        postNumberLabel.text = String(self.igData.graphql.user.edge_owner_to_timeline_media.count)
                        follwersNumberLabel.text = formatter.string(from: NSNumber(value: self.igData.graphql.user.edge_followed_by.count))
                        followingNumberLabel.text = String(self.igData.graphql.user.edge_follow.count)
                        fullNameLabel.text = self.igData.graphql.user.full_name
                        typeLabel.text = self.igData.graphql.user.category_enum
                        biographyLabel.text = self.igData.graphql.user.biography
                        externalUrlLabel.text = self.igData.graphql.user.external_url?.absoluteString
                        print(self.igData.graphql.user.biography)
                        postNumberLabel.sizeToFit()
                        follwersNumberLabel.sizeToFit()
                        followingNumberLabel.sizeToFit()
                        fullNameLabel.sizeToFit()
                        typeLabel.sizeToFit()
                        biographyLabel.sizeToFit()
                        externalUrlLabel.sizeToFit()
                        
                        self.title = self.igData.graphql.user.username
                        
                        self.loadUserPhoto(image: userPhotoImageView)
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
    
    func loadUserPhoto(image: UIImageView) {
        //載入使用者相片
        let url = igData.graphql.user.profile_pic_url_hd
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    image.image = UIImage(data: data)
                }
            }
        }.resume()
        
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
