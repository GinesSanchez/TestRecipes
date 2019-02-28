//
//  RecipeDetailViewModel.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

enum RecipeReadyState {
    case recipeLoaded
}

protocol RecipeDetailViewModelDelegate: class {
    func viewModel(_ viewModel: RecipeDetailViewModel, stateDidChange state: ViewModelState<RecipeReadyState>)
}

final public class RecipeDetailViewModel {

    private weak var delegate: RecipeDetailViewModelDelegate?
    private var appContext: AppContextType
    private var recipe: Recipe?

    var viewModelState: ViewModelState<RecipeReadyState> = .loading {
        didSet {
            updateViewState(viewModelState)
        }
    }

    init(recipeId: String, delegate: RecipeDetailViewModelDelegate, appContext: AppContextType) {
        self.delegate = delegate
        self.appContext = appContext
        self.recipe = nil
    }
}

public extension RecipeDetailViewModel {

    func getRecipe(recipeId: String) {

        viewModelState = .loading

        self.appContext.recipeManager.getRecipe(id: recipeId) { [weak self] (recipe, error) in

            guard let error = error else {
                guard let recipe = recipe else {
                    self?.viewModelState = .failure(RecipeManagerError.unknownApiError)
                    return
                }

                self?.recipe = recipe
                self?.viewModelState = .ready(.recipeLoaded)
                return
            }

            self?.viewModelState = .failure(error)

        }
    }
}


private extension RecipeDetailViewModel {

    func updateViewState(_ state: ViewModelState<RecipeReadyState>) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.viewModel(strongSelf, stateDidChange: state)
        }
    }
}

// MARK: - Computed Properties
public extension RecipeDetailViewModel {

    var numberOfRowsInSection: Int {
        guard let count = recipe?.ingredients.count else { return 0 }
        return count
    }

    var infoTitle: String {
        return "Info".capitalized       //TODO: Localize
    }

    var ingredientsTitle: String {
        return "Ingredients".capitalized       //TODO: Localize
    }

    var publisherName: String {
        guard let recipe = self.recipe else {
            return "Publisher Name N/A."        //TODO: Localize
        }

        return recipe.publisher
    }

    var socialRank: String {
        guard let recipe = self.recipe else {
            return "Social Rank: N/A."              //TODO: Localize
        }

        return "Social Rank: \(recipe.socialRank)"  //TODO: Localize
    }

    var viewInstructionsButtonTitle: String {
        return "View Instructions"      //TODO: Localize
    }

    var viewOriginalButtonTitle: String {
        return "View Original"      //TODO: Localize
    }

    var messageText: String? {
        switch viewModelState {
        case .empty:
            return "No recipe found."      //TODO: Localize
        case .loading:
            return "Loading..."            //TODO: Localize
        case .ready(_):
            return nil
        case .failure(_):
            return nil
        }
    }

    var isMessageHidden: Bool {
        switch viewModelState {
        case .empty:
            return false
        case .loading:
            return false
        case .ready(_):
            return true
        case .failure(_):
            return false
        }
    }

    var instructionsUrl: URL? {
        guard let recipe = self.recipe else { return nil }
        return URL(string: recipe.instructionsUrl)
    }

    var originalUrl: URL? {
        guard let recipe = self.recipe else { return nil }
        return URL(string: recipe.originalUrl)
    }
}

// MARK: - Data Functions
extension RecipeDetailViewModel {

    func getRecipeImage(completionHandler: @escaping (UIImage?, RecipeManagerError?) -> Void) {

        guard let recipe = self.recipe else {
            completionHandler(nil, nil)
            return
        }

        self.appContext.recipeManager.getRecipeImage(urlString: recipe.imageUrl, completionHandler: { (image, error) in

            guard let image = image else {
                completionHandler(nil, error)
                return
            }

            completionHandler(image.resize(newWidth: 20, newHeight: 20), nil)
        })
    }

    func ingredientForRowAt(indexPath: IndexPath) -> String? {
        guard let recipe = self.recipe else { return nil }
        return recipe.ingredients[indexPath.row]
    }
}
