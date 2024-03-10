//
//  BaseViewController.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 10/03/24.
//

import UIKit

class BaseViewController <T: BaseView> : UIViewController {

  var baseView: T {
    if let view = self.view as? T {
      return view
    } else {
      let baseView = T()
      self.view = baseView
      return baseView
    }
  }

  override func loadView() {
    let baseView = T()
    self.view = baseView
  }
}
