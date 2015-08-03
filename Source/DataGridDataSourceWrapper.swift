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

    public init(dataGridDataSource: DataGridViewDataSource) {
        self.dataGridDataSource = dataGridDataSource
        super.init()
    }

    // MARK: - UICollectionViewDataSource

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let numberOfRows = dataGridDataSource?.numberOfRowsInDataGridView(collectionView as! DataGridView) {
            return numberOfRows + 1
        }
        return 0
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGridDataSource?.numberOfColumnsInDataGridView(collectionView as! DataGridView) ?? 0
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let dataGridView = collectionView as? DataGridView else {
            // TODO: Throw an exception?
            return UICollectionViewCell()
        }

        if indexPath.section == 0 {
            let cell = DataGridViewHeaderCell()
            cell.textLabel.text = dataGridDataSource.dataGridView(dataGridView, titleForHeaderForColumn: indexPath.row)
            return cell
        } else {
            let cell = DataGridViewContentCell()
            cell.textLabel.text = dataGridDataSource.dataGridView(dataGridView, textForColumn: indexPath.row, atRow: indexPath.section - 1)
            return cell
        }
    }
}
