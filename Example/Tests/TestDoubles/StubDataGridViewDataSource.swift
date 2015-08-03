//
//  StubDataGridViewDataSource.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Foundation
import GlyuckDataGrid


class StubDataGridViewDataSource: NSObject, DataGridViewDataSource {
    var numberOfColumns = 7

    func numberOfColumnsInDataGrid(dataGridView: DataGridView) -> Int {
        return numberOfColumns
    }
}
