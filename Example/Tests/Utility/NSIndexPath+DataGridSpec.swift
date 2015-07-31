//
//  NSIndexPath+DataGridSpec.swift
//
//  Created by Vladimir Lyukov on 31/07/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class NSIndexPathDataGridSpec: QuickSpec {
    override func spec() {
        describe("NSIndexPath") {
            it("can be initialized with column, row, section") {
                let indexPath = NSIndexPath(forColumn: 1, inRow: 2, inSection: 3)
                expect(indexPath.dataGridColumn) == 1
                expect(indexPath.dataGridRow) == 2
                expect(indexPath.dataGridSection) == 3
            }
        }
    }
}
