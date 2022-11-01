//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 30.06.2021.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    // MARK: - Initializer
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        isUserInteractionEnabled = true
        
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }
    
    // MARK: - Methods
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}

// MARK: - CollectionView Delegate, DataSource

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.set(imageURL: photos[indexPath.row].photUrlString)
        
        return cell
    }
}

extension GalleryCollectionView: RowLayoutDelegate {
    
    // Передаем размеры по каждой ячейке
    func collectionView(collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        
        return CGSize(width: width, height: height)
    }
}
