//
//  MovieDetailsViewController.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 13/03/24.
//

import UIKit

protocol MovieDetailsViewControllerDelegate: AnyObject {
  func updateCollectionView()
  func updateView()
}

class MovieDetailsViewController: BaseViewController<MovieDetailsView> {
  //MARK: - ViewModel

  let viewModel: MovieDetailsViewModelProtocol

  //MARK: - Init

  init(viewModel: MovieDetailsViewModelProtocol) {
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
    viewModel.getDetails()
    viewModel.getCredits()
  }

  func setup() {
    viewModel.delegate = self
    baseView.horizontalCollectionView.dataSource = self
  }
}

//MARK: - CollectionView Delegate

extension MovieDetailsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.credits?.cast.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as? CastCollectionViewCell else {
      return UICollectionViewCell()
    }

    let castMember = viewModel.credits?.cast[indexPath.row]

    cell.configure(imageUrl: viewModel.generateImageUrl(path: castMember?.profilePath),
                   title: castMember?.name,
                   role: castMember?.character)

    return cell
  }
}

//MARK: - ViewModel Delegate

extension MovieDetailsViewController: MovieDetailsViewControllerDelegate {
  func updateView() {
    baseView.configure(imagePath: viewModel.baseUrl + (viewModel.details?.backdropPath ?? ""),
                       title: viewModel.details?.originalTitle ?? "",
                       year: viewModel.details?.releaseDate ?? "",
                       genres: viewModel.details?.genres ?? [],
                       detailText: viewModel.details?.overview ?? "",
                       duration: String(viewModel.details?.runtime ?? 0))
  }

  func updateCollectionView() {
    baseView.horizontalCollectionView.reloadData()
  }
}
