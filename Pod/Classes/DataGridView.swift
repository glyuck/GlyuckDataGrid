//
//  DataGridView.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


@objc public protocol DataGridViewDataSource {

}


@objc public protocol DataGridViewDelegate {

}


public class DataGridView: UICollectionView {

    convenience init(frame: CGRect) {
        let layout = DataGridViewLayout()
        self.init(frame: frame, collectionViewLayout: layout)
    }

    public override var dataSource: UICollectionViewDataSource? {
        set {
            if let newValue = newValue {
                assert(newValue.isKindOfClass(DataGridDataSourceWrapper.self), "You should use dataGridDataSource instead of dataSource")
            }
            super.dataSource = newValue
        }
        get {
            return super.dataSource
        }
    }

    public override var delegate: UICollectionViewDelegate? {
        set {
            if let newValue = newValue {
                assert(newValue.isKindOfClass(DataGridDelegateWrapper.self), "You should use dataGridDelegate instead of delegate")
            }
            super.delegate = newValue
        }
        get {
            return super.delegate
        }
    }

    internal var dataGridDataSourceWrapper: DataGridDataSourceWrapper?
    public weak var dataGridDataSource: DataGridViewDataSource? {
        set {
            if let newValue = newValue {
                dataGridDataSourceWrapper = DataGridDataSourceWrapper(dataGridDataSource: newValue)
            } else {
                dataGridDataSourceWrapper = nil
            }
            dataSource = dataGridDataSourceWrapper
        }
        get {
            return dataGridDataSourceWrapper?.dataGridDataSource
        }
    }

    internal var dataGridDelegateWrapper: DataGridDelegateWrapper?
    public weak var dataGridDelegate: DataGridViewDelegate? {
        set {
            if let newValue = newValue {
                dataGridDelegateWrapper = DataGridDelegateWrapper(dataGridDelegate: newValue)
            } else {
                dataGridDelegateWrapper = nil
            }
            delegate = dataGridDelegateWrapper
        }
        get {
            return dataGridDelegateWrapper?.dataGridDelegate
        }
    }
}
