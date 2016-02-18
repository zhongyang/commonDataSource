//
//  RootViewController.m
//  DemoTableView
//
//  Created by zhongyang on 16/2/17.
//  Copyright © 2016年 zhongyang. All rights reserved.
//

#import "RootViewController.h"
#import "CommonTableViewDataSource.h"

@interface RootViewController () {
    CommonTableViewDataSource *_dataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self congfiguureTableView];
}

- (void)congfiguureTableView {
    _dataSource = [[CommonTableViewDataSource alloc] initWithCellClass:[UITableViewCell class]];

    ConfigureCell cofigureCell =  ConfigureCell() {
        UITableViewCell *tableCell = (UITableViewCell *)cell;
        tableCell.textLabel.text = (NSString *)object;
    };

    ConfigureCellAction cellAction = ConfigureCellAction() {
        NSLog(@"Action: %@", (NSString *)object);
    };

    for (int i=0; i<2; i++) {
        __typeof__(self) __weak weakself = self;
        ConfigureSectionHeader configureHeader = ConfigureSectionHeader() {
            CGRect frame = CGRectMake(0, 0, weakself.tableView.frame.size.width, 40.0f);
            UIView *headerView = [[UIView alloc] initWithFrame:frame];
            headerView.backgroundColor = [UIColor redColor];
            return headerView;
        };

        ConfigureSectionFooter configureFooter = ConfigureSectionFooter() {
            CGRect frame = CGRectMake(0, 0, weakself.tableView.frame.size.width, 40.0f);
            UIView *headerView = [[UIView alloc] initWithFrame:frame];
            headerView.backgroundColor = [UIColor greenColor];
            return headerView;
        };

        CommonSection *section = [[CommonSection alloc] init];

        section.configureSectionHeader = configureHeader;
        section.configureSectionFooter = configureFooter;

        for (int j=0; j<10; j++) {
            CommonCellObject *object = [[CommonCellObject alloc] init];

            object.object = [NSString stringWithFormat:@"%d", j];
            object.cellClass = NSStringFromClass([UITableViewCell class]);
            object.cellHeight = 60.0f;
            object.configureCell = cofigureCell;
            object.configureAction = cellAction;
            [section.objects addObject:object];
        }

        [_dataSource.datas addObject:section];
    }

    _tableView.dataSource = _dataSource;
    _tableView.delegate = _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
