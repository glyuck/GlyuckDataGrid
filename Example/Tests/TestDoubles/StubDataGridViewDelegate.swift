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
    var shouldSortByColumnBlock: ((Int) -> Bool)?
    var didSortByColumnBlock: ((Int) -> Void)?
    var shouldSelectRowBlock: ((Int) -> Bool)?
    var didSelectRowBlock: ((Int) -> Void)?

    func dataGridView(_ dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnWidth
    }

    func dataGridView(_ dataGridView: DataGridView, heightForRow row: Int) -> CGFloat {
        return rowHeight
    }

    func dataGridView(_ dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return floatingColumns.index(of: column) != nil
    }

    func dataGridView(_ dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool {
        return shouldSortByColumnBlock?(column) ?? true
    }

    func dataGridView(_ dataGridView: DataGridView, didSortByColumn column: Int) {
        didSortByColumnBlock?(column)
    }

    func dataGridView(_ dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool {
        return shouldSelectRowBlock?(row) ?? true
    }

    func dataGridView(_ dataGridView: DataGridView, didSelectRow row: Int) {
        didSelectRowBlock?(row)
    }
}


class StubMinimumDataGridViewDelegate: DataGridViewDelegate {
}
