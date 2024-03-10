//
//  Coordinator.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 10/03/24.
//

import Foundation

class Coordinator {
  private(set) var childCoordinators: [Coordinator] = []

  func start() {
    preconditionFailure("This method needs to be overriden by concrete subclass.")
  }

  func finish() {
    preconditionFailure("This method needs to be overriden by concrete subclass.")
  }

  func addChildCoordinator(_ Coordinator: Coordinator) {
    childCoordinators.append(Coordinator)
  }

  func removeChildCoordinator(_ Coordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(of: Coordinator) {
      childCoordinators.remove(at: index)
    } else {
      print("Couldn't remove Coordinator: \(Coordinator). It's not a child Coordinator.")
    }
  }

  func removeAllChildCoordinatorsWith<T>(type _: T.Type) {
    childCoordinators = childCoordinators.filter { $0 is T == false }
  }

  func removeAllChildCoordinators() {
    childCoordinators.removeAll()
  }
}


// MARK: - Equatable
extension Coordinator: Equatable {
  static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
    return lhs === rhs
  }
}
