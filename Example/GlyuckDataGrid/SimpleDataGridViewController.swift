//
//  SimpleDataGridViewController.swift
//
//  Created by Vladimir Lyukov on 07/30/2015.
//

import UIKit
import GlyuckDataGrid


class SimpleDataGridViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    let columnsTitles = ["Year", "Driver", "Age", "Team", "Engine", "Poles", "Wins", "Podiums", "Fastest\nlaps", "Points", "Clinched", "Points\nmargin"]
    let columns = ["season", "driver", "age", "team", "engine", "poles", "wins", "podiums", "fastest_laps", "points", "clinched", "point_margin"]
    let columnsWidths: [CGFloat] = [60, 200, 50, 120, 110, 50, 50, 65, 50, 50, 130, 60]
    var dataSource = f1stats

    @IBOutlet weak var dataGridView: DataGridView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dataGridView.dataSource = self
        dataGridView.delegate = self
    }

    // MARK: DataGridViewDataSource

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return columns.count
    }

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return dataSource.count
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return columnsTitles[column]
    }

    func dataGridView(dataGridView: DataGridView, textForColumn column: Int, atRow row: Int) -> String {
        let fieldName = columns[column]
        return dataSource[row][fieldName]!
    }

    func dataGridView(dataGridView: DataGridView, configureHeaderCell cell: DataGridViewHeaderCell, atColumn column: Int) {
        if column == 1 {
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
    }

    func dataGridView(dataGridView: DataGridView, configureContentCell cell: DataGridViewContentCell, atColumn column: Int, row: Int) {
        switch column {
        case 0,2,5,6,7,8,9,11:
            cell.textLabel.textAlignment = .Right
        default:
            cell.textLabel.textAlignment = .Left
        }
        if column == 1 {
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
    }

    // MARK: DataGridViewDelegate

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnsWidths[column]
    }

    func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return column == 1
    }

    func dataGridView(dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool {
        return true
    }

    func dataGridView(dataGridView: DataGridView, didSortByColumn column: Int, ascending: Bool) {
        let columnName = columns[column]
        dataSource = f1stats.sort { ($0[columnName] < $1[columnName]) == ascending }
        dataGridView.reloadData()
    }
}
