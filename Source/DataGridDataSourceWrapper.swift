//
//  DataGridDataSourceWrapper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit

public class DataGridDataSourceWrapper: NSObject, UICollectionViewDataSource {
    public weak var dataGridView: DataGridView!
    public weak var dataGridDataSource: DataGridViewDataSource!

    public init(dataGridView: DataGridView, dataGridDataSource: DataGridViewDataSource) {
        self.dataGridView = dataGridView
        self.dataGridDataSource = dataGridDataSource
        super.init()
    }

    // MARK: - UICollectionViewDataSource

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let numberOfRows = dataGridDataSource?.numberOfRowsInDataGridView(dataGridView) {
            return numberOfRows + 1
        }
        return 0
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGridDataSource?.numberOfColumnsInDataGridView(dataGridView) ?? 0
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DataGridViewHeaderCell", forIndexPath: indexPath) as! DataGridViewHeaderCell
            cell.textLabel.text = dataGridDataSource.dataGridView(dataGridView, titleForHeaderForColumn: indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DataGridViewContentCell", forIndexPath: indexPath) as! DataGridViewContentCell
            cell.textLabel.text = dataGridDataSource.dataGridView(dataGridView, textForColumn: indexPath.row, atRow: indexPath.section - 1)
            if indexPath.section % 2 == 1 {
                cell.backgroundColor = dataGridView.row1BackgroundColor
            } else {
                cell.backgroundColor = dataGridView.row2BackgroundColor
            }
            return cell
        }
    }
}
