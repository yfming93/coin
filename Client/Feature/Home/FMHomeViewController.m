//
//  FMHomeViewController.m
//  Client
//
//  Created by mingo on 2021/1/5.
//

#import "FMHomeViewController.h"
#import "SDCycleScrollView.h"
#import "FMHomeTableViewCell.h"
#import "FMHomeModel.h"

@interface FMHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backBanner;
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
proNSMutableArrayType(FMHomeModel, dataArray)

@end

@implementation FMHomeViewController

- (SDCycleScrollView *)banner{
    if (!_banner) {
        NSArray *arr = @[
            @"https://btnfile.yunynet.cn/mng/2021/01/07/7d144fc4-91fe-45c2-8bc5-43611078f239.png",
            @"https://btnfile.yunynet.cn/mng/2021/01/07/4caf1237-1ca1-44d0-bd47-b4831c2e4466.jpg",
            @"https://btnfile.yunynet.cn/mng/2021/01/04/45512c49-5d90-40f2-b445-c046e79d751e.png",
            @"https://btnfile.yunynet.cn/mng/2020/12/29/a1ec6bf5-3354-46ac-b21e-100596b41241.png",
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
    [self.tableView registerNib:[UINib nibWithNibName:@"FMHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMHomeTableViewCell"];
}

- (void)setUI {
    self.tableView.estimatedRowHeight = 200;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMHomeTableViewCell"];
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
    NSString *url = [NSString stringWithFormat:@"http://api.iw010.com/rest/captureInformation/listV3?childId=&pageSize=10&type=1&pageNum=%ld",self.pageNo];
    [FMNetworkingManager fm_getUrl:url params:nil showIndicator:NO showStatusTip:NO successBlock:^(id responseObject, NSInteger code, NSString *msgStr) {
        NSLog(@"---------xx");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.pageNo == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:[FMHomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"records"]]];
    
        for (FMHomeModel *mo in self.dataArray.copy) {
            if (mo.auth.length == 0 || mo.createTime.length == 0) {
                [self.dataArray removeObject:mo];
            }
        }
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
        vc.ba_web_progressTintColor = UIColor.clearColor;
        vc.ba_web_progressTrackTintColor = UIColor.clearColor;
        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=0.7, maximum-scale=0.7, minimum-scale=0.7, user-scalable=no'><style>img{max-width:100%}</style></header>";
        dat = [headerString stringByAppendingString:dat];
        [vc ba_web_loadHTMLString:dat];
        [vc.webView reload];
        FMLog(@"str--------:%@",dat);
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failureBlock:^(NSError *error, id objc) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self gotoDetail:self.dataArray[indexPath.row].id];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMHomeTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenW);
    }
    return cell;
}

@end
