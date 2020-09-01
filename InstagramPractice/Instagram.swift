//
//  InstagramInfo.swift
//  InstagramPractice
//
//  Created by HSIEH CHIH YU on 2020/8/21.
//

import Foundation

struct InstagramInfo: Codable {
    let graphql: Graphql
    
    struct Graphql: Codable {
        let user: User
        
        struct User: Codable {
            let biography: String
            let external_url: URL?
            let edge_followed_by: Edge_followed_by
            
            struct Edge_followed_by: Codable {
                let count: Int
            }
            
            let edge_follow: Edge_follow
            
            struct Edge_follow: Codable {
                let count: Int
            }
            
            let full_name: String
            
            let category_enum: String
            
            let edge_owner_to_timeline_media: Edge_owner_to_timeline_media
            
            struct Edge_owner_to_timeline_media: Codable {
                let count: Int
                let edges: [Edges]
                
                struct Edges: Codable {
                    let node: Node
                    
                    struct Node: Codable {
                        let display_url: URL?
                        let thumbnail_src: URL?
                    }
                }
                
            }
            
            let profile_pic_url_hd: URL
            
            let username: String
        }
    }
}

