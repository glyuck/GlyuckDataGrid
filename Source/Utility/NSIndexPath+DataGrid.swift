//
//  NSIndexPath+DataGrid.swift
//
//  Created by Vladimir Lyukov on 31/07/15.
//

import Foundation


public extension NSIndexPath {
    convenience init(forColumn column: Int, inRow row: Int, inSection section: Int) {
        let indexes = [column, row, section]
        self.init(indexes: indexes, length: 3)
    }

    var dataGridColumn: Int {
        return indexAtPosition(0)
    }

    var dataGridRow: Int {
        return indexAtPosition(1)
    }

    var dataGridSection: Int {
        return indexAtPosition(2)
    }
}
