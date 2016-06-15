//
//  ViewController.m
//  FWCycleScrollViewDemo
//
//  Created by 沈方伟 on 16/6/6.
//  Copyright © 2016年 沈方伟. All rights reserved.
//

#import "ViewController.h"
#import "FWCycleScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg"// 本地图片请填写全名
                            ];
    
    
    FWCycleScrollView *cycle = [FWCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) imageNamesGroup:imageNames];
    
    cycle.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    cycle.autoScrollTimeInterval = 1.0f;
    
    cycle.infiniteLoop = NO;
    
    cycle.autoScroll = NO;
    
    [self.view addSubview:cycle];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
