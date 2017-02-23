//
//  LayoutCell.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/23.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "LayoutCell.h"
#import "SDAutoLayout.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface LayoutCell()
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIView *topView,*leftView,*bottoView,*rightView;

@end
@implementation LayoutCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *superView = [UIView new];
        superView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:superView];
        superView.sd_layout
        .topSpaceToView(self.contentView,20)
        .leftSpaceToView(self.contentView,20)
        .bottomSpaceToView(self.contentView,20)
        .rightSpaceToView(self.contentView,20);
    
        self.contentLab = [[UILabel alloc] init];
        self.contentLab.backgroundColor = [UIColor grayColor];
        self.contentLab.numberOfLines = 0;
        UIView *topView = [UIView new];
        topView.backgroundColor = [UIColor redColor];
        UIView *leftView = [UIView new];
        leftView.backgroundColor = [UIColor yellowColor];
        UIView *bottoView = [UIView new];
        bottoView.backgroundColor = [UIColor blueColor];
        UIView *rightView = [UIView new];
        rightView.backgroundColor = [UIColor greenColor];
        [superView sd_addSubviews:@[topView,leftView,bottoView,rightView,self.contentLab]];
        
        
        topView.sd_layout
        .topSpaceToView(superView,5)
        .leftSpaceToView(superView,5)
        .rightSpaceToView(superView,5)
        .heightIs(10);
        
        leftView.sd_layout
        .topSpaceToView(topView,0)
        .leftEqualToView(topView)
        .bottomSpaceToView(superView,10)
        .widthIs(10);
        
        rightView.sd_layout
        .topEqualToView(leftView)
        .rightSpaceToView(superView,5)
        .bottomEqualToView(leftView)
        .widthIs(10);
        
        bottoView.sd_layout
        .topSpaceToView(leftView,0)
        .leftEqualToView(leftView)
        .rightEqualToView(rightView)
        .heightIs(5);
        
        self.contentLab.sd_layout
        .topSpaceToView(topView,10)
        .leftSpaceToView(leftView,10)
        .rightSpaceToView(rightView,10)
        .autoHeightRatio(0);
        
//        [superView setupAutoHeightWithBottomView:self.contentLab bottomMargin:10];
    }
    return self;
}

- (void)setNameText:(NSString *)nameText
{
    _nameText = nameText;
    self.contentLab.text = nameText;
}

@end
