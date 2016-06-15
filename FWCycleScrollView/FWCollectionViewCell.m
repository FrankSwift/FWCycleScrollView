//
//  FWCollectionViewCell.m
//  FWCycleScrollView
//
//  Created by 沈方伟 on 16/6/6.
//  Copyright © 2016年 沈方伟. All rights reserved.
//

#import "FWCollectionViewCell.h"


@interface FWCollectionViewCell ()
/** 图片 */
@property (nonatomic, strong, nullable) UIImageView *iv;
@end
@implementation FWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];

    }
    return self;
}

- (void)setupViews{
    self.iv = ({
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        iv;
    });
    
    [self.contentView addSubview:self.iv];
}

- (void)setImageName:(NSString *)imageName{
    _imageName = [imageName copy];
    
    self.iv.image = [UIImage imageNamed:self.imageName];
}


@end
