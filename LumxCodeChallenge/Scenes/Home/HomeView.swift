//
//  HomeView.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import UIKit

protocol SegmentedControlDelegate {
  func didChange()
}

class HomeView: BaseView {

  //MARK: - Views

  var delegate: SegmentedControlDelegate?

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = .boldSystemFont(ofSize: 22)
    label.textColor = .white
    label.text = "Popular Movies"
    return label
  }()

  private let gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor, UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0).cgColor]
    layer.locations = [0.0,1.0]
    return layer
  }()


  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: 120, height: 215)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.register(ImageTextCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageTextCollectionViewCell.self ))

    return collectionView
  }()

  lazy var segmentedControl: UISegmentedControl = {
    let items = ["Popular", "Upcoming"]
    let segmentedControl = UISegmentedControl(items: items)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    return segmentedControl
  }()


  //MARK: - Setup

  override func setup() {
    addSubview(collectionView)
    addSubview(segmentedControl)
    addSubview(titleLabel)
    setupGradientBackground()
  }

  private func setupGradientBackground() {
    layer.insertSublayer(gradientLayer, at: 0)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),

      titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),

      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  @objc func segmentedControlDidChange() {
    delegate?.didChange()
    titleLabel.text = (segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? "Popular") + " Movies"
  }
}
