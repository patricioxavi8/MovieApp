//
//  MovieTableViewCell.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import UIKit
import AlamofireImage
class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var movieOverview: UILabel!
    
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieAverage: UILabel!
    
    static let identifier = "celdaPrueba"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureCell(movie:Movie){
        self.movieTitle.text = movie.title
        self.movieOverview.text = movie.overview
        self.movieYear.text = movie.releaseYear()
        self.movieAverage.text = String(format: " %.1f ", movie.vote_average!)
        if let posterBackdropPath = movie.poster_path {
            let urlString = "\(Constants.BACK_DROP_BASE_URL)\(posterBackdropPath)"
            let url = URL(string:(urlString))
            self.moviePoster.af.setImage(withURL: url!,placeholderImage: UIImage(named: "noImageAvailable")!, imageTransition: .crossDissolve(0.2) )
        }
        
        
        
        
    }
    
    
    
    
    
}
