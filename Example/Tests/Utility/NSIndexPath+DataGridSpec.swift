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
            it("can be initialized with column, row") {
                let indexPath = IndexPath(forColumn: 1, row: 2)
                expect(indexPath.dataGridColumn) == 1
                expect(indexPath.dataGridRow) == 2
            }
        }
    }
}
