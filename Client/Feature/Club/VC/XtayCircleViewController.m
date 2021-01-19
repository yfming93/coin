//
//  XtayCircleViewController.m
//  FriendCircleDemo
//
//  Created by admin on 2021/1/15.
//

// 看不见的frame
#define UN_VISIABLE_FRAME   CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 60)

#import "XtayCircleViewController.h"
#import "XtayCircleTableViewCell.h"
#import "XtayCircleModel.h"
#import "XtayCircleCommentModel.h"
#import "XtayCaculateHeightTool.h"
#import "XtayCommentInputView.h"
//#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "MSSBrowseLocalViewController.h"
#import "IQKeyboardManager.h"

@interface XtayCircleViewController () <UITableViewDelegate, UITableViewDataSource, XtayCircleCellDelegate, XtayInputContentFinishedProtocol>

/// table
@property (nonatomic, strong) UITableView *listTableView;
/// commentInputView
@property (nonatomic, strong) XtayCommentInputView *commentInputView;
/// marr
@property (nonatomic, strong) NSMutableArray *mDataMArray;
/// 上一个选择的展开更多cell的索引值
@property (nonatomic, assign) NSInteger lastSelctedIndex;
/// 选择的回复内容的索引值
@property (nonatomic, assign) NSInteger commentIndex;
/// 当前评论的模型
@property (nonatomic, strong) XtayCircleCommentModel *currentCommentModel;
/// 是否需要弹出输入框
@property (nonatomic, assign) BOOL isNeedInput;

@end

@implementation XtayCircleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.lastSelctedIndex = -1;
    [self.view addSubview:self.listTableView];
    [self.view addSubview:self.commentInputView];
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShown:) name:UIKeyboardWillShowNotification object:nil];
}

- (XtayCommentInputView *)commentInputView {
    if (!_commentInputView) {
        _commentInputView = [[XtayCommentInputView alloc] initWithFrame:UN_VISIABLE_FRAME];
        _commentInputView.delegate = self;
    }
    return _commentInputView;
}

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-XTAY_STATUS_BAR_H-XTAY_NAV_BAR_H-kTabbarH - kNavBarH)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = [UIView new];
    }
    return _listTableView;
}

- (NSMutableArray *)mDataMArray {
    if (!_mDataMArray) {
        _mDataMArray = [NSMutableArray arrayWithCapacity:0];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@""];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dataArr) {
            XtayCircleModel *obj = [XtayCircleModel obtainModelWithCircleDict:dic];
            obj.isOpen = NO;// 默认为闭合状态
            obj.isMoreViewShow = NO;
            NSMutableArray *commentArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *commentDic in obj.comment) {
                XtayCircleCommentModel *commentObj = [XtayCircleCommentModel obtainModelWithCircleDict:commentDic];
                [commentArr addObject:commentObj];
            }
            obj.comment = commentArr;
            [_mDataMArray addObject:obj];
        }
    }
    return _mDataMArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mDataMArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XtayCircleModel *model = self.mDataMArray[indexPath.row];
    CGFloat contentH = [XtayCaculateHeightTool caculateContentHeightWithText:model.content realWidth:SCREEN_WIDTH-30-AVATAR_W_H textFont:XTAY_FONT_WEIGHT(15, 0) isOpen:model.isOpen];
    if (contentH != 0) {
        contentH += 5;
    }
    CGFloat imagesH = [XtayCaculateHeightTool caculateImagesHeightWithImgsCount:model.images.count realWidth:SCREEN_WIDTH-30-AVATAR_W_H];
    if (imagesH != 0) {
        imagesH += 5;
    }
    CGFloat thumbH = [XtayCaculateHeightTool caculateThumbHeightWithThumbList:model.thumb realWidth:SCREEN_WIDTH-30-AVATAR_W_H textFont:XTAY_FONT_WEIGHT(15, 0)];
    if (thumbH != 0) {
        thumbH += 5;
    }
    CGFloat commentH = [XtayCaculateHeightTool caculateCommentHeightWithCommentArray:model.comment realWidth:SCREEN_WIDTH-30-AVATAR_W_H textFont:XTAY_FONT_WEIGHT(15, 0)];
    if (commentH != 0) {
        commentH += 5;
    }
    return
    10
    +30
    +10
    +contentH
    +imagesH
    +25
    +thumbH
    +commentH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XtayCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XtayCircleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.mDataMArray[indexPath.row];
    cell.cellDelegate = self;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_lastSelctedIndex >= 0) {
        XtayCircleModel *obj = [self.mDataMArray objectAtIndex:_lastSelctedIndex];
        obj.isMoreViewShow = NO;
        [self.mDataMArray replaceObjectAtIndex:_lastSelctedIndex withObject:obj];
        [self.listTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        self.lastSelctedIndex = -1;
    }
    if (!self.isNeedInput) {
        [self beginHideCommentInputView];
    }
}

- (void)beginHideCommentInputView {
    [self.commentInputView beginHiddenInputView];
    XTAY_WEAK_SELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.commentInputView.frame = UN_VISIABLE_FRAME;
    }];
}

- (void)showOrHideMoreBtnViewWithIndexPath:(NSIndexPath *)indexPath isMoreViewShow:(BOOL)isMoreViewShow {
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    obj.isMoreViewShow = isMoreViewShow;
    [self.mDataMArray replaceObjectAtIndex:indexPath.row withObject:obj];
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - XtayCircleCellDelegate 代理方法
- (void)moreButtonCallBackCell:(XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex < 0) {
        [self showOrHideMoreBtnViewWithIndexPath:indexPath isMoreViewShow:YES];
        self.lastSelctedIndex = indexPath.row;
    } else {
        if (_lastSelctedIndex == indexPath.row) {
            XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
            obj.isMoreViewShow = !obj.isMoreViewShow;
            [self.mDataMArray replaceObjectAtIndex:indexPath.row withObject:obj];
            [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (!obj.isMoreViewShow) {
                self.lastSelctedIndex = -1;
            }
        } else {
            [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
            [self showOrHideMoreBtnViewWithIndexPath:indexPath isMoreViewShow:YES];
            self.lastSelctedIndex = indexPath.row;
        }
    }
}

- (void)openOrCloseBtnResponseWithCurrentStatus:(BOOL)isOpen cell:(nonnull XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    obj.isOpen = isOpen;
    [self.mDataMArray replaceObjectAtIndex:indexPath.row withObject:obj];
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)lookCellImagesWithIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    NSMutableArray *imgsArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *name in obj.images) {
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImage = [UIImage imageNamed:name];
        [imgsArray addObject:browseItem];
    }
//    MWPhotoBrowser *pb = [[MWPhotoBrowser alloc] initWithPhotos:imgsArray];
//    [pb setCurrentPhotoIndex:index];
//    [self.navigationController pushViewController:pb animated:YES];
    
    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc] initWithBrowseItemArray:imgsArray currentIndex:index];
        //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];
}

- (void)clickThumbViewListWithIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    NSArray *thumbList = obj.thumb;
    if (![thumbList[index] isEqualToString:MY_SELF_NAME]) {
        self.isNeedInput = YES;
        self.commentIndex = indexPath.row;
        self.currentCommentModel = [[XtayCircleCommentModel alloc] init];
        _currentCommentModel.from = MY_SELF_NAME;
        _currentCommentModel.to = thumbList[index];
        self.commentInputView.placeHolder = [NSString stringWithFormat:@"回复%@", thumbList[index]];
        [self.commentInputView beginShowInputView];
    }
}

- (void)clickCommentListViewFromManIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    XtayCircleCommentModel *commentObj = obj.comment[index];
    if (![commentObj.from isEqualToString:MY_SELF_NAME]) {
        self.isNeedInput = YES;
        self.commentIndex = indexPath.row;
        self.currentCommentModel = [[XtayCircleCommentModel alloc] init];
        _currentCommentModel.from = MY_SELF_NAME;
        _currentCommentModel.to = commentObj.from;
        self.commentInputView.placeHolder = [NSString stringWithFormat:@"回复%@", commentObj.from];
        [self.commentInputView beginShowInputView];
    }
}

- (void)clickCommentListViewToManIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell {
    [self beginHideCommentInputView];
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *obj = [self.mDataMArray objectAtIndex:indexPath.row];
    XtayCircleCommentModel *commentObj = obj.comment[index];
    if (![commentObj.to isEqualToString:MY_SELF_NAME]) {
        self.isNeedInput = YES;
        self.commentIndex = indexPath.row;
        self.currentCommentModel = [[XtayCircleCommentModel alloc] init];
        _currentCommentModel.from = MY_SELF_NAME;
        _currentCommentModel.to = commentObj.to;
        self.commentInputView.placeHolder = [NSString stringWithFormat:@"回复%@", commentObj.to];
        [self.commentInputView beginShowInputView];
    }
}

// MARK: - 点赞事件
- (void)moreBtnSubViewDianZanResCell:(XtayCircleTableViewCell *)cell {
    NSIndexPath *indexPath = [self.listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *currentModel = self.mDataMArray[indexPath.row];
    NSMutableArray *thumbMArr = [NSMutableArray arrayWithArray:currentModel.thumb];
    [thumbMArr addObject:MY_SELF_NAME];
    currentModel.thumb = thumbMArr;
    currentModel.hasLiked = YES;
    [self.mDataMArray replaceObjectAtIndex:indexPath.row withObject:currentModel];
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// MARK: - 取消点赞事件
- (void)moreBtnSubViewCancelDianZanResCell:(XtayCircleTableViewCell *)cell {
    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
    if (_lastSelctedIndex >= 0) {
        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
        self.lastSelctedIndex = -1;
    }
    XtayCircleModel *currentModel = self.mDataMArray[indexPath.row];
    NSMutableArray *thumbMArr = [NSMutableArray arrayWithArray:currentModel.thumb];
    [thumbMArr removeObject:MY_SELF_NAME];
    currentModel.thumb = thumbMArr;
    currentModel.hasLiked = NO;
    [self.mDataMArray replaceObjectAtIndex:indexPath.row withObject:currentModel];
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// MARK: - 回复事件
- (void)moreBtnSubViewHuiFuResCell:(XtayCircleTableViewCell *)cell {
//    NSIndexPath *indexPath = [_listTableView indexPathForCell:cell];
//    if (_lastSelctedIndex >= 0) {
//        [self showOrHideMoreBtnViewWithIndexPath:[NSIndexPath indexPathForRow:_lastSelctedIndex inSection:0] isMoreViewShow:NO];
//        self.lastSelctedIndex = -1;
//    }
//    XtayCircleModel *currentModel = self.mDataMArray[_commentIndex];
//    self.isNeedInput = YES;
//    self.commentIndex = indexPath.row;
//    self.currentCommentModel = [[XtayCircleCommentModel alloc] init];
//    _currentCommentModel.from = MY_SELF_NAME;
//    _currentCommentModel.to = @"";
//    self.commentInputView.placeHolder = [NSString stringWithFormat:@"回复%@", currentModel.name];
//    [self.commentInputView beginShowInputView];
    [self fm_showAlertSheet];

}

- (void)fm_showAlertSheet {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"您要举报恶意内容吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暴力内容" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [FMCoreTools fm_showHudText:@"举报成功！"];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"辱骂内容" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [FMCoreTools fm_showHudText:@"举报成功！"];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"低俗内容" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [FMCoreTools fm_showHudText:@"举报成功！"];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"色情内容" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [FMCoreTools fm_showHudText:@"举报成功！"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [actionSheet addAction:action1];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [actionSheet addAction:action2];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
     
//MARK: - 完成编辑点击事件
- (void)finishedInputWithSendContent:(NSString *)content {
    [self beginHideCommentInputView];
    if ([content isEqualToString:@""]) {
        return;
    }
    _currentCommentModel.cont = content;
    XtayCircleModel *currentModel = self.mDataMArray[_commentIndex];
    NSMutableArray *commentMArr = [NSMutableArray arrayWithArray:currentModel.comment];
    [commentMArr addObject:_currentCommentModel];
    currentModel.comment = commentMArr;
    [self.mDataMArray replaceObjectAtIndex:_commentIndex withObject:currentModel];
    [self.listTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_commentIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

// MARK: - 键盘通知系统事件
- (void)keyBoardWillShown:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    XTAY_WEAK_SELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.commentInputView.frame = CGRectMake(0, SCREEN_HEIGHT-XTAY_STATUS_BAR_H-XTAY_NAV_BAR_H-height-60, SCREEN_WIDTH, 60);
    } completion:^(BOOL finished) {
        weakSelf.isNeedInput = NO;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
