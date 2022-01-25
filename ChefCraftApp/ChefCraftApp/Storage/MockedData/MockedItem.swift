//
//  MockedItem.swift
//  ChefCraftApp
//
//  Created by Work on 17.08.2021.
//

import Foundation

struct MockedItem {
    
    var userRecipes: UserRecipes
    
    var restaurants: [Restaurant]

    init() {
      userRecipes = UserRecipes(id: "1", categoriesRecipes: [
        CategoryRecipes(id: "1", name: "First Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "These days it may seem odd to speak of grandma's cookie receipt, but at one time the only meaning of receipt was recipe. The first recorded use of receipt is a reference to a medicinal preparation in Chaucer's Canterbury Tales (c. 1386).", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 46.482_952, longitude: 30.712_481, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "2", name: "Second Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "3", name: "3 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "4", name: "4 Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "5", name: "5 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "6", name: "6 Recipes", image: "breakfast", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(id: "7", name: "7 Recipes", image: "soup", recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
        CategoryRecipes(
            id: "8",
            name: "8 Recipes",
            image: "breakfast",
            recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450_003, longitude: 30.523_333, compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ])
        ]),
    ], recipes: [
        Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "First RECIPE - is best recipe", latitude: 50.450003, longitude: 30.523333, compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ]),
        Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "Second RECIPE - is best recipe", latitude: 50.450003, longitude: 30.523333, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "3", name: "RECIPE #3", image: "bitmap", description: "#3 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "3 RECIPE - is best recipe", latitude: 50.450004, longitude: 30.523333, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "4", name: "RECIPE #4", image: "bitmap", description: "#4 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "4 RECIPE - is best recipe", latitude: 40.730610, longitude: -73.935243, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "5", name: "RECIPE #5", image: "bitmap", description: "#5 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "5 RECIPE - is best recipe", latitude: 40.730610, longitude: -73.935242, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "6", name: "RECIPE #6", image: "bitmap", description: "#6 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "6 RECIPE - is best recipe", latitude: 40.730710, longitude: -73.935244, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "7", name: "RECIPE #7", image: "bitmap", description: "#7 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "7 RECIPE - is best recipe", latitude: 40.730810, longitude: -73.935246, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "8", name: "RECIPE #8", image: "bitmap", description: "#8 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "8 RECIPE - is best recipe", latitude: 40.730910, longitude: -73.935142, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "9", name: "RECIPE #9", image: "bitmap", description: "#9 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "9 RECIPE - is best recipe", latitude: 40.730110, longitude: -73.935342, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ]),
        Recipe(id: "10", name: "RECIPE #10", image: "bitmap", description: "#10 RECIPE - description",  owner: "Sarah", isLike: false, cooked: false, dateOfCooked: "", stars: 3, about: "10 RECIPE - is best recipe", latitude: 40.730210, longitude: -73.935842, compositions: [
            RecipeComposition(type: .calories, value: 200),
            RecipeComposition(type: .ingredients, value: 7),
            RecipeComposition(type: .totalTime, value: 40)
        ])
    ])
        
        restaurants = [
            Restaurant(id: "1", name: "Restauran 1", isOpen: true, latitude: 50.4312638, longitude: 30.5284701),
            Restaurant(id: "2", name: "Restauran 2", isOpen: false, latitude: 50.5225155, longitude: 30.590265),
            Restaurant(id: "3", name: "Restauran 3", isOpen: true, latitude: 50.4325155, longitude: 30.590265),
            Restaurant(id: "4", name: "Restauran 4", isOpen: false, latitude: 50.4077696, longitude: 30.6139807),
            Restaurant(id: "5", name: "Restauran 5", isOpen: true, latitude: 50.4007796, longitude: 30.6249807)
        ]
    }
}
