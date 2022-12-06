//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Osman Emre Ömürlü on 05.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var incomingID = ""
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieWriter: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieImdbRate: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSearchResults(incomingID)
    }
    
    
    func getSearchResults(_ q: String) {
        let urlString = "http://www.omdbapi.com/?apikey=YOUR_API_KEY&i=\(q)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let movieDetails = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.movieImage.sd_setImage(with: URL(string: movieDetails.poster), placeholderImage: UIImage(named: "placeholder.svg"))
                            
                            self.movieYear.text = "Year:  \(movieDetails.year)"
                            self.movieGenre.text = "Genre:  \(movieDetails.genre)"
                            self.movieRuntime.text = "Runtime:  \(movieDetails.runtime)"
                            self.movieDirector.text = "Director:  \(movieDetails.director)"
                            self.movieWriter.text = "Writer:  \(movieDetails.writer)"
                            self.moviePlot.text = "Plot:  \(movieDetails.plot)"
                            self.movieImdbRate.text = "IMDB:  \(movieDetails.imdbRating)"
                            
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ resultData: Data) -> MovieDetailsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetailsData.self, from: resultData)
            
            let title = decodedData.Title
            let year = decodedData.Year
            let poster = decodedData.Poster
            let genre = decodedData.Genre
            let runtime = decodedData.Runtime
            let director = decodedData.Director
            let writer = decodedData.Writer
            let plot = decodedData.Plot
            let language = decodedData.Language
            let imdbRating = decodedData.imdbRating

            let movieDetails = MovieDetailsModel(title: title, year: year, poster: poster, genre: genre, runtime: runtime, director: director, writer: writer, plot: plot, language: language, imdbRating: imdbRating)
        
            print("\(movieDetails)")
            return movieDetails
        } catch {
            print("\(error)")
            return nil
        }
    }


}
