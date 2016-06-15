//
//  FWCycleScrollView.h
//  FWCycleScrollView
//
//  Created by 沈方伟 on 16/6/6.
//  Copyright © 2016年 沈方伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWCycleScrollView : UIView

/* ---- 方法 ----- */

/** 初始轮播图（推荐使用） */
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<SDCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/** 网络图片轮播初始化方式 */
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;

/** 本地图片轮播初始化方式 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup;


// 禁用
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)new UNAVAILABLE_ATTRIBUTE;

/* ---- 属性 ----- */
/** 数据源 */
@property (nonatomic, copy, nullable) NSArray *dataArray;

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

@end

NS_ASSUME_NONNULL_END
