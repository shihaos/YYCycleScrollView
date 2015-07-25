//
//  YYCycleViewCell.m
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//

#import "YYCycleViewCell.h"

@interface YYCycleScrollContnentCell ()

@property(nonatomic, strong) UILabel *contentLabel;

@end

@implementation YYCycleScrollContnentCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14.0f];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentLabel.backgroundColor = [UIColor grayColor];

    [self addSubview:self.contentLabel];
  }

  return self;
}

- (void)setContent:(NSString *)content {
  self.contentLabel.text = content;
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.contentLabel.text.length > 0) {
    self.contentLabel.hidden = NO;
    [self.contentLabel sizeToFit];
    self.contentLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame),
                                         CGRectGetHeight(self.frame));
  } else {
    self.contentLabel.hidden = YES;
  }
}

@end

@implementation YYCycleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  self.contentArray = [NSMutableArray array];

  self.cyclelView = [[YYCycleScrollView alloc] init];
  self.cyclelView.delegate = self;
  self.cyclelView.dataSource = self;
  self.cyclelView.animationDuration = 0.5;
  self.cyclelView.delayTime = 4;
  self.cyclelView.backgroundColor = [UIColor grayColor];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.text = @"轮播广告：";
  self.titleLabel.font = [UIFont systemFontOfSize:14.0f];

  [self addSubview:self.cyclelView];
  [self addSubview:_titleLabel];

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.cyclelView.frame = CGRectMake(100, (CGRectGetHeight(self.frame)),
                                     [UIScreen mainScreen].bounds.size.width,
                                     CGRectGetHeight(self.frame));
  self.titleLabel.frame = CGRectMake(35.0f, 35.0f, 80.0f, 20.0f);
}
#pragma mark - YYCycleScrollViewDataSource
- (YYCycleScrollViewCell *)cycleView:(YYCycleScrollView *)cycleView
               cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellWithIdentifier = @"contentCell";

  YYCycleScrollContnentCell *cell = (YYCycleScrollContnentCell *)[cycleView
      dequeueReusableCellWithIdentifier:cellWithIdentifier];
  if (cell == nil) {
    cell = [[YYCycleScrollContnentCell alloc]
        initWithReuseIdentifier:cellWithIdentifier];
  }

  cell.content = self.contentArray[indexPath.row];

  return cell;
}

- (NSInteger)rowsOfCycle {
  return self.contentArray.count;
}
@end
