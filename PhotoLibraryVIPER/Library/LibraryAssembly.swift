//
//  LibraryAssembly.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class LibraryAssembly {
    
    static let sharedInstance = LibraryAssembly()
    
    func configure(_ viewController: LibraryViewController) {
        let service: LibraryServiceProtocol = LibraryService()
        let interactor = LibraryInteractor()
        let presenter = LibraryPresenter()
        let router = LibraryRouter()
        router.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.service = service
        initLibraryCollectionView(viewController)
    }
    
    func initLibraryCollectionView(_ viewController: LibraryViewController) {
        viewController.navigationItem.title = "Photo Library"
        let layout = UICollectionViewFlowLayout()
        viewController.photoCollectionView = UICollectionView(frame: viewController.view.frame, collectionViewLayout: layout)
        viewController.photoCollectionView.backgroundColor = UIColor.white
        viewController.photoCollectionView.register(LibraryPhotoCell.self, forCellWithReuseIdentifier: LibraryPhotoCell.identifier)
        viewController.photoCollectionView.delegate = viewController
        viewController.photoCollectionView.dataSource = viewController
        viewController.view.addSubview(viewController.photoCollectionView)
    }
    
}
