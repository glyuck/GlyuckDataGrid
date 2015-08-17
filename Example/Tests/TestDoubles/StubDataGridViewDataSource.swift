//
//  StubDataGridViewDataSource.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Foundation
import GlyuckDataGrid


class StubDataGridViewDataSource: NSObject, DataGridViewDataSource {
    var numberOfColumns = 7
    var numberOfRows = 20
    var configureContentCellBlock: ((cell: DataGridViewContentCell, column: Int, row: Int) -> Void)?
    var configureHeaderCellBlock: ((cell: DataGridViewHeaderCell, column: Int) -> Void)?

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return numberOfColumns
    }

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return numberOfRows
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return "Title for column \(column)"
    }

    func dataGridView(dataGridView: DataGridView, textForColumn column: Int, atRow row: Int) -> String {
        return "Text for cell \(column)x\(row)"
    }

    func dataGridView(dataGridView: DataGridView, configureHeaderCell cell: DataGridViewHeaderCell, atColumn column: Int) {
        configureHeaderCellBlock?(cell: cell, column: column)
    }

    func dataGridView(dataGridView: DataGridView, configureContentCell cell:DataGridViewContentCell, atColumn column:Int, row: Int) {
        configureContentCellBlock?(cell: cell, column: column, row: row)
    }
}
