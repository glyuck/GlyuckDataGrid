//
//  SimpleDataGridViewController.swift
//
//  Created by Vladimir Lyukov on 07/30/2015.
//

import UIKit
import GlyuckDataGrid


class SimpleDataGridViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    var columnsTitles = ["Year", "Driver", "Age", "Team", "Engine", "Poles", "Wins", "Podiums", "Fastest\nlaps", "Points", "Clinched", "Points\nmargin"]
    var columns = ["season", "driver", "age", "team", "engine", "poles", "wins", "podiums", "fastest_laps", "points", "clinched", "point_margin"]
    var columnsWidths: [CGFloat] = [60, 200, 50, 120, 100, 50, 50, 65, 50, 50, 120, 50]

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
        return f1stats.count
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return columnsTitles[column]
    }

    func dataGridView(dataGridView: DataGridView, textForColumn column: Int, atRow row: Int) -> String {
        let fieldName = columns[column]
        return f1stats[row][fieldName]!
    }

    // MARK: DataGridViewDelegate

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnsWidths[column]
    }

    func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return column == 1
    }
}
