//
//  RootViewController.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift

class RootViewController: UITabBarController, StoryboardInitializable {

    // - Internal properties
    var presenter: RootPresenter!

    // - Private properties
    private var disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // - UI Setup
    private func setupUI() {
        self.selectedIndex = RootTabItemTags.home.rawValue
        self.delegate = self
    }
}

// MARK: - RootViewController: UITabBarControllerDelegate
extension RootViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarTransaction(viewControllers: tabBarController.viewControllers)
    }
}
