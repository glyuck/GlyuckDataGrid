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

    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return numberOfColumns
    }

    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return numberOfRows
    }

    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return "Title for column \(column)"
    }

    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return "Title for row \(row)"
    }

    func dataGridView(_ dataGridView: DataGridView, textForCellAtIndexPath indexPath: IndexPath) -> String {
        return "Text for cell \(indexPath.dataGridColumn)x\(indexPath.dataGridRow)"
    }
}


class StubDataGridViewDataSourceCustomCell: StubDataGridViewDataSource {
    var cellForItemBlock: ((dataGridView: DataGridView, indexPath: IndexPath)) -> UICollectionViewCell = { (dataGridView, indexPath) in
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath)
        cell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow
        return cell
    }

    var viewForColumnHeaderBlock: ((dataGridView: DataGridView, column: Int)) -> DataGridViewColumnHeaderCell = { (dataGridView, column) in
        let view = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: column)
        view.tag = column
        return view
    }

    var viewForRowHeaderBlock: ((dataGridView: DataGridView, row: Int)) -> DataGridViewRowHeaderCell = { (dataGridView, row) in
        let view = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader, forRow: row)
        view.tag = row
        return view
    }

    func dataGridView(_ dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewColumnHeaderCell {
        return viewForColumnHeaderBlock((dataGridView: dataGridView, column: column))
    }

    func dataGridView(_ dataGridView: DataGridView, viewForHeaderForRow row: Int) -> DataGridViewRowHeaderCell {
        return viewForRowHeaderBlock((dataGridView: dataGridView, row: row))
    }

    func dataGridView(_ dataGridView: DataGridView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemBlock((dataGridView: dataGridView, indexPath: indexPath))
    }
}
