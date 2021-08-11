//
//  FavoritesViewController.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift

class FavoritesViewController: UIViewController, StoryboardInitializable {

    // - Outlets

    // - Internal properties
    var presenter: FavoritesPresenter!

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
