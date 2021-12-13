//
//  ProfileViewController.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import RxCocoa
import RxSwift

class ProfileViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var recipePerDayCount: UILabel!
    
    // - Internal properties
    var presenter: ProfilePresenter!

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
