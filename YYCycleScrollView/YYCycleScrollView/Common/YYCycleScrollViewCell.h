//
//  YYCycleScrollViewCell.h
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCycleScrollViewCell : UIView

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

/**
 *  初始化重用的cell
 *
 *  @param identifier 标志
 *
 *  @return 初始化的cell
 */
- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
