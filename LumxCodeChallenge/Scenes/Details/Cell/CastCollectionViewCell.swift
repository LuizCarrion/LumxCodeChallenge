//
//  CastCollectionViewCell.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 14/03/24.
//

import UIKit

final class CastCollectionViewCell: ImageTextCollectionViewCell {

  var roleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakStrategy = .pushOut
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .white
    return label
  }()

  override func addComponents() {
    contentView.addSubview(imageView)
    contentView.addSubview(roleLabel)
    contentView.addSubview(titleLabel)
  }

  override func setupComponents() {
    titleLabel.font = .systemFont(ofSize: 14, weight: .medium)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      roleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      roleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -2),
      roleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      roleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

      titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: roleLabel.topAnchor, constant: -4),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
    ])
  }

  func configure(imageUrl: String?,
                          title: String?,
                          role: String?) {
    imageView.imageFromServerURL(imageUrl ?? "", placeHolder: UIImage(named: "noImagePlaceholder"))
    titleLabel.text = title
    roleLabel.text = role
  }
}
