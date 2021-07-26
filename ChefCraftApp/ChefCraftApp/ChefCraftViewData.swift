//
//  ChefCraftViewData.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import RxDataSources

// MARK: - SessionOverviewViewData
struct SessionOverviewViewData: Equatable {
    let id: String
    let previewId: String
    let sectionModel: AnimatableSection<SessionOverviewContentBox>
    
//    struct SessionHeader {
//        let duration: Int
//        let title: String
//        let products: [UserProduct]
//    }
    
//    struct CoveredGoal {
//        let skinGoal: ProductSkinGoal
//    }
    
//    enum SessionPlanHolder: IdentifiableItem {
//        case header(title: String)
//        case plan(viewData: SessionPlan)
//    }
//
//    struct SessionPlan: Equatable {
//        let duration: Int
//        let title: String
//    }
    
    struct UserProduct {
        let id: String
        let title: String
        let marked: Bool
    }
    
    struct ProductAssociation {
        let id: String
        let title: String
        let description: String
    }
}

// MARK: - SessionOverviewContentBox
enum SessionOverviewContentBox: IdentifiableItem {
//    case header(item: SessionOverviewViewData.SessionHeader)
//    case description(text: String)
//    case coveredGoals(items: [SessionOverviewViewData.CoveredGoal])
    case guidance
//    case plan(items: [SessionOverviewViewData.SessionPlanHolder])
    case featuredProducts(items: [SessionOverviewViewData.ProductAssociation])
    
    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
//        case let .header(item):
//            let titleHeight: CGFloat = item.title.height(withConstrainedWidth: width - 44.0, font: UIFont(font: .granvilleBold, size: 26.0)!)
//            // 22 - top space
//            // 20 - bottom space
//            // 26 - products
//            // 16 - timer label
//            // all another space between items
//            let height = titleHeight + 98.0
//            return CGSize(width: width, height: height)
            
        case let .featuredProducts(items):
            let isMoreThenOneItem: Bool = items.count > 1
            // Base slider height
            let baseHeight: CGFloat = 154.0
            // PageControl elements height + spaces from top and bottom of it
            let pageControlHeight: CGFloat = 22.0
            
            return CGSize(width: width, height: isMoreThenOneItem ? (baseHeight + pageControlHeight) : baseHeight)
            
//        case let .plan(items):
//            let headerHeight: CGFloat = 20.0
//            let horizontalInset: CGFloat = 44.0
//            let verticalInset: CGFloat = 6.0
//
//            var sectionHeight: CGFloat = .zero
//
//            items.forEach { item in
//                if case let .plan(planItem) = item {
//                    let itemHeight = planItem.title.height(
//                        withConstrainedWidth: width - horizontalInset,
//                        font: UIFont(font: .muliLight, size: 12.0)!
//                    )
//                    sectionHeight += itemHeight + verticalInset
//                }
//            }
//
//            return CGSize(width: width, height: sectionHeight + headerHeight)
            
//        case let .description(text):
//            let descriptionHeight: CGFloat = text.height(withConstrainedWidth: width - 44.0, font: UIFont(font: .muliLight, size: 13.0)!)
//            return CGSize(width: width, height: descriptionHeight)
            
        case .guidance:
            return CGSize(width: width, height: 70.0)
            
//        case let .coveredGoals(items):
//            let isMoreThenOneLine: Bool = items.count > 3
//            let titleHeight: CGFloat = 20.0
//            let lineHeight: CGFloat = 50.0
//            let itemsBlockHeight: CGFloat = isMoreThenOneLine ? lineHeight * 2 : lineHeight
//            return CGSize(width: width, height: itemsBlockHeight + titleHeight)
        }
    }
}

extension SessionOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension SessionOverviewViewData.UserProduct: IdentifiableItem {
    var identity: String {
        id
    }
}

extension SessionOverviewViewData.ProductAssociation: IdentifiableItem {
    var identity: String {
        id
    }
}

//extension SessionOverviewViewData.CoveredGoal: IdentifiableItem {
//    static func == (lhs: SessionOverviewViewData.CoveredGoal, rhs: SessionOverviewViewData.CoveredGoal) -> Bool {
//        <#code#>
//    }
//    
//    var identity: String {
//        skinGoal.rawValue
//    }
//}
