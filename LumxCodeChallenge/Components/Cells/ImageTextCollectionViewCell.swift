//
//  ImageTextCollectionViewCell.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 10/03/24.
//

import UIKit

class ImageTextCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Views

  lazy var imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakStrategy = .pushOut
    label.font = .systemFont(ofSize: 11)
    label.textColor = .white
    label.layer.borderWidth = 0.5
    label.layer.borderColor = UIColor.white.cgColor
    label.backgroundColor = .lightGray
    label.clipsToBounds = true
    return label
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakStrategy = .pushOut
    label.font = .systemFont(ofSize: 12)
    label.textColor = .white
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

  func initialize() {
    backgroundColor = .clear
    addComponents()
    setupComponents()
  }

  func addComponents() {
    contentView.addSubview(imageView)
    contentView.addSubview(textLabel)
    contentView.addSubview(titleLabel)
  }

  func setupComponents() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      textLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      textLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -2),
      textLabel.widthAnchor.constraint(equalToConstant: 70),

      titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
    ])
  }

  func configure(imageUrl: String?,
                 title: String?,
                 text: String? ) {
    imageView.imageFromServerURL(imageUrl ?? "", placeHolder: UIImage(named: "noImagePlaceholder"))
    titleLabel.text = title
    textLabel.text = text
  }
}
