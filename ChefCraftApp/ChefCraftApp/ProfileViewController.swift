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
    @IBOutlet weak var recipePerDayLabel: UILabel!
    @IBOutlet weak var recipePerDayCount: UILabel!
    @IBOutlet weak var recipePerWeekLabel: UILabel!
    @IBOutlet weak var recipePerWeekCount: UILabel!
    @IBOutlet weak var missedRecipesLabel: UILabel!
    @IBOutlet weak var missedRecipesCount: UILabel!
    @IBOutlet weak var needToBeCookLabel: UILabel!
    @IBOutlet weak var needToBeCookCount: UILabel!
    
    // - Internal properties
    var presenter: ProfilePresenter!

    // - Private properties
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }

}

// MARK: - ProfileViewController + private
private extension ProfileViewController {
    // - UI Setup
    func configUI() {
        self.recipePerDayLabel.text = "Cooked recipe per day:"
        self.recipePerWeekLabel.text = "Cooked recipe per week:"
        self.missedRecipesLabel.text = "Missed сook recipes:"
        self.needToBeCookLabel.text = "Need to be cook recipes:"
    }

    // - Binding Setup
    func configBinding() {

        self.presenter.output.progressData
            .subscribe(onNext: { [weak self] userProgress in
                self?.recipePerDayCount.text = "\(userProgress.cookedRecipesPerDay)"
                self?.recipePerWeekCount.text = "\(userProgress.cookedRecipesPerWeek)"
                self?.missedRecipesCount.text = "\(userProgress.missedRecipes)"
                self?.needToBeCookCount.text = "\(userProgress.needToBeCook)"
            }).disposed(by: self.disposeBag)
    }
}
