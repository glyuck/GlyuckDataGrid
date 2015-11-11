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

    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        dataGridView.selectRow(indexPath.section, animated: false)
        dataGridDelegate.dataGridView?(dataGridView, didSelectRow: indexPath.section)
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
}
