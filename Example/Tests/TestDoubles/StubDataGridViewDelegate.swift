//
//  StubDataGridViewDelegate.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Foundation
import GlyuckDataGrid


class StubDataGridViewDelegate: NSObject, DataGridViewDelegate {
    var sectionHeaderHeight: CGFloat = 60
    var rowHeight: CGFloat = 70
    var columnWidth: CGFloat = 100
    var floatingColumns = [Int]()
    var shouldSortByColumnBlock: ((column: Int) -> Bool)?
    var didSortByColumnBlock: ((column: Int) -> Bool)?
    var shouldSelectRowBlock: ((indexPath: NSIndexPath) -> Bool)?
    var didSelectRowBlock: ((row: Int) -> Void)?

    func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat {
        return sectionHeaderHeight
    }

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

    func dataGridView(dataGridView: DataGridView, shouldSelectRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return shouldSelectRowBlock?(indexPath: indexPath) ?? true
    }

    func dataGridView(dataGridView: DataGridView, didSelectRow row: Int) {
        didSelectRowBlock?(row: row)
    }
}


class StubMinimumDataGridViewDelegate: DataGridViewDelegate {
}
