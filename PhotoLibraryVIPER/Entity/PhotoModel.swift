//
//  PhotoModel.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

struct LocationPhoto {
    var latitude: Double
    var longitude: Double
}

struct SizePhoto {
    var width: Int
    var height: Int
}

struct PhotoModel {
    
    var image: UIImage
    var size: SizePhoto
    var creationDate: Date?
    var modificationDate: Date?
    var location: LocationPhoto?
    
    func getSizePhoto() -> String {
        return "Size: \(self.size.width) x \(self.size.height)\n"
    }
    
    func getCreationDate() -> String {
        if let date = self.creationDate {
            return "Creation date: \(date)\n"
        } else {
            return "Creation date: unknown\n"
        }
    }
    
    func getModificationDate() -> String {
        if let date = self.modificationDate {
            return "Modification date: \(date)\n"
        } else {
            return "Modification date: unknown\n"
        }
    }
    
    func getLocationPhoto() -> String {
        if let coordinate = self.location {
            return "Location: \(coordinate.latitude), \(coordinate.longitude)"
        } else {
            return "Location: unknown"
        }
    }

}
