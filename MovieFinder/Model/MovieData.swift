//
//  MovieData.swift
//  MovieFinder
//
//  Created by null on 6.12.2022.
//

import Foundation

struct MovieData: Codable {
    let Search: [Result]
}

struct Result: Codable {
    let Title: String
    let Year: String
    let `Type`: String
    let Poster: String
    let imdbID: String
}
