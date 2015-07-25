//
//  YYCycleScrollView.m
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//

#import "YYCycleScrollView.h"

#define MaxShownNum 3

@interface YYCycleScrollView ()<UIScrollViewDelegate>

@property(nonatomic, assign) int indexShow;
@property(nonatomic, strong) UIView *prevDisplayView;
@property(nonatomic, strong) UIView *currentDisplayView;
@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, retain) NSMutableDictionary *dequeueReusableDic;
@property(nonatomic, retain) NSMutableArray *cycleCellArray;
@property(nonatomic, assign) NSInteger rows;

@end

@implementation YYCycleScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds      = YES;
        self.shownNumbersMax    = MaxShownNum;
        self.rows               = -1;
        self.currentDisplayView = [[UIView alloc] init];
        self.prevDisplayView    = [[UIView alloc] init];
    }
    return self;
}

- (void)startAnimation {
    [self startTimerPlay];
}

- (void)stopAnimation {
    if ([self.timer isValid] == YES) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - Private Method

- (UIView *)cell {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(rowsOfCycle)]) {
        _rows = [self.dataSource rowsOfCycle];
    }
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(cycleView:cellForRowAtIndexPath:)] &&
        _rows > 0) {
        UIView *view = [self.dataSource
                        cycleView:self
                        cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(_indexShow++) % _rows inSection:0]];
        view.frame =
        CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        view.alpha = 0;
        
        if (!view.superview)
            [self addSubview:view];
        
        return view;
    }
    
    return nil;
}

/**
 *  开始时间设定
 *
 *  @param time 延迟时间
 */
- (void)startTimerPlay {
    self.prevDisplayView = [self cell];
    [self cycleAnimation];
    self.timer = [NSTimer timerWithTimeInterval:self.animationDuration + self.delayTime target:self selector:@selector(autoTimerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  循环播放动画
 */
- (void)cycleAnimation {
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         self.prevDisplayView.center =
                         CGPointMake(self.prevDisplayView.center.x, self.frame.size.height / 2);
                         self.prevDisplayView.alpha = 1;
                         
                         self.currentDisplayView.center =
                         CGPointMake(self.currentDisplayView.center.x, -self.frame.size.height / 2);
                         self.currentDisplayView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.currentDisplayView removeFromSuperview];
                         //把self.currentDisplayView放进缓存队列,确保类型正确
                         if ([self.currentDisplayView isKindOfClass:[YYCycleScrollViewCell class]])
                             [self addViewToDequque:(YYCycleScrollViewCell *)self.currentDisplayView];
                         
                         self.currentDisplayView = self.prevDisplayView;
                         self.prevDisplayView    = [self cell];
                     }];
}

- (void)autoTimerFired {
    // 如果当前view不在屏幕上可见
    if (![self isDisplayedInScreen]) {
        return;
    }
    [self cycleAnimation];
}

// 判断当前View是否显示在屏幕上
- (BOOL)isDisplayedInScreen {
    // 不在window中时
    if (self.window == nil) {
        return NO;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return NO;
    }
    
    // width或height为0，或者为null时
    if (CGRectIsEmpty(self.bounds)) {
        return NO;
    }
    
    CGRect windowBounds     = self.window.bounds,
    rectToWindow     = [self convertRect:self.frame toView:self.window],
    intersectionRect = CGRectIntersection(rectToWindow, windowBounds);
    // 如果在屏幕外
    if (CGRectIsEmpty(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 队列重用
- (NSMutableDictionary *)dequeueReusableDic {
    if (!_dequeueReusableDic) {
        _dequeueReusableDic = [[NSMutableDictionary alloc] init];
    }
    return _dequeueReusableDic;
}

- (void)setShownNumbersMax:(NSUInteger)shownNumbersMax {
    if (_shownNumbersMax != shownNumbersMax) {
        _shownNumbersMax = shownNumbersMax;
    }
}

- (NSMutableArray *)cycleCellArray {
    if (!_cycleCellArray) {
        _cycleCellArray = [[NSMutableArray alloc] initWithCapacity:self.shownNumbersMax + 1];
    }
    return _cycleCellArray;
}

/**
 *  从Cell缓存队列中取cell
 *
 *  @param identifier 某类型缓存的唯一标示
 *
 *  @return cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    NSMutableArray *dequeue = [self.dequeueReusableDic objectForKey:identifier];
    id returnId = nil;
    if (dequeue && [dequeue count] > 0) {
        returnId = [dequeue firstObject];
        [dequeue removeObject:returnId];
    }
    return returnId;
}

/**
 *  把一个view添加进缓存队列
 *
 *  @param panView 需要进队列的view
 */
- (void)addViewToDequque:(YYCycleScrollViewCell *)cell {
    NSMutableArray *dequeue = [self.dequeueReusableDic objectForKey:cell.reuseIdentifier];
    if (!dequeue) {
        dequeue = [[NSMutableArray alloc] init];
    }
    [dequeue addObject:cell];
    [self.dequeueReusableDic setObject:dequeue forKey:cell.reuseIdentifier];
    [cell removeFromSuperview];
}

- (void)dealloc {
    [self stopAnimation];
    [self.dequeueReusableDic removeAllObjects];
    [self.cycleCellArray removeAllObjects];
}
@end
