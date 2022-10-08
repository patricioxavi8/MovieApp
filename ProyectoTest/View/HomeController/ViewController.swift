//
//  ViewController.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 3/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var spinner = UIActivityIndicatorView(style: .large)
    private var homeViewModel: HomeViewModel!
    var _movies: [Movie] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tablaPrueba: UITableView!
    
    private var cantidad: Int!
    var _searchedMovies: [Movie] = []
    
    var searching = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        homeViewModel = HomeViewModel(apiService: APIService())
        setDelegates()
        loadData()
        configSpinnerLoadingView()
        overrideUserInterfaceStyle = .dark
    }
    
    private func  getVisitedMovies(){
        do {
            var moviesVisitadas = [MovieVisited]()
            moviesVisitadas = try context.fetch(MovieVisited.fetchRequest())
            
            
            for mov in moviesVisitadas {
                let movieV = Movie(id: Int(mov.id), title: mov.title!, overview: mov.overview!, release_date: nil, vote_average: mov.vote_average, vote_count: nil,genres: nil,tagline: nil,videos: nil)
                _movies.append(movieV)
            }
        }catch{
            print("Error to get movies")
        }
        
    }
    
    
    private func loadData() {
        if NetWorkMonitor.shared.isConnected{
            homeViewModel.get(pageNumber: homeViewModel.pageNumber) { [weak self] (list: MoviesResponse) in
                self?._movies = list.results!
                self?.tablaPrueba.reloadData()
            }
        }else {
            
            getVisitedMovies()
        }
    }
    
    private func setDelegates(){
        
        self.tablaPrueba.delegate = self
        self.tablaPrueba.dataSource = self
        self.searchBar.delegate = self
    }
    
    func navigateToDetailsViewController (indexPath: IndexPath) {
        if NetWorkMonitor.shared.isConnected{
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            
            if searching {
                detailController.movie = self._searchedMovies[indexPath.row]
            }else {
                detailController.movie = self._movies[indexPath.row]
            }
            
            self.navigationController!.pushViewController(detailController, animated: true)
        }else
        {
            self.Alert(withTitle: "Error", message: "No connection detected")
        }
        
    }
    
    
    private func configSpinnerLoadingView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        //Autolayout
        spinner.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            spinner.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15),
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            spinner.widthAnchor.constraint(equalToConstant: 24),
            spinner.heightAnchor.constraint(equalToConstant: 24)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        spinner.isHidden = true
    }
    
    private func showSpinnerLoadingView(isShow: Bool) {
        if isShow {
            self.spinner.isHidden = false
            spinner.startAnimating()
        } else if spinner.isAnimating {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }
    
    private func loadMoreMovies() {
        
        let pageNumber = homeViewModel.pageNumber
        homeViewModel.pageNumber = pageNumber + 1
        
        showSpinnerLoadingView(isShow: true)
        homeViewModel.get(pageNumber: homeViewModel.pageNumber) { [weak self] (list: MoviesResponse) in
            self?._movies.append(contentsOf: list.results!)
            
            self?.showSpinnerLoadingView(isShow: false)
            self?.tablaPrueba.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    
    
    
    
}





//MARK: - UIScrollViewDelegate
extension ViewController : UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        
        if maximumOffset - currentOffset <= 20.0 {
            if NetWorkMonitor.shared.isConnected {
                self.loadMoreMovies()
            }
            
        }
    }
    
}




//MARK: - UIScrollViewDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self._searchedMovies = self._movies.filter { $0.title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        self.tablaPrueba.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.tablaPrueba.reloadData()
    }
}
