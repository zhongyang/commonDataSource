**简化UITableViewDelegate & UITableViewDataSource**


UITableView是iOS开发的过程中最常使用的一个控件，几乎在每个APP当中都有他的身影。伴随着UITableView不可缺少的必然是UITableViewDelegate和UITableViewDataSource.

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
    - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;


是否在无数次的拷贝后对上面的几个函数无法再爱，看着UIViewController里面充斥这的这些函数，是否产生了能不能去掉下面这些无聊代码的想法。

这个Project的主要目的就是抽象出这些重复的代码，并且逐步的将MVC以及MVVM这个流行的方法运用进来，并将UIViewController和UITableView变成一个可测试的模块。

 - 第一步. 抽离重复的代码

	参考DEMO1. 提供了一个通用的类，无须重写上述的一对函数，只要配置参数即可。
	

        _dataSource = [[CommonTableViewDataSource alloc] initWithCellClass:[UITableViewCell class]];
        _tableView.dataSource = _dataSource;
        _tableView.delegate = _dataSource;

 添加一些数据来测试

        ConfigureCell cofigureCell =  ConfigureCell() {
            UITableViewCell *tableCell = (UITableViewCell *)cell;          
            tableCell.textLabel.text = (NSString *)object;
        };
            
        for (int i=0; i<2; i++) {
            CommonSection *section = [[CommonSection alloc] init];
            for (int j=0; j<10; j++) {
                CommonCellObject *object = [[CommonCellObject alloc] init];
                object.object = [NSString stringWithFormat:@"%d", j];          
                object.cellClass = NSStringFromClass([UITableViewCell class]);
                object.cellHeight = 60.0f;
                object.configureCell = cofigureCell;
                [section.objects addObject:object];
            }
            [_dataSource.datas addObject:section];
        }
配置section header和sectionFooter

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
        
        section.configureSectionHeader = configureHeader;
        section.configureSectionFooter = configureFooter;
        
  
  具体参考DEMO。
  
  【未完待续】

