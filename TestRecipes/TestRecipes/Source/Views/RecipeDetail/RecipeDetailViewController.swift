//
//  RecipeDetailViewController.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipeDetailViewControllerDelegate: class {
    func openWebView(url: URL)
    func viewDidDisappear(viewController: RecipeDetailViewController)
}

final class RecipeDetailViewController: UIViewController {

    //Public Properties
    weak var delegate: RecipeDetailViewControllerDelegate?
    var appContext: AppContextType!
    var recipeId: String!

    //Private Properties
    private var viewModel: RecipeDetailViewModel!

    //IBOutlets
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var socialRankLabel: UILabel!

    @IBOutlet weak var viewInstructionsButton: UIButton!
    @IBOutlet weak var viewOriginalButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidDisappear(viewController: self)
    }
}


//MARK: - Set Up Methods
private extension RecipeDetailViewController {

    func setUp() {
        setUpViewModel()
        setUpNavigationBar()
        setUpImageViews()
        setUpTableView()
        setUpLabels()
        setUpButtons()
    }

    func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }

    func setUpViewModel() {
        viewModel = RecipeDetailViewModel(recipeId: recipeId, delegate: self, appContext: appContext)
        viewModel.getRecipe(recipeId: recipeId)
    }

    func setUpImageViews() {
        imageView.image = UIImage(named: "DefaultRecipeImage")
    }

    func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()    //Hide the extra empty cell divider lines
    }

    func setUpLabels() {
        ingredientsTitleLabel.text = viewModel.ingredientsTitle
        infoTitleLabel.text = viewModel.infoTitle
        publisherNameLabel.text = viewModel.publisherName
        socialRankLabel.text = viewModel.socialRank
    }

    func setUpButtons() {
        viewInstructionsButton.setTitle(viewModel.viewInstructionsButtonTitle, for: .normal)
        viewOriginalButton.setTitle(viewModel.viewOriginalButtonTitle, for: .normal)
        viewOriginalButton.isHidden = !viewModel.isMessageHidden
        viewInstructionsButton.isHidden = !viewModel.isMessageHidden
    }
}


//MARK: - IBAction
extension RecipeDetailViewController {

    @IBAction func viewInstructionsButtonTapped(_ sender: Any) {
        guard let instructionsUrl = viewModel.instructionsUrl else { return }
        delegate?.openWebView(url: instructionsUrl)
    }

    @IBAction func viewOriginalButtonTapped(_ sender: Any) {
        guard let originalUrl = viewModel.originalUrl else { return }
        delegate?.openWebView(url: originalUrl)
    }
}

//MARK: - UITableViewDataSource
extension RecipeDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()

        cell.textLabel?.text = viewModel.ingredientForRowAt(indexPath:indexPath)
        cell.isUserInteractionEnabled = false
        return cell
    }
}

//MARK: - UITableViewDataSource
extension RecipeDetailViewController: RecipeDetailViewModelDelegate {

    func viewModel(_ viewModel: RecipeDetailViewModel, stateDidChange state: ViewModelState<RecipeDetailReadyState>) {
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
private extension RecipeDetailViewController {

    func handleEmptyState() {
        updateView()
    }

    func handleReadyState(viewModel: RecipeDetailViewModel, state: RecipeDetailReadyState) {
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

    private func handleLoadingState(viewModel: RecipeDetailViewModel) {
        updateView()
    }
}

//MARK: - Update Methods
private extension RecipeDetailViewController {

    func updateView(errorMessage: String? = nil) {
        updateLabels(errorMessage: errorMessage)
        updateTableView()
        updateButtons()
        updateImageViews()
    }

    func updateLabels(errorMessage: String? = nil) {
        messageLabel.text = errorMessage != nil ? errorMessage : viewModel.messageText
        messageLabel.isHidden = viewModel.isMessageHidden

        publisherNameLabel.text = viewModel.publisherName
        socialRankLabel.text = viewModel.socialRank
    }

    func updateTableView() {
        tableView.reloadData()
    }

    func updateButtons() {
        viewOriginalButton.isHidden = !viewModel.isMessageHidden
        viewInstructionsButton.isHidden = !viewModel.isMessageHidden
    }

    func updateImageViews() {
        viewModel.getRecipeImage() { (image, error) in

            guard let image = image else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }
}

