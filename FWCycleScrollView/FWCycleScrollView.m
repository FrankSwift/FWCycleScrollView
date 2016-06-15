//
//  FWCycleScrollView.m
//  FWCycleScrollView
//
//  Created by 沈方伟 on 16/6/6.
//  Copyright © 2016年 沈方伟. All rights reserved.
//

#import "FWCycleScrollView.h"
#import "FWCollectionViewCell.h"
@interface FWCycleScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 内容 */
@property (nonatomic, strong, nullable) UICollectionView *contentView;

/** 布局 */
@property (nonatomic, strong, nullable) UICollectionViewFlowLayout *layout;

/** 计时器 */
@property (nonatomic, strong, nullable) NSTimer *timer;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentIndex;

/** 总数量 */
@property (nonatomic, assign) NSInteger totalImageCount;

@end
@implementation FWCycleScrollView

static NSString *FWCollectionViewCellID = @"FWCollectionViewCellID";
static NSInteger FWMultiple = 100;
#pragma mark -

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup{
    FWCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    
    cycleScrollView.dataArray = imageNamesGroup;
    
    return cycleScrollView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseSetting];
        [self setupViews];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    _layout.itemSize = self.frame.size;
    
//    _contentView.frame = self.bounds;
    
}
#pragma mark - Private
- (void)baseSetting{
    self.currentIndex = 0;
    
    // 默认值设置
    // 自动滚动
    _autoScroll = YES;
    // 滚动时间间隔 2.0f
    _autoScrollTimeInterval = 2.0f;
    // 滚动方向 垂直
    _scrollDirection = UICollectionViewScrollDirectionVertical;
    // 无限滚动
    _infiniteLoop = YES;

}

- (void)addTimer{
    self.timer = ({
        NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        
        [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
        
        timer;
    });
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupViews{
    self.layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = self.scrollDirection;
        layout.itemSize = self.frame.size;

        layout;
    });
    
    self.contentView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
                collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        
        [collectionView registerClass:[FWCollectionViewCell class] forCellWithReuseIdentifier:FWCollectionViewCellID];
        
        collectionView;
    });
    
    [self addSubview:self.contentView];
    
}

#pragma mark - Event Response
- (void)nextPage{
    
    // 判断滚动方向
    NSInteger itemIndex = self.contentView.contentOffset.y / self.contentView.bounds.size.height;
    
    UICollectionViewScrollPosition scrollPosition= UICollectionViewScrollPositionCenteredVertically;
    
    if(self.scrollDirection != UICollectionViewScrollDirectionVertical){//水平
        itemIndex = self.contentView.contentOffset.x / self.contentView.bounds.size.width;
        scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
    }
    
    NSInteger count = FWMultiple / 2 * self.dataArray.count;
    
    if (!self.infiniteLoop) { // 不是无限张
        count = 0;
    }
    
    NSInteger index = (itemIndex - count) % self.dataArray.count;
    
    itemIndex =  index + count;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];

    [self.contentView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:NO];
    
    if(itemIndex == (self.dataArray.count -1) && !self.infiniteLoop){//最后一张
        [self removeTimer];
        return;
    }
    
    NSInteger nextItemIndex = itemIndex + 1;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItemIndex inSection:0];

    [self.contentView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:scrollPosition animated:YES];
    
    
}

#pragma mark - UICollectionDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FWCollectionViewCellID forIndexPath:indexPath];
    cell.imageName = self.dataArray[indexPath.item % self.dataArray.count];
    return cell;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [self removeTimer];

    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self addTimer];
    }
}

#pragma mark - Setter And Getter
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = [dataArray copy];
    
    //是否无限滚动
    [self setInfiniteLoop:self.infiniteLoop];
    
    //是否自动轮播
    [self setAutoScroll:self.autoScroll];

    [self.contentView reloadData];
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    
    self.layout.scrollDirection = scrollDirection;
    
    [self setAutoScroll:self.autoScroll];

}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self removeTimer];
    
    if (autoScroll) {
        [self addTimer];
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop{
    _infiniteLoop = infiniteLoop;
    
    self.totalImageCount = infiniteLoop ? self.dataArray.count * FWMultiple : self.dataArray.count;

    if(infiniteLoop){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArray.count * FWMultiple / 2 inSection:0];
        [self.contentView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else{
        
    }
    
}

@end
