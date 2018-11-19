//
//  LibraryRouter.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol LibraryRouterProtocol: class {
    func showDetailPhotoController()
}

class LibraryRouter: LibraryRouterProtocol {
    
    weak var viewController: LibraryViewController!
    
    func showDetailPhotoController() {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let detailController = PhotoDetailViewController()
            detailController.view.backgroundColor = UIColor.white
            PhotoDetailAssembly.sharedInstance.configure(detailController)
            detailController.presenter.saveSelectedPhotoModel(selectedIndexPath.row, from: viewController.photos)
            viewController.navigationController?.pushViewController(detailController, animated: true)
        }
        
    }
    
}
