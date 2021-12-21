//
//  MockedItem.swift
//  ChefCraftApp
//
//  Created by Work on 17.08.2021.
//

import Foundation

struct MockedItem {
    
    var userRecipes: UserRecipes

    init() {
      userRecipes = UserRecipes(id: "1", categoriesRecipes: [
        CategoryRecipes(id: "1", name: "First Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "These days it may seem odd to speak of grandma's cookie receipt, but at one time the only meaning of receipt was recipe. The first recorded use of receipt is a reference to a medicinal preparation in Chaucer's Canterbury Tales (c. 1386).", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "2", name: "Second Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "3", name: "3 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "4", name: "4 Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "5", name: "5 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "6", name: "6 Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "7", name: "7 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
    ], recipes: [
        Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ]),
        Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "Second RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "3", name: "RECIPE #3", image: "bitmap", description: "#3 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "3 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "4", name: "RECIPE #4", image: "bitmap", description: "#4 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "4 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "5", name: "RECIPE #5", image: "bitmap", description: "#5 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "5 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "6", name: "RECIPE #6", image: "bitmap", description: "#6 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "6 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "7", name: "RECIPE #7", image: "bitmap", description: "#7 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "7 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "8", name: "RECIPE #8", image: "bitmap", description: "#8 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "8 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "9", name: "RECIPE #9", image: "bitmap", description: "#9 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "9 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "10", name: "RECIPE #10", image: "bitmap", description: "#10 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "10 RECIPE - is best recipe", compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ])
    ])
    }
}
