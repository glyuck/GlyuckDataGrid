//
//  NSIndexPath+DataGrid.swift
//
//  Created by Vladimir Lyukov on 31/07/15.
//

import Foundation


public extension NSIndexPath {
    convenience init(forColumn column: Int, row: Int) {
        self.init(forItem: column, inSection: row)
    }

    var dataGridColumn: Int {
        return indexAtPosition(1)
    }

    var dataGridRow: Int {
        return indexAtPosition(0)
    }
}
