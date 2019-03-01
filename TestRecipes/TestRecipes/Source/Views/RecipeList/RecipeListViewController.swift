//
//  RecipeListViewController.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipeListViewControllerDelegate: class {
    func didSelect(recipeSearchResult: RecipeSearchResult)
}

final class RecipeListViewController: UIViewController {

    //Public Properties
    weak var delegate: RecipeListViewControllerDelegate?
    var appContext: AppContextType!

    //Private Properties
    private var viewModel: RecipeListViewModel!

    //IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
}

//MARK: - Set Up Methods
private extension RecipeListViewController {

    func setUp() {
        setUpViewModel()
        setUpSearchBar()
        setUpTableView()
        setUpLabels()        
    }

    func setUpViewModel() {
        viewModel = RecipeListViewModel(delegate: self, appContext: appContext)
    }

    func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }

    func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = viewModel.searchBarPlaceholder        
    }

    func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()    //Hide the extra empty cell divider lines
        tableView.isHidden = viewModel.isTableViewHidden
    }

    func setUpLabels() {
        messageLabel.text = viewModel.messageText
    }
}

//MARK: - UITableViewDataSource
extension RecipeListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()

        cell.textLabel?.text = viewModel.recipeSearchTitleForRowAt(indexPath: indexPath)
        cell.imageView?.image = UIImage(named: "DefaultRecipeImage")?.resize(newWidth: 20, newHeight: 20)

        viewModel.recipeSearchImageForRowAt(indexPath: indexPath) { (image, error) in
            
            guard let image = image else {
                return
            }

            DispatchQueue.main.async {
                cell.imageView?.image = image                
            }
        }

        return cell
    }
}

//MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        delegate?.didSelect(recipeSearchResult: viewModel.recipeForRowAt(indexPath: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension RecipeListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }

        viewModel.getRecipeList(ingredient: text)
    }
}

//MARK: - RecipeListViewModelDelegate
extension RecipeListViewController: RecipeListViewModelDelegate {

    func viewModel(_ viewModel: RecipeListViewModel, stateDidChange state: ViewModelState<RecipeListReadyState>) {
            switch state {
            case .empty:
                handleEmptyState()
            case .loading:
                handleLoadingState(viewModel: viewModel)
            case .ready(let readyState):
                handleReadyState(viewModel: viewModel, state: readyState)
            case .failure(let error):
                handleError(error: error)
            }
    }
}

//MARK: - Handle View Model State
private extension RecipeListViewController {

    func handleEmptyState() {
        updateView()
    }

    func handleReadyState(viewModel: RecipeListViewModel, state: RecipeListReadyState) {
        updateView()
    }

    func handleError(error: Error) {
        guard let recipeManagerError = error as? RecipeManagerError else {
            return
        }

        switch recipeManagerError {
        case .noInternetConnection:
            let errorMessage = "There is no internet connection. Please, check your internet settings on your device"       //TODO: Localize
            updateView(errorMessage: errorMessage)
        case .unknownApiError:
            let errorMessage = "An unknown error happens. Please, contact support."       //TODO: Localize
            updateView(errorMessage: errorMessage)
        case .unknownError:
            let errorMessage = "An unknown error happens. Please, contact support."       //TODO: Localize
            updateView(errorMessage: errorMessage)
        case .malformedRecipeSearchResultJson, .malformedURL:
            let errorMessage = "There was an error getting the data. Please, contact support."       //TODO: Localize
            updateView(errorMessage: errorMessage)        
        case .noDownloadedImage:
            return
        }
    }

    private func handleLoadingState(viewModel: RecipeListViewModel) {
        updateView()
    }
}

//MARK: - Update Methods
private extension RecipeListViewController {

    func updateView(errorMessage: String? = nil) {
        updateLabels(errorMessage: errorMessage)
        updateTableView()
    }

    func updateLabels(errorMessage: String? = nil) {
        messageLabel.text = errorMessage != nil ? errorMessage : viewModel.messageText
    }

    func updateTableView() {
        tableView.isHidden = viewModel.isTableViewHidden
        tableView.reloadData()
    }
}
