//
//  DataGridDelegateWrapper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 31/07/15.
//
//

import UIKit

public class DataGridDelegateWrapper:  NSObject, UICollectionViewDelegate {
    private(set) public weak var dataGridView: DataGridView!
    private(set) public weak var dataGridDelegate: DataGridViewDelegate!

    init(dataGridView: DataGridView, dataGridDelegate: DataGridViewDelegate) {
        self.dataGridView = dataGridView
        self.dataGridDelegate = dataGridDelegate
        super.init()
    }
}
