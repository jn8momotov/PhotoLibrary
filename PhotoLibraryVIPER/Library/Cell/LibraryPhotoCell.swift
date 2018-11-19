//
//  LibraryPhotoCell.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol CellIdentifierProtocol: class {
    static var identifier: String { get }
    static var size: CGSize { get }
}

class LibraryPhotoCell: UICollectionViewCell, CellIdentifierProtocol {
    
    var photoView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        self.addSubview(photoView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return "LibraryPhotoCell"
    }
    
    static var size: CGSize {
        let sizeCell = (UIScreen.main.bounds.width) / 4 - 1
        return CGSize(width: sizeCell, height: sizeCell)
    }
    
}
