//
//  RestaurantDetailView.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import RxCocoa
import RxSwift
import RxDataSources
import MapKit

class RestaurantDetailView: UIView {
    

    // - IBOutlet
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantIsOpen: UIImageView!
    @IBOutlet weak var contentView: ContentContainerView!
    @IBOutlet weak var closeViewButton: UIButton!
    
    @IBOutlet var view: UIView!
    
    // - Internal propreties
    let restaurantShowing = BehaviorRelay<Restaurant?>(value: nil)
    let dissmisView = PublishSubject<Void>()
    
    // - Private Properties
    private let bag = DisposeBag()
    
    private let cellSize: CGFloat = 32.0
    private let cellSpacing: CGFloat = 8.0
    
    // - Base Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        self.configureUI()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    // - Setups for view
    private func configureUI() {
        self.binding()
        self.configureContentView()
    }
    
    private func configureContentView() {
        let view = UIView(frame: self.contentView.frame)
        view.layer.masksToBounds = false
        view.layer.makeShadow(color: .black, x: 0.0, y: 1.0, blur: 4.0, spread: 0.0)
        self.contentView.insertSubview(view, at: 0)
    }
    
    private func binding() {
        
        self.restaurantShowing
            .subscribe(onNext: { [weak self] model in
                self?.restaurantName.text = model?.name
                self?.restaurantIsOpen.image = model?.isOpen ?? false ? UIImage(named: "imgOpen") : UIImage(named: "imgClose")
            })
            .disposed(by: self.bag)
        
        self.closeViewButton.rx.tap.asDriver()
            .throttle(.milliseconds(300), latest: false)
            .drive(onNext: { [weak self] in
                self?.dissmisView.onNext(())
            })
            .disposed(by: self.bag)
    }
}
