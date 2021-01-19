    //
    //  FMMarketViewController.m
    //  Client
    //
    //  Created by mingo on 2021/1/5.
    //

#import "FMMarketViewController.h"
#import "FMMarketTableCell.h"
#import "FMMarketInfoController.h"

@interface FMMarketViewController ()

@property (weak, nonatomic) IBOutlet UIView *backBanner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
proNSMutableArrayType(FMMarketModel, dataArray)

@end

@implementation FMMarketViewController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"market" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *arr = rootDict[@"list"];
        _dataArray = [FMMarketModel mj_objectArrayWithKeyValuesArray:arr];
    }
    return _dataArray;
}

- (void)requestData {
   
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView.mj_header endRefreshing];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMMarketTableCell" bundle:nil] forCellReuseIdentifier:@"FMMarketTableCell"];
    [self setUI];

}

- (void)setUI {
    self.tableView.estimatedRowHeight = 75;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMMarketTableCell" bundle:nil] forCellReuseIdentifier:@"FMMarketTableCell"];
    self.tableView.footRefreshState = MJFooterRefreshStateNoMore;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo++;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];

    }];
    self.tableView.reloadBlock = ^(UIScrollView *listView) {
        [self.tableView.mj_header beginRefreshing];
    };
    
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMMarketInfoController *vc = FMMarketInfoController.new;
    vc.model = self.dataArray[indexPath.row];
    kPushToTheViewController(vc)
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMarketTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMMarketTableCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

@end
