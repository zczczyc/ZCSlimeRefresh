//
//  ZCViewController.m
//  ZCSlimeRefresh
//
//  Created by zczczyc on 12/14/2018.
//  Copyright (c) 2018 zczczyc. All rights reserved.
//

#import "ZCViewController.h"
#import "Masonry.h"
#import "ZCRefreshView.h"

@interface ZCViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ZCRefreshDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) ZCRefreshView *zcRefreshView;


@end

@implementation ZCViewController

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)


static NSString *identifier = @"cell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"水滴下拉";
    [self p_setupUI];
    [self p_setupFrame];
}


- (void)p_setupUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.zcRefreshView];
}

- (void)p_setupFrame {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.view).with.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%@行",self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"123",@"456",@"789",@"012"]];
    }
    return _dataArray;
}

- (NSArray *)array {
    if (!_array) {
        _array = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20];
        
    }
    return _array;
}

#pragma mark ZCRefreshView Delegate 下拉刷新

/**
 初次加载以及下拉刷新
 
 @param array 获取的数据源
 */
- (void)testViewArray:(NSArray *)array {
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[array copy]];
    [self.tableView reloadData];
    //结束刷新
    [self.zcRefreshView endRefresh];
}

- (void)slimeRefreshStartRefresh:(ZCRefreshView *)refreshView {
    
    //刷新当前页面
    [self testViewArray:self.array];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.zcRefreshView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.zcRefreshView scrollViewDidEndDraging];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (ZCRefreshView *)zcRefreshView {
    
    if (!_zcRefreshView) {
        _zcRefreshView = [[ZCRefreshView alloc] init];
        _zcRefreshView.delegate = self;
        _zcRefreshView.upInset = 0;
        _zcRefreshView.slimeMissWhenGoingBack = YES;
        _zcRefreshView.slime.skinColor = [UIColor whiteColor];
        _zcRefreshView.slime.lineWith = 1;
        _zcRefreshView.slime.shadowBlur = 4;
        _zcRefreshView.slime.shadowColor = [UIColor grayColor];
        _zcRefreshView.slime.bodyColor = [UIColor blackColor];
    }
    return _zcRefreshView;
}

@end
