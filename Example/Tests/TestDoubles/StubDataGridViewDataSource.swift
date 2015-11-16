//
//  StubDataGridViewDataSource.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit
import GlyuckDataGrid


class StubDataGridViewDataSource: NSObject, DataGridViewDataSource {
    var numberOfColumns = 7
    var numberOfRows = 20
    var configureContentCellBlock: ((cell: DataGridViewContentCell, indexPath: NSIndexPath) -> Void)?
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

    func dataGridView(dataGridView: DataGridView, textForCellAtIndexPath indexPath: NSIndexPath) -> String {
        return "Text for cell \(indexPath.dataGridColumn)x\(indexPath.dataGridRow)"
    }

    func dataGridView(dataGridView: DataGridView, configureHeaderCell cell: DataGridViewHeaderCell, atColumn column: Int) {
        configureHeaderCellBlock?(cell: cell, column: column)
    }

    func dataGridView(dataGridView: DataGridView, configureContentCell cell: DataGridViewContentCell, atIndexPath indexPath: NSIndexPath) {
        configureContentCellBlock?(cell: cell, indexPath: indexPath)
    }
}


class StubDataGridViewDataSourceCustomCell: StubDataGridViewDataSource {
    var cellForItemBlock: ((dataGridView: DataGridView, indexPath: NSIndexPath) -> UICollectionViewCell) = { dataGridView, indexPath in
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath)
        cell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow
        return cell
    }

    func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return cellForItemBlock(dataGridView: dataGridView, indexPath: indexPath)
    }
}
