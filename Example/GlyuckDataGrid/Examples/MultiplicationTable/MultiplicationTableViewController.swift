//
//  MultiplicationTableViewController.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 19/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import GlyuckDataGrid


class MultiplicationTableViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    @IBOutlet weak var dataGridView: DataGridView!

    static override func initialize() {
        super.initialize()

        let dataGridAppearance = DataGridView.glyuck_appearanceWhenContainedIn(self)
        dataGridAppearance.row1BackgroundColor = nil
        dataGridAppearance.row2BackgroundColor = nil

        let cornerHeaderAppearance = DataGridViewCornerHeaderCell.glyuck_appearanceWhenContainedIn(self)
        cornerHeaderAppearance.backgroundColor = UIColor.whiteColor()
        cornerHeaderAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        cornerHeaderAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        cornerHeaderAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        cornerHeaderAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)

        let rowHeaderAppearance = DataGridViewRowHeaderCell.glyuck_appearanceWhenContainedIn(self)
        rowHeaderAppearance.backgroundColor = UIColor(white: 0.95, alpha: 1)
        rowHeaderAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        rowHeaderAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)

        let columnHeaderAppearance = DataGridViewColumnHeaderCell.glyuck_appearanceWhenContainedIn(self)
        columnHeaderAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        columnHeaderAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)

        let cellAppearance = DataGridViewContentCell.glyuck_appearanceWhenContainedIn(self)
        cellAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        cellAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
        cellAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        cellAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)

        columnHeaderAppearance.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
        labelAppearance.appearanceFont = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        labelAppearance.appearanceTextAlignment = .Center
    }

    override func viewDidLoad() {
        dataGridView.delegate = self
        dataGridView.dataSource = self

        dataGridView.rowHeaderWidth = 30
        dataGridView.columnHeaderHeight = 30
    }

    // MARK: - DataGridViewDataSource

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return 9
    }

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return 9
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return String(row + 1)
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return String(column + 1)
    }

    func dataGridView(dataGridView: DataGridView, textForCellAtIndexPath indexPath: NSIndexPath) -> String {
        return String( (indexPath.dataGridRow + 1) * (indexPath.dataGridColumn + 1) )
    }

    // MARK: - DataGridViewDelegate

    func dataGridView(dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool {
        return false
    }

    func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat {
        if let layout = dataGridView.collectionView.collectionViewLayout as? DataGridViewLayout {
            return layout.widthForColumn(row)
        }
        return 44
    }
}