//
//  LibraryViewController.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol LibraryViewControllerInput: class {
    func displayPhotos(_ photos: [PhotoModel])
    func displayError(_ text: String)
}

protocol LibraryViewControllerOutput: class {
    func presentDetailPhoto()
    func fetchPhotos()
}

class LibraryViewController: UIViewController, LibraryViewControllerInput {

    var photoCollectionView: UICollectionView!
    
    var presenter: LibraryPresenterProtocol!
    
    var photos: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.fetchPhotos()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        photoCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayPhotos(_ photos: [PhotoModel]) {
        self.photos = photos
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    func displayError(_ text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(actionCancel)
        present(alertController, animated: true, completion: nil)
    }

}

extension LibraryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryPhotoCell.identifier, for: indexPath) as! LibraryPhotoCell
        let photoModel = photos[indexPath.row]
        cell.photoView.image = photoModel.image
        return cell
    }
    
}

extension LibraryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.presentDetailPhoto()
    }
    
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return LibraryPhotoCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
