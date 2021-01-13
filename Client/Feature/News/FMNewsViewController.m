    //
    //  FMNewsViewController.m
    //  Client
    //
    //  Created by mingo on 2021/1/5.
    //

#import "FMNewsViewController.h"
#import "SDCycleScrollView.h"
#import "FMNewsTableViewCell.h"
#import "FMNewsModel.h"

@interface FMNewsViewController ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backBanner;
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
proNSMutableArrayType(FMNewsModel, dataArray)

@end

@implementation FMNewsViewController

- (SDCycleScrollView *)banner{
    if (!_banner) {
        NSArray *arr = @[
            @"https://btnfile.grayoss.com/app/2021/01/09/3930345a5f23444ae372acca83822835.png",
            @"https://btnfile.grayoss.com/app/2021/01/10/1ff02b49beb30a7ab38d885cb5ae1608.png",
            @"https://btnfile.yunynet.cn/mng/2021/01/07/71d27f11-0467-4ede-916e-7c8b9b6df06a.jpg",
            @"https://btnfile.yunynet.cn/mng/2020/12/28/cb293e0c-eb5f-4745-9334-f3d21828320c.png",
        ];
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:self.backBanner.bounds shouldInfiniteLoop:YES imageNamesGroup:arr];
        _banner.placeholderImage = [UIImage imageNamed:@"pic_zwt"];
        _banner.autoScrollTimeInterval = 3.0;
        _banner.showPageControl = YES;
        _banner.currentPageDotColor = UIColor.redColor;
        _banner.pageDotColor = UIColor.whiteColor;
        _banner.delegate = self;
    }
    return _banner;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.backBanner addSubview:self.banner];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setUI];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMNewsTableViewCell"];
}

- (void)setUI {
    self.tableView.estimatedRowHeight = 200;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMNewsTableViewCell"];
    self.tableView.footRefreshState = MJFooterRefreshStateNoMore;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self getData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo++;
        [self getData];
    }];
    self.tableView.reloadBlock = ^(UIScrollView *listView) {
        [self.tableView.mj_header beginRefreshing];
    };
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)getData {
    weakSelf(self)
    NSString *url = [NSString stringWithFormat:@"http://api.iw010.com/rest/captureInformation/listV3?childId=&pageSize=20&type=22&pageNum=%ld",self.pageNo];
    [FMNetworkingManager fm_getUrl:url params:nil showIndicator:NO showStatusTip:NO successBlock:^(id responseObject, NSInteger code, NSString *msgStr) {
        NSLog(@"---------xx");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.pageNo == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:[FMNewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"records"]]];
        self.dataArray.reverse;
        [self.tableView reloadData];
        
        
    } failureBlock:^(NSError *error, id objc) {
        
    }];
    
}

- (void)gotoDetail:(NSString *)idd {
    weakSelf(self)
    NSString *url = [NSString stringWithFormat:@"http://api.iw010.com/rest/captureInformation/info?id=%@",idd];
    [FMNetworkingManager fm_getUrl:url params:nil showIndicator:YES showStatusTip:NO successBlock:^(id responseObject, NSInteger code, NSString *msgStr) {
        
        NSString *dat = responseObject[@"content"];
        BAWebViewController *vc = BAWebViewController.new;
        vc.title = @"详情";
        vc.view.height -= kNavBarH;
        vc.view.height -= kTabbarH;
        vc.ba_web_progressTintColor = UIColor.clearColor;
        vc.ba_web_progressTrackTintColor = UIColor.clearColor;
        [vc ba_web_loadHTMLString:dat];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failureBlock:^(NSError *error, id objc) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self gotoDetail:self.dataArray[indexPath.row].id];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMNewsTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenW);
    }
    return cell;
}

@end
