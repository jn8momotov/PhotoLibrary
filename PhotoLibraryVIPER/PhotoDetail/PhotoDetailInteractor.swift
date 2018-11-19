//
//  PhotoDetailInteractor.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorOutput: class {
    func addPhotoOnView(_ photo: UIImage, info text: String, at index: Int)
    func setupSelectedPhoto(at index: Int)
}

protocol PhotoDetailInteractorInput: class {
    func configurePhotoModel(_ selectedIndex: Int, from photos: [PhotoModel])
}

class PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    var presenter: PhotoDetailInteractorOutput!
    
    var photoModel: PhotoModel!
    
    func configurePhotoModel(_ selectedIndex: Int, from photos: [PhotoModel]) {
        self.photoModel = photos[selectedIndex]
        self.addPhotos(photos)
        self.presenter.setupSelectedPhoto(at: selectedIndex)
    }
    
    func addPhotos(_ photos: [PhotoModel]) {
        for index in 0..<photos.count {
            let photo = photos[index]
            let image = photo.image
            let info = photo.getSizePhoto() + photo.getCreationDate() + photo.getModificationDate() + photo.getLocationPhoto()
            self.presenter.addPhotoOnView(image, info: info, at: index)
        }
    }
    
}
