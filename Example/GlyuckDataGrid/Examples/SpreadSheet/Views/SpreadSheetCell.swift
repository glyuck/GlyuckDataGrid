//
//  SpreadSheetCell.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import GlyuckDataGrid


protocol SpreadSheetCellDelegate {
    func spreadSheetCell(cell: SpreadSheetCell, didUpdateData data: String, atIndexPath indexPath: NSIndexPath)
}


class SpreadSheetCell: DataGridViewBaseCell {
    @IBOutlet weak var textField: UITextField!
    var indexPath: NSIndexPath!

    var delegate: SpreadSheetCellDelegate?

    func configureWithData(data: String, forIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        textField.text = data
    }
}


extension SpreadSheetCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        let data = textField.text ?? ""
        delegate?.spreadSheetCell(self, didUpdateData: data, atIndexPath: indexPath)
    }
}
