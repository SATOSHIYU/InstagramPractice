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
        }
    }
}

