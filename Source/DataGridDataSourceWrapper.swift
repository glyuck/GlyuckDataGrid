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
            return numberOfRows
        }
        return 0
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGridDataSource?.numberOfColumnsInDataGridView(dataGridView) ?? 0
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let column = indexPath.row
        let row = indexPath.section
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath) as! DataGridViewContentCell
        cell.textLabel.text = dataGridDataSource.dataGridView(dataGridView, textForColumn: column, atRow: row)
        if row % 2 == 0 {
            cell.backgroundColor = dataGridView.row1BackgroundColor
        } else {
            cell.backgroundColor = dataGridView.row2BackgroundColor
        }
        dataGridDataSource?.dataGridView?(dataGridView, configureContentCell: cell, atColumn: column, row: row)
        return cell
    }

    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let column = indexPath.row
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: DataGridView.ReuseIdentifiers.defaultHeader, forIndexPath: indexPath) as! DataGridViewHeaderCell
        cell.configureForDataGridView(dataGridView, indexPath: indexPath)
        var text = dataGridDataSource.dataGridView(dataGridView, titleForHeaderForColumn: column)
        if dataGridView.sortColumn == column {
            text += dataGridView.sortAscending ? " ↑" : " ↓"
            cell.isSorted = true
        } else {
            cell.isSorted = false
        }
        cell.textLabel.text = text
        dataGridDataSource?.dataGridView?(dataGridView, configureHeaderCell: cell, atColumn: column)
        return cell
    }
}
