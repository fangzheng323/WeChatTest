//
//  AutolayoutViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/23.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "AutolayoutViewController.h"
#import "SDAutoLayout.h"
#import "LayoutCell.h"

@interface AutolayoutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation AutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
     NSLog(@"3");
    
    self.dataArr = [NSArray arrayWithObjects:@"国际化  违反饿个好过去恶化安科技日报个阿克,如果你科技让那个贷款提供你都给你是当然看过山东矿机脱岗我看了十多天那个国际化",@"首日起而请了人们太坑了人玫瑰亲爱而快乐日哦去鞥我铁甲钢拳A按揭款给花儿借款人的规劝而为尽快让给你",@"亲爱而顾而过可如果你客人而公开阿尔卡给你阿尔",@"去啊EHBAALKERNGwalk虽然它能够serger嗯嗯两个is你的快乐的国家队时",@"俄日固化数据库方法和你说开始的那个金士顿 是,等你发个人工阿克,的人给你那你就能呢你卡的开关啊,看哈饿安瑞克归纳卡你卡萨丁干呢老人饿可入库了嗯嗯呐恶俺二哥呢俺二哥好儿童老卡了如今他卡尔和卡尔UR共和日珥儿可日天客人尅热人可怜日偶尔接卢卡尔呢然后in二牛让客户的覆盖了寂寞哥我偶尔开始电话覅赶快留底给机器恩看见hi足球跟你说s.d浪费;感觉呢sk.ndioerng s.dngoiqe", nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.nameText = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataArr[indexPath.row];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [tableView cellHeightForIndexPath:indexPath model:string keyPath:@"nameText" cellClass:[LayoutCell class] contentViewWidth:width];
//    NSLog(@"h==%f",h);
    return 200;
}
@end
