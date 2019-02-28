//
//  RecipeListViewModel.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

enum RecipeListReadyState {
    case readyToSearch
    case recipesListFound
}

protocol RecipeListViewModelDelegate: class {
    func viewModel(_ viewModel: RecipeListViewModel, stateDidChange state: ViewModelState<RecipeListReadyState>)
}

final public class RecipeListViewModel {

    private weak var delegate: RecipeListViewModelDelegate?
    private var appContext: AppContextType
    private var searchResultArray: [RecipeSearchResult]

    var viewModelState: ViewModelState<RecipeListReadyState> = .ready(.readyToSearch) {
        didSet {
            updateViewState(viewModelState)
        }
    }

    init(delegate: RecipeListViewModelDelegate, appContext: AppContextType) {
        self.delegate = delegate
        self.appContext = appContext
        self.searchResultArray = []
    }
}

public extension RecipeListViewModel {

    func getRecipeList(ingredient: String) {

        viewModelState = .loading

        self.appContext.recipeManager.getRecipes(ingredient: ingredient) { [weak self] (searchResultArray, error) in

            guard ingredient.count > 0 else {
                self?.viewModelState = .empty
                return
            }

            guard let error = error else {
                guard let searchResultArray = searchResultArray else {
                    self?.viewModelState = .failure(RecipeManagerError.unknownApiError)
                    return
                }

                self?.searchResultArray = searchResultArray
                self?.viewModelState = searchResultArray.count == 0 ? .empty : .ready(.recipesListFound)
                return
            }

            self?.viewModelState = .failure(error)
        }
    }
}

private extension RecipeListViewModel {

    func updateViewState(_ state: ViewModelState<RecipeListReadyState>) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.viewModel(strongSelf, stateDidChange: state)
        }
    }
}

// MARK: - Computed Properties
public extension RecipeListViewModel {

    var numberOfRowsInSection: Int {
        return searchResultArray.count
    }

    var messageText: String? {
        switch viewModelState {
        case .empty:
            return "No recipes found for this ingredient!"      //TODO: Localize
        case .loading:
            return "Loading..."                                 //TODO: Localize
        case .ready(let readyState):
            switch readyState {
            case .readyToSearch:
                return "Search for a recipe using an ingredient."   //TODO: Localize
            case .recipesListFound:
                return nil
            }
        case .failure(_):
            return nil
        }
    }

    var searchBarPlaceholder: String {
        return "Insert an ingredient."
    }

    var isTableViewHidden: Bool {
        switch viewModelState {
        case .empty:
            return true
        case .loading:
            return true
        case .ready(let readyState):
            switch readyState {
            case .readyToSearch:
                return true
            case .recipesListFound:
                return false
            }
        case .failure(_):
            return true
        }
    }
}

// MARK: - Data Functions
public extension RecipeListViewModel {

    func recipeSearchTitleForRowAt(indexPath: IndexPath) -> String {
        return searchResultArray[indexPath.row].title
    }

    func recipeSearchImageForRowAt(indexPath: IndexPath, completionHandler: @escaping (UIImage?, RecipeManagerError?) -> Void) {
        let recipeSearch = searchResultArray[indexPath.row]

        self.appContext.recipeManager.getRecipeImage(urlString: recipeSearch.imageUrl, completionHandler: { (image, error) in

            guard let image = image else {
                completionHandler(nil, error)
                return
            }

            completionHandler(image.resize(newWidth: 20, newHeight: 20), nil)
        })
    }

    func recipeForRowAt(indexPath: IndexPath) -> RecipeSearchResult {
        return searchResultArray[indexPath.row]
    }
}
