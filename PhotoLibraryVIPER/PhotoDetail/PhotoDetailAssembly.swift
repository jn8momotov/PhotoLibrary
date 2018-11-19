//
//  PhotoDetailAssembly.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController) {
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: viewController.view.frame.height))
        initScrollView(viewController.scrollView)
        viewController.view.addSubview(viewController.scrollView)
    }
    
    func initScrollView(_ scroll: UIScrollView) {
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
    }
    
}
