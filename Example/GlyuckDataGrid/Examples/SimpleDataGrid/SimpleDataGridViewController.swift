//
//  SimpleDataGridViewController.swift
//
//  Created by Vladimir Lyukov on 07/30/2015.
//

import UIKit
import GlyuckDataGrid
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}



class SimpleDataGridViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    var dataSource = F1DataSource.stats

    @IBOutlet weak var dataGridView: DataGridView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dataGridView.dataSource = self
        dataGridView.delegate = self
    }

    // MARK: DataGridViewDataSource

    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return F1DataSource.columns.count
    }

    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return dataSource.count
    }

    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return F1DataSource.columnsTitles[column]
    }

    func dataGridView(_ dataGridView: DataGridView, textForCellAtIndexPath indexPath: IndexPath) -> String {
        let fieldName = F1DataSource.columns[indexPath.dataGridColumn]
        return dataSource[indexPath.dataGridRow][fieldName]!
    }

    func dataGridView(_ dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewColumnHeaderCell {
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: column)
        cell.title = self.dataGridView(dataGridView, titleForHeaderForColumn: column)
        if column == 1 {
            cell.border.rightWidth = 1 / UIScreen.main.scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
        return cell
    }

    func dataGridView(_ dataGridView: DataGridView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath) as! DataGridViewContentCell
        cell.textLabel.text = self.dataGridView(dataGridView, textForCellAtIndexPath: indexPath)
        switch indexPath.dataGridColumn {
        case 0,2,5,6,7,8,9,11:
            cell.textLabel.textAlignment = .right
        default:
            cell.textLabel.textAlignment = .left
        }
        if indexPath.dataGridColumn == 1 {
            cell.border.rightWidth = 1 / UIScreen.main.scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
        return cell
    }

    // MARK: DataGridViewDelegate

    func dataGridView(_ dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return F1DataSource.columnsWidths[column]
    }

    func dataGridView(_ dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return column == 1
    }

    func dataGridView(_ dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool {
        return true
    }

    func dataGridView(_ dataGridView: DataGridView, didSortByColumn column: Int, ascending: Bool) {
        let columnName = F1DataSource.columns[column]
        dataSource = F1DataSource.stats.sorted { ($0[columnName] < $1[columnName]) == ascending }
        dataGridView.reloadData()
    }
}
