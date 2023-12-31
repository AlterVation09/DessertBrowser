//
//  MealList-ViewModel.swift
//  IDesserts
//
//  Created by Jesus Garcia ibarra on 30/08/23.
//

import SwiftUI

extension MealListView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var meals = [Meal]()
        
        @Published var category = MealCategory.dessert
        @Published var changingCategory = false
        
        var urlString: String {
            "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        }
        
        func fetchMealCategory() async {
            func handleSuccess(_ mealList: MealCategoryQuery) -> Void {
                self.meals = mealList.meals.filter({ $0.thumbnailURL != nil }).sorted()
            }
            
            await fetch(from: urlString, onSuccess: handleSuccess)
        }
        
        func setCategory(category: MealCategory) {
            self.category = category
        }
    }
}
