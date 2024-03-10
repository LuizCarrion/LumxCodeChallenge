//
//  ImageTextCollectionViewCell.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 10/03/24.
//

import UIKit

class ImageTextCollectionViewCell: UICollectionViewCell {
  // MARK: - Views

  private lazy var imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  //MARK: - Setup

  private func initialize() {
    backgroundColor = .clear
    addComponents()
    setupComponents()
  }

  private func addComponents() {
    contentView.addSubview(imageView)
    contentView.addSubview(textLabel)
    contentView.addSubview(titleLabel)
  }

  private func setupComponents() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 35),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      textLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      textLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      textLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

      titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
    ])
  }

  func configure(image: UIImage?,
                 title: String?,
                 text: String? ) {
    imageView.image = image
    titleLabel.text = title
    textLabel.text = text
  }
}
