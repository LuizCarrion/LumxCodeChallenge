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

  let viewModel: HomeViewModelProtocol

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
  }
}

extension HomeViewController: HomeViewControllerDelegate {
  func displayError(error: Error) {
    print("error")
  }

  func updateCollectionView() {
    print("request")
  }
}

//MARK: - CollectionView Delegate

extension HomeViewController: UICollectionViewDelegate {

}

//MARK: - CollectionView DataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageTextCollectionViewCell.self), for: indexPath) as? ImageTextCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configure(image: nil, title: "teste", text: "teste")
    return cell
  }
}
