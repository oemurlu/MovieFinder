//
//  ViewController.swift
//  MovieFinder
//
//  Created by Osman Emre Ömürlü on 5.12.2022.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray: [MovieModel] = []
    var selectedMovieId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableMovieCell")
        tableView.allowsSelection = true
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Movie Finder"
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchImage.isHidden = true
        tableView.alpha = 1
        let searchedTitle = searchTextField.text
        if let q = searchedTitle {
            moviesArray = []
            getSearchResults(q)
        }
    }
    
    func getSearchResults(_ q: String) {
        if let url = URL(string: "http://www.omdbapi.com/?apikey=YOUR_API_KEY&s=\(q)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let result = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ resultData: Data) -> [MovieModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: resultData)
            
            for res in decodedData.Search {
                let movieModel = MovieModel(title: res.Title, year: res.Year, type: res.`Type`, poster: res.Poster, imdbID: res.imdbID)
                moviesArray.append(movieModel)
            }
            
            return moviesArray
        } catch {
            print("\(error)")
            return nil
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsVC" {
            self.title = nil
            let detailsVC = segue.destination as! DetailsViewController
             detailsVC.incomingID = selectedMovieId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableMovieCell", for: indexPath) as! MovieCell
        
        cell.movieName.text = movie.title
        cell.movieType.text = movie.type
        cell.movieYear.text = movie.year
        cell.movieImage.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: "placeholder.svg"))
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovieId = moviesArray[indexPath.row].imdbID
        performSegue(withIdentifier: "goToDetailsVC", sender: self)
    }
}

