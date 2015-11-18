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
}


class StubDataGridViewDataSourceCustomCell: StubDataGridViewDataSource {
    var cellForItemBlock: ((dataGridView: DataGridView, indexPath: NSIndexPath) -> UICollectionViewCell) = { dataGridView, indexPath in
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath)
        cell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow
        return cell
    }

    var viewForHeaderBlock: ((dataGridView: DataGridView, column: Int) -> DataGridViewHeaderCell) = { dataGridView, column in
        let view = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultHeader, forColumn: column)
        view.tag = column
        return view
    }

    func dataGridView(dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewHeaderCell {
        return viewForHeaderBlock(dataGridView: dataGridView, column: column)
    }

    func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return cellForItemBlock(dataGridView: dataGridView, indexPath: indexPath)
    }
}
