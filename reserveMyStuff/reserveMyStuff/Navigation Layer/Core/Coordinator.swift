//
//  Coordinator.swift
//  canWeCoodinate
//
//  Created by Josh Franco on 3/28/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

/// Present modes for the coordinator pattern
enum NavigationMode {
    /// Push onto Root (Root needs to be a Nav Controller)
    case push(isAnimated: Bool = true)
    /// Present onto Root
    case present(isAnimated: Bool = true)
    /// Creates a Nav Controller and Presents it onto Root
    case embeddedPush(isAnimated: Bool = true)
}

/// Is in charge of the navigation for another class
protocol Coordinator: class {
    /// Services that are Injected into the coordinator
    var services: SomeServices? { get set }
    /// Parent: self's parent coordinator
    /// If Parent Coordinator is nil, then self is a the master coord
    var parent: Coordinator? { get set }
    /// Children is an array of coordinators
    /// Array's order keeps track of the navigation stack
    var children: [Coordinator] { get set }
    /// Root VC, will most likely be UINavigationController. Can inherit from the parent but will most likely be unique
    var rootViewController: UIViewController? { get set }
    
    init()
    
    /// Starts the Coordinator
    func start()
}

// MARK: - Public Methods
extension Coordinator {
    init(with services: SomeServices?) {
        self.init()
        self.services = services
    }
    
    /// Ends the coordinator and removes it from its parent
    /// If it does not have a parent it is the master coordinator and will dismiss its root
    func finish() {
        if let parent = parent {
            parent.removeChild(self)
        } else {
            rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func embedInParent(at index: Int? = nil) {
        guard let parentRoot = self.parent?.rootViewController else { return }
        
        switch parentRoot {
        case is UINavigationController:
            guard
                let root = self.rootViewController,
                let navController = parentRoot as? UINavigationController else { break }
        
            navController.pushViewController(root, animated: true)
        case is UITabBarController:
            guard
                    let root = self.rootViewController,
                    let tabBarController = parentRoot as? UITabBarController else { break }
            
            switch tabBarController.viewControllers {
              case .some where index != nil:
                guard let index = index else { break }
                tabBarController.viewControllers?.insert(root, at: index)
            case .some:
                tabBarController.viewControllers?.append(root)
            case .none:
                tabBarController.viewControllers = [root]
            }
        default: break
        }
    }
    
    /// Adds a child coordinator, and adds the parent as self
    /// - Parameter coordinator: coordinator to add as a child
    func addChild(_ coordinator: Coordinator) {
        guard !children.contains(where: { $0 === coordinator }) else { return }
        coordinator.parent = self
        
        self.children.append(coordinator)
    }
    
    func addChildren(_ coordinators: [Coordinator]) {
        coordinators.forEach { self.addChild($0) }
    }
    
    /// Removes a child coordinator and sets the parent to nil
    /// - Parameter coordinator: coordinator to remove, MUST exist as a child of self
    func removeChild(_ coordinator: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === coordinator }) else { return }
        
        coordinator.parent = nil
        if coordinator.rootViewController != self.rootViewController {
            coordinator.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        children.remove(at: index)
    }
    
    /// Use this method to check if self contains a child type
    /// - Parameter coordinator: Type of coordinator that this method will search for in its children
    func contains<T: Coordinator>(_ coordinator: T.Type) -> Bool {
        return children.contains { return type(of: $0) == coordinator }
    }
    
    /// Removes all children
    func removeAll() {
        children.forEach { removeChild($0) }
    }
    
    /// Navigates to VC and depends on self (the coordinator) to navigate the VC based on its nav result
    /// - Parameters:
    ///   - viewController: View controller to navigate too
    ///   - mode: type of navigation; defaults to push with isAnimated = true
    ///   - completion: navigation result; this is where the coordinator navigates the VC
    func navigate<T: UIViewController>(to viewController: T?,
                                       mode: NavigationMode = .push(),
                                       completion: @escaping (T.navResult, UIViewController?) -> Void) where T: Navigatable {
        guard let viewController = viewController else { return }
        viewController.navigation = completion
        
        switch mode {
        case .push(let isAnimated):
            guard let rootNavVC = rootViewController as? UINavigationController else { return }
            
            rootNavVC.pushViewController(viewController, animated: isAnimated)
        case .present(let isAnimated):
            rootViewController?.present(viewController, animated: isAnimated, completion: nil)
        case .embeddedPush(let isAnimated):
            let navigationVC = UINavigationController(rootViewController: viewController)
            rootViewController?.present(navigationVC, animated: isAnimated, completion: nil)
        }
    }
}


// MARK: Navigatable Methods
extension Coordinator where Self: Navigatable {
    /// Convenience method to start a coordinator and navigate the coordinator
    /// This method will most likely be used when a coordinator navigates another coordinator
    /// - Parameter viewController: VC to start on, defaults to parents rootVC
    /// - Parameter completion: navigation result; this is where the coordinator navigates the other coordinator
    func start(completion: @escaping (navResult, Coordinator) -> Void) {
        self.start()
        self.navigation = { [weak self] result, _ in
            guard let self = self else { return }
            
            completion(result, self)
        }
    }
}

// Temp Services, need to be updated to be useful
public struct SomeServices {
    let services = "?"
}
