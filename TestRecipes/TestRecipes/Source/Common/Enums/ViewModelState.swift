//
//  ViewModelState.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-19.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

///
/// ViewModelState is a generic enum used to communicate / signal events from the viewModel to the ViewControllers
public enum ViewModelState<T> {

    /// The empty state indicates that nothing has happened yet.
    case empty

    /// The loading state indicates that the viewModel is loading something
    case loading

    /// The ready state indicates that some operation was ready. Use the generic type to model the specifics of
    /// this state.
    case ready(T)

    /// The failure state indicates that something went wrong with an operation.
    case failure(Error)
}
