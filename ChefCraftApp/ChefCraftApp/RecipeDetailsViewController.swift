//
//  RecipeDetailsViewController.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxCocoa
import RxSwift

class RecipeDetailsViewController: UIViewController, StoryboardInitializable {
    
    // - Outlets
    @IBOutlet weak var nameTitle: UILabel!
    
    // - Internal properties
    var presenter: RecipeDetailsPresenter!
    
    // - Private properties
    private let constants: Constants = .init()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
        
        nameTitle.text = presenter.details.title
    }
    
    // - UI Setup
    private func configUI() {
        
        self.configNavigationView()
    }
    
    // - Binding Setup
    private func configBinding() {
        
    }
    
    private func configNavigationView() {
        let button = UIButton(type: .custom)
        button.frame = self.constants.backButtonFrame
        button.backgroundColor = self.constants.backButtonBackgroundColor
        button.setImage(self.constants.backButtonImage, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.closeButton), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        barButton.tintColor = .white
        self.navigationItem.setLeftBarButton(barButton, animated: true)
    }
    
    // - Selectors
    @objc
    private func closeButton() {
        self.presenter.popView()
    }
}

private extension RecipeDetailsViewController {
    
    // MARK: - Internal constants
    struct Constants {
        let backButtonImage = UIImage(named: "backButton")
        let backButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.2)
        let backButtonFrame = CGRect(x: 0, y: 0, width: 34, height: 34)
    }
}
