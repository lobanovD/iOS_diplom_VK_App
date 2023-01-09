//
//  UserPhotoViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 06.01.2023.
//

import UIKit
import TinyConstraints

final class UserPhotoViewController: UIViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: Setup
    func setup() {
        view.backgroundColor = VCConstants.mainViewBackgroungColor
        photoCollection.backgroundColor = VCConstants.mainViewBackgroungColor
        view.addSubview(photoCollection)
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.id)
        photoCollection.topToSuperview()
        photoCollection.bottomToSuperview()
        photoCollection.leftToSuperview()
        photoCollection.rightToSuperview()
    }
    
    // MARK: UI
    private lazy var photoCollection: UICollectionView = {
        let photoCollectionLayout = UICollectionViewFlowLayout()
        photoCollectionLayout.scrollDirection = .vertical
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionLayout)
        photoCollection.backgroundColor = .white
        photoCollection.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.id)
        return photoCollection
    }()
}

extension UserPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalStorage.shared.photosForHeader?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.id, for: indexPath) as! PhotoCell
        let photoArray = LocalStorage.shared.photosForHeader
        cell.configureCell(url: photoArray![indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddindWidth = 3 * (itemsPerRow + 1)
        let accessibleWidth = collectionView.frame.width - paddindWidth
        let widthPerItem = accessibleWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.33)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}

final class PhotoCell: UICollectionViewCell {
    
    static let id = "photoCell"
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photo)
        photo.edgesToSuperview()
    }
    
    // MARK: UI
    
    // Photo image
    private lazy var photo: WebImageView = {
        let photo = WebImageView()
        return photo
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: Setup
    
    public func configureCell(url: String) {
        self.photo.set(imageUrl: url)
    }
}
