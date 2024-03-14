//
//  StringExtension.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 14/03/24.
//

import Foundation

extension String {
  func roundTripDate(style: DateFormatter.Style) -> String? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.timeZone = .current

    formatter.dateFormat = "yyyy-MM-dd"
    guard let date = formatter.date(from: self) else {
      return nil
    }
    formatter.dateStyle = style
    return formatter.string(from: date)
  }
}
