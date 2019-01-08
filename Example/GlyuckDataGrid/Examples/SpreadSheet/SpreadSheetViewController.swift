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
        static let border = UIColor.lightGray
        static let headerBackground = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    enum Constants {
        static let numberOfRows = 99
        static let numberOfLetters = 26
        static let charCodeForA = 65
    }
    let cellReuseIdentifier = "DataCell"
    var dataArray: [[String]] = [[String]](repeating: [String](repeating: "", count: Constants.numberOfLetters), count: Constants.numberOfRows)

    @IBOutlet weak var dataGridView: DataGridView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let dataGridAppearance = DataGridView.glyuck_appearanceWhenContained(in: DataGridView.self)!
        dataGridAppearance.row1BackgroundColor = nil
        dataGridAppearance.row2BackgroundColor = nil
        
        let cornerHeaderAppearance = DataGridViewCornerHeaderCell.glyuck_appearanceWhenContained(in: DataGridView.self)!
        cornerHeaderAppearance.backgroundColor = Colors.headerBackground
        cornerHeaderAppearance.borderLeftWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderTopWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderRightWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderLeftColor = Colors.border
        cornerHeaderAppearance.borderTopColor = Colors.border
        cornerHeaderAppearance.borderRightColor = Colors.border
        cornerHeaderAppearance.borderBottomColor = Colors.border
        
        let rowHeaderAppearance = DataGridViewRowHeaderCell.glyuck_appearanceWhenContained(in :DataGridView.self)!
        rowHeaderAppearance.backgroundColor = Colors.headerBackground
        rowHeaderAppearance.borderLeftWidth = 1 / UIScreen.main.scale
        rowHeaderAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        rowHeaderAppearance.borderRightWidth = 1 / UIScreen.main.scale
        rowHeaderAppearance.borderLeftColor = Colors.border
        rowHeaderAppearance.borderBottomColor = Colors.border
        rowHeaderAppearance.borderRightColor = Colors.border
        
        let rowHeaderLabelAppearane = UILabel.glyuck_appearanceWhenContained(in: DataGridView.self, class2: DataGridViewRowHeaderCell.self)!
        rowHeaderLabelAppearane.appearanceTextAlignment = .right
        
        let columnHeaderAppearance = DataGridViewColumnHeaderCell.glyuck_appearanceWhenContained(in: DataGridView.self)!
        columnHeaderAppearance.backgroundColor = Colors.headerBackground
        columnHeaderAppearance.borderTopWidth = 1 / UIScreen.main.scale
        columnHeaderAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        columnHeaderAppearance.borderRightWidth = 1 / UIScreen.main.scale
        columnHeaderAppearance.borderTopColor = Colors.border
        columnHeaderAppearance.borderBottomColor = Colors.border
        columnHeaderAppearance.borderRightColor = Colors.border
        
        let cellAppearance = DataGridViewContentCell.glyuck_appearanceWhenContained(in: DataGridView.self)!
        cellAppearance.borderRightWidth = 1 / UIScreen.main.scale
        cellAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
        cellAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        cellAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        
        columnHeaderAppearance.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let labelAppearance = UILabel.glyuck_appearanceWhenContained(in: DataGridView.self)!
        labelAppearance.appearanceFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelAppearance.appearanceTextAlignment = .center
    }

//    static override func initialize() {
//        super.initialize()
//
//
//    }

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

    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return Constants.numberOfLetters
    }

    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return Constants.numberOfRows
    }

    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return String(Character(UnicodeScalar(Constants.charCodeForA + column)!))
    }

    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return String(row + 1)
    }

    func dataGridView(_ dataGridView: DataGridView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! SpreadSheetCell
        cell.delegate = self
        cell.border.bottomWidth = 1 / UIScreen.main.scale
        cell.border.rightWidth = 1 / UIScreen.main.scale
        cell.border.bottomColor = Colors.border
        cell.border.rightColor = Colors.border
        cell.configureWithData(dataArray[indexPath.dataGridRow][indexPath.dataGridColumn], forIndexPath: indexPath)
        return cell
    }

    // MARK: DataGridViewDelegate

    func dataGridView(_ dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return 60
    }

    func dataGridView(_ dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool {
        return false
    }

    // MARK: SpreadSheetCellDelegate

    func spreadSheetCell(_ cell: SpreadSheetCell, didUpdateData data: String, atIndexPath indexPath: IndexPath) {
        dataArray[indexPath.dataGridRow][indexPath.dataGridColumn] = data
    }
}
