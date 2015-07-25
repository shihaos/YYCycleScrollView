//
//  YYCycleViewCell.h
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCycleScrollView.h"
#import "YYCycleScrollViewCell.h"

@interface YYCycleScrollContnentCell : YYCycleScrollViewCell

@property(nonatomic, copy) NSString *content;

@end

@interface YYCycleViewCell : UIView<YYCycleScrollViewDelegate,YYCycleScrollViewDataSource>


@property(nonatomic, strong) YYCycleScrollView *cyclelView;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) UILabel *titleLabel;

@end
