//
//  BaseView.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 10/03/24.
//

import UIKit

open class BaseView: UIView {
  override public init(frame: CGRect) {

    super.init(frame: frame)

    setup()
    setupConstraints()
  }

  required public init?(coder aDecoder: NSCoder) {

    super.init(coder: aDecoder)

    setup()
    setupConstraints()
  }

  open func setup() {}

  open func setupConstraints() {}
}
