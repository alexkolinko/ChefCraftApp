//
//  CategoryRecipesViewController.swift
//  shell
//
//  Created by Work on 04.08.2021.
//  Copyright © 2021 CoreTeka. All rights reserved.
//

import RxCocoa
import RxSwift

class CategoryRecipesViewController: UIViewController, StoryboardInitializable {

    // - Outlets

    // - Internal properties
    var presenter: CategoryRecipesPresenter!

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
