//
//  DataGridDelegateWrapper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 31/07/15.
//
//

import UIKit

public class DataGridDelegateWrapper:  NSObject, UICollectionViewDelegate {
    private(set) public weak var dataGridView: DataGridView!
    private(set) public weak var dataGridDelegate: DataGridViewDelegate!

    init(dataGridView: DataGridView, dataGridDelegate: DataGridViewDelegate) {
        self.dataGridView = dataGridView
        self.dataGridDelegate = dataGridDelegate
        super.init()
    }

    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let column = indexPath.row
        if indexPath.section == 0 {
            return dataGridDelegate.dataGridView?(dataGridView, shouldSortByColumn: column) ?? false
        }
        return true
    }

    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let column = indexPath.row
        if indexPath.section == 0 {
            if dataGridView.sortColumn == column {
                dataGridView.setSortColumn(column, ascending: !dataGridView.sortAscending)
            } else {
                dataGridView.setSortColumn(column, ascending: true)
            }
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }
}
