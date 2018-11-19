//
//  PhotoDetailViewController.swift
//  PhotoLibrary
//
//  Created by Евгений on 17/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInput: class {
    func addPhotoOnScrollView(_ image: UIImage, to index: Int)
    func addPhotoInfo(with text: String, to index: Int)
    func displaySelectedPhoto(at index: Int)
}

protocol PhotoDetailViewControllerOutput: class {
    func saveSelectedPhotoModel(_ selectedIndex: Int, from photos: [PhotoModel])
}

class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerInput {

    var presenter: PhotoDetailPresenterProtocol!
    
    var scrollView: UIScrollView!
    var container: UIView!
    var imageView: UIImageView!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addPhotoOnScrollView(_ image: UIImage, to index: Int) {
        scrollView.contentSize.width = scrollView.frame.width * CGFloat(index + 1)
        addContainerOnScrollView(to: index)
        initImageView()
        setImage(image)
    }
    
    func addPhotoInfo(with text: String, to index: Int) {
        initInfoLabel()
        setInfoTextLabel(text)
        configViews()
    }

    func addContainerOnScrollView(to index: Int) {
        let xPosition = view.frame.width * CGFloat(index)
        let frameView = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height - 64)
        container = UIView(frame: frameView)
    }
    
    func setInfoTextLabel(_ text: String) {
        label.text = text
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func initImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    func initInfoLabel() {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
    }
    
    func configViews() {
        container.addSubview(label)
        container.addSubview(imageView)
        scrollView.addSubview(container)
        addConstraints()
    }
    
    func displaySelectedPhoto(at index: Int) {
        let xPosition = view.frame.width * CGFloat(index)
        let point = CGPoint(x: xPosition, y: 0)
        scrollView.setContentOffset(point, animated: false)
    }

    func addConstraints() {
        let leftImageConstraint = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: container, attribute: .left, multiplier: 1.0, constant: 0)
        let topImageConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0)
        let rightImageConstraint = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: container, attribute: .right, multiplier: 1.0, constant: 0)
        
        let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1.0, constant: 0)
        let heightLabelConstraint = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: container, attribute: .height, multiplier: 0.2, constant: 0)
        
        let leftLabelConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: container, attribute: .left, multiplier: 1.0, constant: 0)
        let rightLabelConstraint = NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: container, attribute: .right, multiplier: 1.0, constant: 0)
        let bottomLabelConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        container.addConstraints([leftImageConstraint, topImageConstraint, rightImageConstraint, verticalConstraint, leftLabelConstraint, rightLabelConstraint, bottomLabelConstraint, heightLabelConstraint])
    }
    
}
