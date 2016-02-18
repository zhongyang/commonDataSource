//
//  CommonTableViewDataSource.h
//  DemoTableView
//
//  Created by zhongyang on 16/2/17.
//  Copyright © 2016年 zhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView* (^ConfigureSectionHeader)(void);
#define ConfigureSectionHeader() ^UIView * ()

typedef UIView* (^ConfigureSectionFooter)(void);
#define ConfigureSectionFooter() ^UIView * ()

typedef void (^ConfigureCell)(id cell, NSObject *object);
#define ConfigureCell() ^void(id cell, NSObject *object)

typedef void (^ConfigureCellAction)(NSObject *object);
#define ConfigureCellAction() ^void(NSObject *object)

@protocol CommonCellObject <NSObject>
@end

@interface CommonCellObject : NSObject

//object need to display in cell.
@property(nonatomic, strong) NSObject *object;

//UITableView class name for cell.
//May have different style cells in one tableview
@property(nonatomic, copy) NSString *cellClass;

//UItableView cell height
@property(nonatomic, assign) CGFloat cellHeight;

//Configure elements display for cell
@property(nonatomic, copy) ConfigureCell configureCell;

//Configure action for cell
@property(nonatomic, copy) ConfigureCellAction configureAction;

@end


@protocol CommonSection <NSObject>
@end

@interface CommonSection : NSObject

//Configure section header view
@property(nonatomic, copy) ConfigureSectionHeader configureSectionHeader;

//configure section footer view
@property(nonatomic, copy) ConfigureSectionFooter configureSectionFooter;

@property(nonatomic, strong) NSMutableArray<CommonCellObject> *objects;

@end

@interface CommonTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray<CommonSection> *datas;


- (instancetype)initWithCellClass:(Class)cellClass;

@end
