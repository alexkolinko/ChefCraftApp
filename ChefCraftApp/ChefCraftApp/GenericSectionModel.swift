//
//  GenericSectionModel.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import RxDataSources

// MARK: - Animatable Section Model
protocol IdentifiableItem: IdentifiableType & Equatable {
    var identity: String { get }
}

extension IdentifiableItem {
    var identity: String {
        String(describing: self)
            .strippingTextInParentheses
            .snakeCased
    }
}

struct AnimatableSection<SectionItem: IdentifiableItem>: AnimatableSectionModelType, Equatable
where SectionItem.Identity == String {

  var title: String?
  var items: [SectionItem]
  
  init(original: AnimatableSection, items: [SectionItem]) {
    self = original
    self.items = items
  }
  
  init(items: [SectionItem]) {
    self.items = items
  }
  
  var identity: String {
    items
      .map({ $0.identity })
      .reduce("", +)
  }

}

// MARK: - Common Section Model
struct Section<SectionItem>: SectionModelType, Equatable where SectionItem: Equatable {
  var items: [SectionItem]
  
  init(original: Section, items: [SectionItem]) {
    self = original
    self.items = items
  }
  
  init(items: [SectionItem]) {
    self.items = items
  }
}
