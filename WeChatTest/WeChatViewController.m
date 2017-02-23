//
//  WeChatViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "WeChatViewController.h"
#import "BaseChatViewController.h"

@interface WeChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *control;
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.control = [[UIRefreshControl alloc] init];
    
    [self.control addTarget:self action:@selector(beg:) forControlEvents:UIControlEventValueChanged];
    self.control.attributedTitle = [[NSAttributedString alloc] initWithString:@"我要上天啦"];
    self.control.tintColor = [UIColor redColor];
    self.tableView.refreshControl = self.control;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.control isRefreshing]) {
        [self.control beginRefreshing];
    }else{
        [self.control endRefreshing];
    }
}
- (void)beg:(UIRefreshControl*)con
{
    [self performSelector:@selector(end) withObject:nil afterDelay:3];
}
- (void)end
{
    [self.control endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseChatViewController *chat = [[BaseChatViewController alloc] init];
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

@end
