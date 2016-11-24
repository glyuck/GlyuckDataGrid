//
//  ObjectiveCDataGridViewController.m
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 24/11/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#import "ObjectiveCDataGridViewController.h"
#import "GlyuckDataGrid-Swift.h"
#import "GlyuckDataGrid_Example-Swift.h"


@interface ObjectiveCDataGridViewController () <DataGridViewDataSource, DataGridViewDelegate>

@property (copy, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet DataGridView *dataGridView;

@end


@implementation ObjectiveCDataGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = F1DataSource.stats;

    self.dataGridView.dataSource = self;
    self.dataGridView.delegate = self;
}

#pragma mark - DataGridViewDataSource

- (NSInteger)numberOfColumnsInDataGridView:(DataGridView *)dataGridView {
    return F1DataSource.columns.count;
}

- (NSInteger)numberOfRowsInDataGridView:(DataGridView *)dataGridView {
    return self.dataSource.count;
}

- (NSString *)dataGridView:(DataGridView *)dataGridView titleForHeaderForColumn:(NSInteger)column {
    return F1DataSource.columnsTitles[column];
}

- (NSString *)dataGridView:(DataGridView *)dataGridView textForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fieldName = F1DataSource.columns[indexPath.dataGridColumn];
    return self.dataSource[indexPath.dataGridRow][fieldName];
}

- (DataGridViewColumnHeaderCell *)dataGridView:(DataGridView *)dataGridView viewForHeaderForColumn:(NSInteger)column {
    DataGridViewColumnHeaderCell *cell = [dataGridView dequeueReusableHeaderViewWithReuseIdentifier:@"DataGridViewColumnHeaderCell" forColumn:column];
    cell.title = [self dataGridView:dataGridView titleForHeaderForColumn:column];
    if (column == 1) {
        cell.borderRightWidth = 1 / UIScreen.mainScreen.scale;
        cell.borderRightColor = [UIColor colorWithWhite:0.72 alpha:1];
    } else {
        cell.borderRightWidth = 0;
    }
    return cell;
}

- (UICollectionViewCell *)dataGridView:(DataGridView *)dataGridView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DataGridViewContentCell *cell = (id)[dataGridView dequeueReusableCellWithReuseIdentifier:@"DataGridViewContentCell" forIndexPath:indexPath];
    cell.textLabel.text = [self dataGridView:dataGridView textForCellAtIndexPath:indexPath];
    switch (indexPath.dataGridColumn) {
        case 0:
        case 2:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 11:
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            break;
        default:
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            break;
    }
    if (indexPath.dataGridColumn == 1) {
        cell.borderRightWidth = 1 / UIScreen.mainScreen.scale;
        cell.borderRightColor = [UIColor colorWithWhite:0.72 alpha:1];
    } else {
        cell.borderRightWidth = 0;
    }
    return cell;
}

#pragma mark - DataGridViewDelegate

- (CGFloat)dataGridView:(DataGridView *)dataGridView widthForColumn:(NSInteger)column {
    return [F1DataSource.columnsWidths[column] floatValue];
}

- (BOOL)dataGridView:(DataGridView *)dataGridView shouldFloatColumn:(NSInteger)column {
    return column == 1;
}

- (BOOL)dataGridView:(DataGridView *)dataGridView shouldSortByColumn:(NSInteger)column {
    return YES;
}

- (void)dataGridView:(DataGridView *)dataGridView didSortByColumn:(NSInteger)column ascending:(BOOL)ascending {
    NSString *columnName = F1DataSource.columns[column];
    self.dataSource = [F1DataSource.stats sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1[columnName] compare:obj2[columnName]];
    }];
    [dataGridView reloadData];
}

@end
