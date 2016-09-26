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
    func spreadSheetCell(_ cell: SpreadSheetCell, didUpdateData data: String, atIndexPath indexPath: IndexPath)
}


class SpreadSheetCell: DataGridViewBaseCell {
    @IBOutlet weak var textField: UITextField!
    var indexPath: IndexPath!

    var delegate: SpreadSheetCellDelegate?

    func configureWithData(_ data: String, forIndexPath indexPath: IndexPath) {
        self.indexPath = indexPath
        textField.text = data
    }
}


extension SpreadSheetCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let data = textField.text ?? ""
        delegate?.spreadSheetCell(self, didUpdateData: data, atIndexPath: indexPath)
    }
}
