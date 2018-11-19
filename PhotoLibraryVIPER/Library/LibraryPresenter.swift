//
//  LibraryPresenter.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol LibraryPresenterProtocol: LibraryViewControllerOutput, LibraryInteractorOutput {
}

class LibraryPresenter: LibraryPresenterProtocol {
    
    weak var view: LibraryViewControllerInput!
    var interactor: LibraryInteractorInput!
    var router: LibraryRouterProtocol!
    
    func presentDetailPhoto() {
        router.showDetailPhotoController()
    }
    
    func providedAllPhotos(_ photos: [PhotoModel]) {
        self.view.displayPhotos(photos)
    }
    
    func fetchPhotos() {
        interactor.fetchAllPhotosFromPhoneLibrary()
    }
    
    func providedAuthorizationError(_ text: String) {
        view.displayError(text)
    }
    
}
