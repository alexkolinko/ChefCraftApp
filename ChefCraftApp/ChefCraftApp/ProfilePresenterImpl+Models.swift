//
//  ProfilePresenterImpl+Models.swift
//  ChefCraftApp
//
//  Created by Work on 20.12.2021.
//

import RxSwift
import RxCocoa

// MARK: - ProfilePresenterImpl + Output
extension ProfilePresenterImpl {
    struct Output {
        let progressData: Observable<ProgressUserModel>
    }
}
