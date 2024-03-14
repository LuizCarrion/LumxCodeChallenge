//
//  HomeViewController.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
  func updateCollectionView()
  func displayError(error: Error)
}

class HomeViewController: BaseViewController<HomeView> {

  //MARK: - ViewModel

  var viewModel: HomeViewModelProtocol

  //MARK: - Init

  init(viewModel: HomeViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadUpcomingMovies()
  }

  func setup() {
    baseView.collectionView.delegate = self
    baseView.collectionView.dataSource = self
    baseView.delegate = self
    viewModel.delegate = self
  }
}

extension HomeViewController: HomeViewControllerDelegate, SegmentedControlDelegate {
  func displayError(error: Error) {
    print("error")
  }

  func updateCollectionView() {
    baseView.collectionView.reloadData()
  }

  func didChange() {
    baseView.collectionView.reloadData()
  }
}

//MARK: - CollectionView Delegate

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movies = baseView.segmentedControl.selectedSegmentIndex == 0 ? viewModel.popularMovies : viewModel.upcomingMovies
    let movie = movies[indexPath.row]
    viewModel.navigateToMovieDetails(movie: movie)
  }
}

//MARK: - CollectionView DataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.upcomingMovies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageTextCollectionViewCell.self), for: indexPath) as? ImageTextCollectionViewCell else {
      return UICollectionViewCell()
    }

    let movies = baseView.segmentedControl.selectedSegmentIndex == 0 ? viewModel.popularMovies : viewModel.upcomingMovies
    let movie = movies[indexPath.row]

    cell.configure(imageUrl: viewModel.generateImageUrl(path: movie.posterPath),
                   title: movie.originalTitle,
                   text: movie.releaseDate?.roundTripDate(style: .short))

    return cell
  }
}
