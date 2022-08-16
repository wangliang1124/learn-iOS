//
//  MovieDetailViewController.swift
//  SpotlightSearch
//
//  Created by 王亮 on 2022/8/15.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var category: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieDesc: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var director: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stars: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rating: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    var movieInfo: Movie
    
    init(movieInfo: Movie) {
        self.movieInfo = movieInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieImage)
        view.backgroundColor = .white
        
        // TODO: improve constraints
        NSLayoutConstraint.activate([
        
        ])
        
        movieImage.fillToSuperView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = movieInfo.Title
        
       
        populateMovieInfo()
    }
    
    func populateMovieInfo() {
        movieTitle.text = movieInfo.Title
        movieImage.image = UIImage(named: movieInfo.Image)
        movieDesc.text = movieInfo.Description
        category.text = movieInfo.Category
        director.text = movieInfo.Director
        rating.text = movieInfo.Rating
        stars.text = movieInfo.Stars
    }
}
