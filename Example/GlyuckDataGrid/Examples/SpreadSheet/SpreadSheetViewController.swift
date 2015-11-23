//
//  SpreadSheetViewController.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import GlyuckDataGrid


class SpreadSheetViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate, SpreadSheetCellDelegate {
    enum Colors {
        static let border = UIColor.lightGrayColor()
        static let headerBackground = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    enum Constants {
        static let numberOfRows = 99
        static let numberOfLetters = 26
        static let charCodeForA = 65
    }
    let cellReuseIdentifier = "DataCell"
    var dataArray: [[String]] = [[String]](count: Constants.numberOfRows, repeatedValue: [String](count: Constants.numberOfLetters, repeatedValue: ""))

    @IBOutlet weak var dataGridView: DataGridView!

    static override func initialize() {
        super.initialize()

        let dataGridAppearance = DataGridView.glyuck_appearanceWhenContainedIn(self)
        dataGridAppearance.row1BackgroundColor = nil
        dataGridAppearance.row2BackgroundColor = nil

        let rowHeaderAppearance = DataGridViewRowHeaderCell.glyuck_appearanceWhenContainedIn(self)
        rowHeaderAppearance.normalBackgroundColor = Colors.headerBackground
        rowHeaderAppearance.borderLeftWidth = 1 / UIScreen.mainScreen().scale
        rowHeaderAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        rowHeaderAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        rowHeaderAppearance.borderLeftColor = Colors.border
        rowHeaderAppearance.borderBottomColor = Colors.border
        rowHeaderAppearance.borderRightColor = Colors.border

        let rowHeaderLabelAppearane = UILabel.glyuck_appearanceWhenContainedIn(self, class2: DataGridViewRowHeaderCell.self)
        rowHeaderLabelAppearane.appearanceTextAlignment = .Right

        let columnHeaderAppearance = DataGridViewColumnHeaderCell.glyuck_appearanceWhenContainedIn(self)
        columnHeaderAppearance.normalBackgroundColor = Colors.headerBackground
        columnHeaderAppearance.borderTopWidth = 1 / UIScreen.mainScreen().scale
        columnHeaderAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        columnHeaderAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        columnHeaderAppearance.borderTopColor = Colors.border
        columnHeaderAppearance.borderBottomColor = Colors.border
        columnHeaderAppearance.borderRightColor = Colors.border

        let cellAppearance = DataGridViewContentCell.glyuck_appearanceWhenContainedIn(self)
        cellAppearance.borderRightWidth = 1 / UIScreen.mainScreen().scale
        cellAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
        cellAppearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale
        cellAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)

        columnHeaderAppearance.normalBackgroundColor = UIColor(white: 0.95, alpha: 1)
        let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
        labelAppearance.appearanceFont = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        labelAppearance.appearanceTextAlignment = .Center
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataGridView.columnHeaderHeight = 40
        dataGridView.rowHeaderWidth = 40
        dataGridView.rowHeight = 44

        dataGridView.dataSource = self
        dataGridView.delegate = self

        dataGridView.registerNib(UINib(nibName: "SpreadSheetCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }

    // MARK: DataGridViewDataSource

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return Constants.numberOfLetters
    }

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return Constants.numberOfRows
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return String(Character(UnicodeScalar(Constants.charCodeForA + column)))
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return String(row + 1)
    }

    func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! SpreadSheetCell
        cell.delegate = self
        cell.border.bottomWidth = 1 / UIScreen.mainScreen().scale
        cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
        cell.border.bottomColor = Colors.border
        cell.border.rightColor = Colors.border
        cell.configureWithData(dataArray[indexPath.dataGridRow][indexPath.dataGridColumn], forIndexPath: indexPath)
        return cell
    }

    // MARK: DataGridViewDelegate

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return 60
    }

    func dataGridView(dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool {
        return false
    }

    // MARK: SpreadSheetCellDelegate

    func spreadSheetCell(cell: SpreadSheetCell, didUpdateData data: String, atIndexPath indexPath: NSIndexPath) {
        dataArray[indexPath.dataGridRow][indexPath.dataGridColumn] = data
    }
}
