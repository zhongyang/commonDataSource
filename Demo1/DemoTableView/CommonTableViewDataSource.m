//
//  CommonTableViewDataSource.m
//  DemoTableView
//
//  Created by zhongyang on 16/2/17.
//  Copyright © 2016年 zhongyang. All rights reserved.
//

#import "CommonTableViewDataSource.h"

@implementation CommonCellObject

@end

@implementation CommonSection

- (instancetype)init {
    if ((self = [super init])) {
        _objects = (NSMutableArray<CommonCellObject> *)[[NSMutableArray alloc] init];
    }
    return self;
}

@end

@interface CommonTableViewDataSource () {
    Class _cellClass;
}

@end

@implementation CommonTableViewDataSource

- (instancetype)initWithCellClass:(Class)cellClass {
    if ((self = [super init])) {
        _cellClass = cellClass;
        _datas = (NSMutableArray<CommonSection> *)[[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_datas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CommonSection *sectionObj = [_datas objectAtIndex:section];
    return [sectionObj.objects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifierString = NSStringFromClass(_cellClass);
    id cell = [tableView dequeueReusableCellWithIdentifier:indentifierString];
    if (cell == nil) {
        cell = [[_cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifierString];
    }

    CommonSection *sectionObj = [_datas objectAtIndex:indexPath.section];
    CommonCellObject *obj = [sectionObj.objects objectAtIndex:indexPath.row];

    if (obj && obj.configureCell) {
        obj.configureCell(cell, obj.object);
    }

    return cell;
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonSection *sectionObj = [_datas objectAtIndex:indexPath.section];
    CommonCellObject *obj = [sectionObj.objects objectAtIndex:indexPath.row];
    return obj.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CommonSection *sectionObj = [_datas objectAtIndex:section];
    if (sectionObj.configureSectionHeader) {
        return sectionObj.configureSectionHeader().frame.size.height;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CommonSection *sectionObj = [_datas objectAtIndex:section];
    if (sectionObj.configureSectionFooter) {
        return sectionObj.configureSectionFooter().frame.size.height;
    }
    return 0.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonSection *sectionObj = [_datas objectAtIndex:section];
    if (sectionObj.configureSectionHeader) {
        return sectionObj.configureSectionHeader();
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CommonSection *sectionObj = [_datas objectAtIndex:section];
    if (sectionObj.configureSectionFooter) {
        return sectionObj.configureSectionFooter();
    }
    return nil;
}

@end
