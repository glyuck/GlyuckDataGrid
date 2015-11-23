//
//  CollectionViewDataSource.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


/**
    This class incapsulates logic for data source of UICollectionView used internally by DataGridView. You should not use this class directly.
*/
public class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    public weak var dataGridView: DataGridView!

    public init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    // MARK: - UICollectionViewDataSource

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let numberOfRows = dataGridView?.dataSource?.numberOfRowsInDataGridView(dataGridView) {
            return numberOfRows
        }
        return 0
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGridView.dataSource?.numberOfColumnsInDataGridView(dataGridView) ?? 0
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let dataGridDataSource = dataGridView.dataSource else {
            fatalError("dataGridView.dataSource unexpectedly nil")
        }
        if let cell = dataGridDataSource.dataGridView?(dataGridView, cellForItemAtIndexPath: indexPath) {
            return cell
        } else {
            let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath) as! DataGridViewContentCell
            cell.textLabel.text = dataGridDataSource.dataGridView?(dataGridView, textForCellAtIndexPath: indexPath) ?? ""
            return cell
        }
    }

    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        guard let dataGridKind = DataGridView.SupplementaryViewKind(rawValue: kind) else {
            fatalError("Unexpected supplementary view kind: \(kind)")
        }

        switch dataGridKind {
        case .ColumnHeader: return columnHeaderViewForIndexPath(indexPath)
        case .RowHeader: return rowHeaderViewForIndexPath(indexPath)
        }
    }

    // MARK: - Custom methods
    public func columnHeaderViewForIndexPath(indexPath: NSIndexPath) -> DataGridViewColumnHeaderCell{
        guard let dataGridDataSource = dataGridView.dataSource else {
            fatalError("dataGridView.dataSource unexpectedly nil")
        }
        let column = indexPath.row
        if let view = dataGridDataSource.dataGridView?(dataGridView, viewForHeaderForColumn: column) {
            return view
        }
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: column)
        cell.configureForDataGridView(dataGridView, indexPath: indexPath)
        var text = dataGridDataSource.dataGridView?(dataGridView, titleForHeaderForColumn: column) ?? ""
        if dataGridView.sortColumn == column {
            text += (dataGridView.sortAscending ? cell.sortAscSuffix : cell.sortDescSuffix) ?? ""
            cell.isSorted = true
        } else {
            cell.isSorted = false
        }
        cell.textLabel.text = text
        return cell
    }

    public func rowHeaderViewForIndexPath(indexPath: NSIndexPath) -> DataGridViewRowHeaderCell{
        guard let dataGridDataSource = dataGridView.dataSource else {
            fatalError("dataGridView.dataSource unexpectedly nil")
        }
        let row = indexPath.section
        if let view = dataGridDataSource.dataGridView?(dataGridView, viewForHeaderForRow: row) {
            return view
        }
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader, forRow: row)
        cell.configureForDataGridView(dataGridView, indexPath: indexPath)
        var text = dataGridDataSource.dataGridView?(dataGridView, titleForHeaderForRow: row) ?? ""
/*
        if dataGridView.sortRow == row {
            text += (dataGridView.rowSortAscending ? cell.sortAscSuffix : cell.sortDescSuffix) ?? ""
            cell.isSorted = true
        } else {
            cell.isSorted = false
        }
*/
        cell.textLabel.text = text
        return cell
    }
}
