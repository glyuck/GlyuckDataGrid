//
//  DataGridDelegateWrapper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 31/07/15.
//
//

import UIKit

public class DataGridDelegateWrapper:  NSObject, UICollectionViewDelegate {
    public weak var dataGridDelegate: DataGridViewDelegate!

    init(dataGridDelegate: DataGridViewDelegate) {
        self.dataGridDelegate = dataGridDelegate
        super.init()
    }
}
