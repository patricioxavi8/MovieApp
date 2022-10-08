//
//  MovieDetailViewController.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import UIKit
import AlamofireImage
class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    @IBOutlet weak var movieDurationLabel: UILabel!
    
    @IBOutlet weak var movieTaglineLabel: UILabel!
    
    @IBOutlet weak var movieOverViewLabel: UILabel!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    private var movieDetailViewModel:MovieDetailViewModel!
    @IBOutlet weak var movieBackdropImageView: UIImageView!
    var movie:Movie!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel = MovieDetailViewModel(apiService: APIService())
        setupMovie()
        
    }
    
    
    
    
    
    
    private func setupMovie(){
        
        movieDetailViewModel.getMovie(idMovie: self.movie.id) { [weak self] (response: Movie?) in
            if let movieResponse = response {
                self?.movie = movieResponse
                self?.movieTitleLabel.text = self!.movie.title
                self?.movieOverViewLabel.text = self?.movie.overview
                self?.movieDurationLabel.text = String((self?.movie.runtime)!) + " min"
                self?.movieGenreLabel.text = self?.movie.genres!.reduce("") { $0 + ($1.name)! + " "}
                
                self?.movieTaglineLabel.text = self?.movie.tagline
                
                
                let url = URL(string:(self?.movie.poster_path)!)!
                self?.moviePosterImageView.af.setImage(withURL: url,imageTransition: .crossDissolve(0.2) )
                
                let urlBack = URL(string:(self?.movie.backdrop_path)!)
                
                self?.movieBackdropImageView.af.setImage(
                    withURL: urlBack!,
                    imageTransition: .crossDissolve(0.2))
                
                return
            }
            
            self?.Alert(withTitle: "Error", message: "Error al consultar información")
        }
        
    }
    
    
    
    
    @IBAction func clickTrailerButton(_ sender: Any) {
        UIApplication.shared.open((self.movie.videos?.results[0].youtubeURL)!, options: [:], completionHandler: nil)
        
    }
}


extension UIViewController {
    
    func Alert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
