//
//  CollectionViewDelegate.swift
//  Pods
//
//  Created by Vladimir Lyukov on 31/07/15.
//
//

import UIKit


/**
    This class incapsulates logic for delegate of UICollectionView used internally by DataGridView. You should not use this class directly.
 */
open class CollectionViewDelegate:  NSObject, UICollectionViewDelegate {
    fileprivate(set) open weak var dataGridView: DataGridView!

    init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    open func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return dataGridView.delegate?.dataGridView?(dataGridView, shouldSelectRow: (indexPath as NSIndexPath).section) ?? true
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataGridView.selectRow((indexPath as NSIndexPath).section, animated: false)
        dataGridView.delegate?.dataGridView?(dataGridView, didSelectRow: (indexPath as NSIndexPath).section)
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        dataGridView.deselectRow((indexPath as NSIndexPath).section , animated: false)
    }

    open func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        dataGridView.highlightRow((indexPath as NSIndexPath).section)
    }

    open func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        dataGridView.unhighlightRow((indexPath as NSIndexPath).section)
    }

    // MARK: - Custom delegate methods

    open func collectionView(_ collectionView: UICollectionView, shouldHighlightHeaderForColumn column: Int) -> Bool {
        return dataGridView.delegate?.dataGridView?(dataGridView, shouldSortByColumn: column) ?? false
    }

    open func collectionView(_ collectionView: UICollectionView, didTapHeaderForColumn column: Int) {
        if dataGridView.delegate?.dataGridView?(dataGridView, shouldSortByColumn: column) == true {
            if dataGridView.sortColumn == column {
                dataGridView.setSortColumn(column, ascending: !dataGridView.sortAscending)
            } else {
                dataGridView.setSortColumn(column, ascending: true)
            }
        }
    }
}
