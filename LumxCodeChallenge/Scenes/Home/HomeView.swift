//
//  HomeView.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import UIKit

class HomeView: BaseView {

  //MARK: - Views
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: 100, height: 100)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.register(ImageTextCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageTextCollectionViewCell.self ))

    return collectionView
  }()

  lazy var segmentedControl: UISegmentedControl = {
    let items = ["Upcoming", "Popular"]
    let segmentedControl = UISegmentedControl(items: items)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()


  //MARK: - Setup

  override func setup() {
    addSubview(collectionView)
    addSubview(segmentedControl)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),

      collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
      collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    ])
  }
}
