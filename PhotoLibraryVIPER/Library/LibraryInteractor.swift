//
//  LibraryInteractor.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol LibraryInteractorInput: class {
    func fetchAllPhotosFromPhoneLibrary()
}

protocol LibraryInteractorOutput: class {
    func providedAllPhotos(_ photos: [PhotoModel])
    func providedAuthorizationError(_ text: String)
}

class LibraryInteractor: LibraryInteractorInput {
    
    var presenter: LibraryPresenterProtocol!
    var service: LibraryServiceProtocol!
    
    func fetchAllPhotosFromPhoneLibrary() {
        DispatchQueue.global(qos: .background).async {
            self.service.fetchToPhotoLibrary { (photos) in
                if let photos = photos {
                    self.presenter.providedAllPhotos(photos)
                } else {
                    let textError = "Error app’s authorization to access your photo library"
                    self.presenter.providedAuthorizationError(textError)
                }
            }
        }
        
    }
    
}
