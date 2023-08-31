//
//  MealListView.swift
//  IDesserts
//
//  Created by Jesus Garcia ibarra on 30/08/23.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {                                           //Navigate between the views of the application
            List {                                                 //Displays the list of meals
                ForEach(viewModel.meals, id: \.id) { meal in       //iterates over the list of meals and create a text view for each meal
                    NavigationLink {                               //Allow to navigate to MealDetailView when tapping on a meal
                        MealDetailView(meal: meal)
                            .navigationTitle(meal.name)
                    } label: {
                        Text("\(meal.name)")
                    }
                }
            }
            .navigationTitle("\(viewModel.category.rawValue) Recipes")
            .toolbar {                                              //Displays toolbar button
                Button("Change category") {                         //Allows user to change category
                    viewModel.changingCategory = true
                }
            }
            .task {                                                 //Fetches the meals for the current category
                await viewModel.fetchMealCategory()                 //Wait for the task to be completed before continuing
            }
        }
        .onChange(of: viewModel.category) { _ in       //Observes changes to the 'category' property (when category changes fetch is run again)
            Task {
                await viewModel.fetchMealCategory()
            }
        }
        .sheet(isPresented: $viewModel.changingCategory) {         //Presents a sheet where the user is allowed to change of cetegory
            ChangeCategoryForm(category: $viewModel.category, isPresented: $viewModel.changingCategory)
        }
    }
}

struct MealListView_Previews: PreviewProvider {      //Provide the preview of the Meal List
    static var previews: some View {
        MealListView()
    }
}

struct ChangeCategoryForm: View {
    @Binding var category: MealCategory
    @Binding var isPresented: Bool
    
    var body: some View {
        Form {
            Picker("Category", selection: $category) {
                ForEach(MealCategory.allCases, id: \.rawValue) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            Button("Done") {
                isPresented = false
            }
        }
    }
}
