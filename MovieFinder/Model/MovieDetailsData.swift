//
//  MovieDetailsData.swift
//  MovieFinder
//
//  Created by Osman Emre Ömürlü on 6.12.2022.
//

import Foundation


struct MovieDetailsData: Codable {
    let Title: String
    let Year: String
    let Genre: String
    let Runtime: String
    let Director: String
    let Writer: String
    let Plot: String
    let Language: String
    let Poster: String
    let imdbRating: String
}
