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
open class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    open weak var dataGridView: DataGridView!

    public init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    // MARK: - UICollectionViewDataSource

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let numberOfRows = dataGridView?.dataSource?.numberOfRowsInDataGridView(dataGridView) {
            return numberOfRows
        }
        return 0
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGridView.dataSource?.numberOfColumnsInDataGridView(dataGridView) ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let dataGridKind = DataGridView.SupplementaryViewKind(rawValue: kind) else {
            fatalError("Unexpected supplementary view kind: \(kind)")
        }

        switch dataGridKind {
        case .ColumnHeader: return columnHeaderViewForIndexPath(indexPath)
        case .RowHeader: return rowHeaderViewForIndexPath(indexPath)
        case .CornerHeader: return cornerHeaderViewForIndexPath(indexPath)
        }
    }

    // MARK: - Custom methods
    open func columnHeaderViewForIndexPath(_ indexPath: IndexPath) -> DataGridViewColumnHeaderCell{
        guard let dataGridDataSource = dataGridView.dataSource else {
            fatalError("dataGridView.dataSource unexpectedly nil")
        }
        let column = indexPath.index
        if let view = dataGridDataSource.dataGridView?(dataGridView, viewForHeaderForColumn: column) {
            return view
        }
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: column)
        cell.configureForDataGridView(dataGridView, indexPath: indexPath)
        cell.title = dataGridDataSource.dataGridView?(dataGridView, titleForHeaderForColumn: column) ?? ""
        return cell
    }

    open func rowHeaderViewForIndexPath(_ indexPath: IndexPath) -> DataGridViewRowHeaderCell{
        guard let dataGridDataSource = dataGridView.dataSource else {
            fatalError("dataGridView.dataSource unexpectedly nil")
        }
        let row = indexPath.index
        if let view = dataGridDataSource.dataGridView?(dataGridView, viewForHeaderForRow: row) {
            return view
        }
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader, forRow: row)
        cell.title = dataGridDataSource.dataGridView?(dataGridView, titleForHeaderForRow: row) ?? ""
        return cell
    }

    open func cornerHeaderViewForIndexPath(_ indexPath: IndexPath) -> DataGridViewCornerHeaderCell {
        let cell = dataGridView.dequeueReusableCornerHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader)
        return cell
    }
}
