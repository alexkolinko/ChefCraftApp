//
//  HomeViewController.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxCocoa
import RxSwift

class HomeViewController: UIViewController, StoryboardInitializable {

    // - Outlets

    // - Internal properties
    var presenter: HomePresenter!

    // - Private properties
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }

    // - UI Setup
    private func configUI() {

    }

    // - Binding Setup
    private func configBinding() {

    }

}
