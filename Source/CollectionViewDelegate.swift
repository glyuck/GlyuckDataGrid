//
//  CollectionViewDelegate.swift
//  Pods
//
//  Created by Vladimir Lyukov on 31/07/15.
//
//

import UIKit


public class CollectionViewDelegate:  NSObject, UICollectionViewDelegate {
    private(set) public weak var dataGridView: DataGridView!

    init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataGridView.delegate?.dataGridView?(dataGridView, shouldSelectRow: indexPath.section) ?? true
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        dataGridView.selectRow(indexPath.section, animated: false)
        dataGridView.delegate?.dataGridView?(dataGridView, didSelectRow: indexPath.section)
    }

    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        dataGridView.deselectRow(indexPath.section , animated: false)
    }

    public func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        dataGridView.highlightRow(indexPath.section)
    }

    public func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        dataGridView.unhighlightRow(indexPath.section)
    }

    // MARK: - Custom delegate methods

    public func collectionView(collectionView: UICollectionView, shouldHighlightHeaderForColumn column: Int) -> Bool {
        return dataGridView.delegate?.dataGridView?(dataGridView, shouldSortByColumn: column) ?? false
    }

    public func collectionView(collectionView: UICollectionView, didTapHeaderForColumn column: Int) {
        if dataGridView.delegate?.dataGridView?(dataGridView, shouldSortByColumn: column) == true {
            if dataGridView.sortColumn == column {
                dataGridView.setSortColumn(column, ascending: !dataGridView.sortAscending)
            } else {
                dataGridView.setSortColumn(column, ascending: true)
            }
        }
    }
}
