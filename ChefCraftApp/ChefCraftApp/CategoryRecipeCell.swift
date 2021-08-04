//
//  CategoryRecipeCell.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import UIKit

class CategoryRecipeCell: UITableViewCell, CellInizializable {
    
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // - Internal Logic
    func setModel(_ model: CategoryRecipeCellModel) {
        self.recipeName.text = model.model.name
    }
    
}
