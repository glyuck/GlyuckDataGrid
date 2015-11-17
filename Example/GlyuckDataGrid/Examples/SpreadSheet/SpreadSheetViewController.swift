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

    override func viewDidLoad() {
        super.viewDidLoad()

        dataGridView.dataSource = self
        dataGridView.delegate = self

        dataGridView.registerNib(UINib(nibName: "SpreadSheetCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }

    // MARK: DataGridViewDataSource

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return Constants.numberOfLetters + 1
    }

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return Constants.numberOfRows
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        if column == 0 {
            return ""
        } else {
            return String(Character(UnicodeScalar(Constants.charCodeForA + column - 1)))
        }
    }

    func dataGridView(dataGridView: DataGridView, configureHeaderCell cell: DataGridViewHeaderCell, atColumn column: Int) {
        cell.backgroundColor = Colors.headerBackground
        cell.border.topWidth = 1 / UIScreen.mainScreen().scale
        cell.border.leftWidth = column == 0 ? 1 / UIScreen.mainScreen().scale : 0
        cell.border.bottomWidth = 1 / UIScreen.mainScreen().scale
        cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
        cell.border.topColor = Colors.border
        cell.border.leftColor = Colors.border
        cell.border.bottomColor = Colors.border
        cell.border.rightColor = Colors.border
    }

    func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.dataGridColumn == 0 {
            let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath) as! DataGridViewContentCell
            cell.backgroundColor = Colors.headerBackground
            cell.textLabel.textAlignment = .Right
            cell.textLabel.text = String(indexPath.dataGridRow + 1)
            cell.border.leftWidth = 1 / UIScreen.mainScreen().scale
            cell.border.bottomWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.leftColor = Colors.border
            cell.border.bottomColor = Colors.border
            cell.border.rightColor = Colors.border
            return cell
        } else {
            let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! SpreadSheetCell
            let dataIndexPath = NSIndexPath(forColumn: indexPath.dataGridColumn - 1, row: indexPath.dataGridRow)
            cell.delegate = self
            cell.border.bottomWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.bottomColor = Colors.border
            cell.border.rightColor = Colors.border
            cell.configureWithData(dataArray[dataIndexPath.dataGridRow][dataIndexPath.dataGridColumn], forIndexPath: dataIndexPath)
            return cell
        }
    }

    // MARK: DataGridViewDelegate

    func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat {
        return 40
    }
    
    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return column == 0 ? 40 : 60
    }

    func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return column == 0
    }

    func dataGridView(dataGridView: DataGridView, shouldSelectRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    // MARK: SpreadSheetCellDelegate

    func spreadSheetCell(cell: SpreadSheetCell, didUpdateData data: String, atIndexPath indexPath: NSIndexPath) {
        dataArray[indexPath.dataGridRow][indexPath.dataGridColumn] = data
    }
}
