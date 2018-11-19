//
//  PhotoDetailPresenter.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol PhotoDetailPresenterProtocol: PhotoDetailInteractorOutput, PhotoDetailViewControllerOutput {
    
}

class PhotoDetailPresenter: PhotoDetailPresenterProtocol {
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorInput!
    
    func saveSelectedPhotoModel(_ selectedIndex: Int, from photos: [PhotoModel]) {
        interactor.configurePhotoModel(selectedIndex, from: photos)
    }
    
    func addPhotoOnView(_ photo: UIImage, info text: String, at index: Int) {
        view.addPhotoOnScrollView(photo, to: index)
        view.addPhotoInfo(with: text, to: index)
    }
    
    func setupSelectedPhoto(at index: Int) {
        view.displaySelectedPhoto(at: index)
    }

}
