//
//  StubDataGridViewDelegate.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Foundation
import GlyuckDataGrid


class StubDataGridViewDelegate: NSObject, DataGridViewDelegate {
    var rowHeight: CGFloat = 70
    var columnWidth: CGFloat = 100
    var floatingColumns = [Int]()
    var shouldSortByColumnBlock: ((column: Int) -> Bool)?
    var didSortByColumnBlock: ((column: Int) -> Bool)?
    var shouldSelectRowBlock: ((row: Int) -> Bool)?
    var didSelectRowBlock: ((row: Int) -> Void)?

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnWidth
    }

    func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat {
        return rowHeight
    }

    func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return floatingColumns.indexOf(column) != nil
    }

    func dataGridView(dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool {
        return shouldSortByColumnBlock?(column: column) ?? true
    }

    func dataGridView(dataGridView: DataGridView, didSortByColumn column: Int) {
        didSortByColumnBlock?(column: column)
    }

    func dataGridView(dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool {
        return shouldSelectRowBlock?(row: row) ?? true
    }

    func dataGridView(dataGridView: DataGridView, didSelectRow row: Int) {
        didSelectRowBlock?(row: row)
    }
}


class StubMinimumDataGridViewDelegate: DataGridViewDelegate {
}
