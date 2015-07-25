//
//  ViewController.m
//  YYCycleScrollView
//
//  Created by yuyuan on 15/7/25.
//  Copyright (c) 2015年 yuyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSMutableArray *messageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _messageArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [_messageArray addObject:[NSString stringWithFormat:@"这是第%d个",i]];
    }
    self.cell = [[YYCycleViewCell alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width , 30)];
    
    self.cell.backgroundColor = [UIColor whiteColor];
    self.cell.contentArray = _messageArray;
    [self.cell.cyclelView startAnimation];
    
    [self.view addSubview:self.cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
