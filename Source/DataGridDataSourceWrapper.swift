//
//  DataGridDataSourceWrapper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit

public class DataGridDataSourceWrapper: NSObject, UICollectionViewDataSource {
    public weak var dataGridDataSource: DataGridViewDataSource!

    init(dataGridDataSource: DataGridViewDataSource) {
        self.dataGridDataSource = dataGridDataSource
        super.init()
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
