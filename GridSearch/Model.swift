//
//  Model.swift
//  GridSearch
//
//  Created by Ivan Valero on 14/11/2021.
//

import Foundation




struct RSS: Decodable {
    let feed: Feed
    
}

struct Feed: Decodable{
    let results: [Result]

}

struct Result: Decodable, Hashable {
    let name, artworkUrl100, releaseDate, artistName: String
}

struct Register: Decodable, Hashable {
    let copyright: String
}
