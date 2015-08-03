//
//  StubDataGridViewDelegate.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Foundation
import GlyuckDataGrid


class StubDataGridViewDelegate: NSObject, DataGridViewDelegate {
    var sectionHeaderHeight: CGFloat = 60
    var rowHeight: CGFloat = 70
    var columnWidth: CGFloat = 100

    func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat {
        return sectionHeaderHeight
    }

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnWidth
    }

    func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat {
        return rowHeight
    }
}
