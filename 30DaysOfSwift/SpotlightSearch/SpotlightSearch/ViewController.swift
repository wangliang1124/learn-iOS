//
//  ViewController.swift
//  SpotlightSearch
//
//  Created by 王亮 on 2022/8/15.
//

import CoreSpotlight
import MobileCoreServices
import UIKit

struct Movie {
    var Title: String
    var Image: String
    var Description: String
    var Rating: String
    var Director: String
    var Category: String
    var Stars: String
}

class ViewController: UITableViewController {
    lazy var movieInfos = [Movie]()

    var selectedMovieIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovies()
        setupSearchableContent()

        navigationItem.title = "Movies"
        view.backgroundColor = .white

        tableView.register(MovieSummaryCell.self, forCellReuseIdentifier: "MovieSummaryCell")
    }

    func loadMovies() {
        if let path = Bundle.main.path(forResource: "MoviesData", ofType: "plist") {
            if let movies = NSMutableArray(contentsOfFile: path) as? [NSObject] {
                for movie in movies {
                    if let image = movie.value(forKey: "Image") as? String,
                       let title = movie.value(forKey: "Title") as? String,
                       let desc = movie.value(forKey: "Description") as? String,
                       let rating = movie.value(forKey: "Rating") as? String,
                       let director = movie.value(forKey: "Director") as? String,
                       let category = movie.value(forKey: "Category") as? String,
                       let stars = movie.value(forKey: "Stars") as? String {
                        movieInfos.append(Movie(Title: title, Image: image, Description: desc, Rating: rating, Director: director, Category: category, Stars: stars))
                    }
                }
            }
        }
    }

    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()

        for movieIndex in 0 ..< movieInfos.count {
            let movie = movieInfos[movieIndex]
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(contentType: .text)

            // set the title
            searchableItemAttributeSet.title = movie.Title

            // set the image
            let imagePathParts = movie.Image.components(separatedBy: ".")
            searchableItemAttributeSet.thumbnailURL = Bundle.main.url(forResource: imagePathParts.first, withExtension: imagePathParts.last)

            // set the desc
            searchableItemAttributeSet.contentDescription = movie.Description

            var keywords = [String]()
            let movieCategories = movie.Category.components(separatedBy: ", ")
            for category in movieCategories {
                keywords.append(category)
            }
            let stars = movie.Stars.components(separatedBy: ", ")
            for star in stars {
                keywords.append(star)
            }

            searchableItemAttributeSet.keywords = keywords

            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.MySpotlightSearch.\(movieIndex)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)

            searchableItems.append(searchableItem)

            CSSearchableIndex.default().indexSearchableItems(searchableItems) {
                if $0 != nil {
                    print($0?.localizedDescription)
                }
            }
        }
    }

    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo,
               let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as? String,
               let index = selectedMovie.components(separatedBy: ".").last,
               let movieIndex = Int(index) {
                let vc = MovieDetailViewController(movieInfo: movieInfos[movieIndex])
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    // MARK: - UITableViewDatasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MovieSummaryCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "MovieSummaryCell", for: indexPath) as? MovieSummaryCell {
            cell = reusableCell
        } else {
            cell = MovieSummaryCell()
        }
        let movieInfo = movieInfos[indexPath.row]
        let image = movieInfo.Image
        let title = movieInfo.Title
        let desc = movieInfo.Description
        let rating = movieInfo.Rating

        cell.movieImageView.image = UIImage(named: image)
        cell.movieTitle.text = title
        cell.movieDescription.text = desc
        cell.rating.text = rating

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(movieInfo: movieInfos[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
