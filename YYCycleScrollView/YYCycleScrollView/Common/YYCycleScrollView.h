//
//  YYCycleScrollView.h
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "YYCycleScrollViewCell.h"

@class YYCycleScrollView;

@protocol  YYCycleScrollViewDataSource<NSObject>

- (YYCycleScrollView *)cycleView:(YYCycleScrollView *)cycleView
                cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)rowsOfCycle;

@end

@protocol YYCycleScrollViewDelegate<NSObject>

@end

@interface YYCycleScrollView : UIView

@property(nonatomic, assign) NSTimeInterval delayTime;  //轮播时停留的时间，默认0秒不会轮播

@property(nonatomic, assign) NSTimeInterval animationDuration;  //动画时间
@property(nonatomic, assign) NSUInteger shownNumbersMax;        //最大轮转view个数

@property(nonatomic, weak) id<YYCycleScrollViewDataSource> dataSource;
@property(nonatomic, weak) id<YYCycleScrollViewDelegate> delegate;

/**
 *  轮播cell标志重用方法
 *
 *  @param identifier 标志
 *
 *  @return 返回当前已经在队列的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
/**
 *  开始动画方法
 */
- (void)startAnimation;

/**
 *  停止动画方法
 */
- (void)stopAnimation;
@end