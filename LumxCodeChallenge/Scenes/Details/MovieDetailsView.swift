//
//  MovieDetailsView.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 13/03/24.
//

import UIKit

class MovieDetailsView: BaseView {

  //MARK: - Views

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "noImagePlaceholder")
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = .boldSystemFont(ofSize: 24)
    label.textColor = .white
    return label
  }()

  private lazy var yearLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.textColor = .white
    return label
  }()

  private lazy var genreLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 14, weight: .light)
    label.textColor = .white
    return label
  }()

  lazy var horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 100, height: 160)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self ))

    return collectionView
  }()

  lazy var textView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .clear
    textView.textColor = .white
    textView.font = .systemFont(ofSize: 14)
    return textView
  }()

  private lazy var titleYearStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel])
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var labelsVerticalStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleYearStackView, genreLabel])
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .leading
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor, UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0).cgColor]
    layer.locations = [0.0,1.0]
    return layer
  }()

  //MARK: - Setup

  override func setup() {
    addSubview(imageView)
    addSubview(labelsVerticalStackView)
    addSubview(horizontalCollectionView)
    addSubview(textView)
    setupConstraints()
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
      imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 300),

      labelsVerticalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      labelsVerticalStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      labelsVerticalStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

      horizontalCollectionView.topAnchor.constraint(equalTo: labelsVerticalStackView.bottomAnchor),
      horizontalCollectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      horizontalCollectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      horizontalCollectionView.heightAnchor.constraint(equalToConstant: 160),

      textView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor),
      textView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      textView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    ])
  }

  func configure(imagePath: String,
                 title: String,
                 year: String,
                 genres: [Genre],
                 detailText: String,
                 duration: String) {
    imageView.imageFromServerURL(imagePath, placeHolder: nil)
    titleLabel.text = title
    yearLabel.text = year.roundTripDate(style: .short)
    genreLabel.text = duration + "m - " + createGenresLabel(genres: genres)
    textView.text = detailText
  }

  private func createGenresLabel(genres: [Genre]) -> String {
    return genres.compactMap { $0.name }.joined(separator: " | ")
  }
}
