//
//  DataGridViewLayout.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit

public class DataGridViewLayout: UICollectionViewLayout {
    public var dataGridView: DataGridView? {
        return self.collectionView as? DataGridView
    }

    public var rowHeight: CGFloat = 44
    public var sectionHeaderHeight: CGFloat = 44

    public func heightForRow(row: Int) -> CGFloat {
        return dataGridView?.dataGridDelegate?.dataGridView?(dataGridView!, heightForRow: row) ?? rowHeight
    }

    public func widthForColumn(column: Int) -> CGFloat {
        guard let width = dataGridView?.dataGridDelegate?.dataGridView?(dataGridView!, widthForColumn: column) else {
            if let dataGridView = dataGridView, dataSource = dataGridView.dataGridDataSource {
                let exactWidth = dataGridView.frame.width / CGFloat(dataSource.numberOfColumnsInDataGrid(dataGridView))
                return column == 0 ? ceil(exactWidth) : floor(exactWidth)
            }
            return 0
        }
        return width
    }

    public func heightForSectionHeader() -> CGFloat {
        return dataGridView?.dataGridDelegate?.sectionHeaderHeightForDataGridView?(dataGridView!) ?? sectionHeaderHeight
    }
}
