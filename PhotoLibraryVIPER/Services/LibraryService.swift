//
//  Service.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import Foundation
import Photos

protocol LibraryServiceProtocol: class {
    func fetchToPhotoLibrary(completion: @escaping ([PhotoModel]?) -> Void)
}

class LibraryService: LibraryServiceProtocol {
    
    func fetchToPhotoLibrary(completion: @escaping ([PhotoModel]?) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else {
                completion(nil)
                return
            }
            DispatchQueue.global(qos: .background).async {
                self.fetchAssetsPhotos(completion: completion)
            }
        }
    }
    
    func fetchAssetsPhotos(completion: ([PhotoModel]?) -> Void) {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let photos = PHAsset.fetchAssets(with: .image, options: fetchOption)
        completion(allPhotoFromLibrary(photos))
    }
    
    func allPhotoFromLibrary(_ photos: PHFetchResult<PHAsset>) -> [PhotoModel] {
        var modelPhotos: [PhotoModel] = []
        let range = IndexSet(0..<photos.count)
        for asset in photos.objects(at: range) {
            newPhoto(from: asset) { (photoModel) in
                modelPhotos.append(photoModel)
            }
        }
        return modelPhotos
    }
    
    func newPhoto(from asset: PHAsset, completion: @escaping (PhotoModel) -> Void) {
        getAssetImage(for: asset) { (image) in
            var locationPhoto: LocationPhoto?
            if let location = asset.location {
                locationPhoto = LocationPhoto(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            let sizeImage = SizePhoto(width: asset.pixelWidth, height: asset.pixelHeight)
            let photo = PhotoModel(image: image, size: sizeImage, creationDate: asset.creationDate, modificationDate: asset.modificationDate, location: locationPhoto)
            completion(photo)
        }

    }
    
    func getAssetImage(for asset: PHAsset, handler: @escaping (UIImage) -> Void) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: options) { (image, _) in
            if let image = image {
                handler(image)
            }
        }
    }
    
}
