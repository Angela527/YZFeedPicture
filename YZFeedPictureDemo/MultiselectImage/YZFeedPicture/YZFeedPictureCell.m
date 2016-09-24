//
//  YZFeedPictureCell.m
//  MultiselectImage
//
//  Created by QiQi on 16/02/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "YZFeedPicView.h"
#import "YZFeedPictureCell.h"

@implementation YZFeedPictureCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)imageArray:(NSMutableArray *)array {
    for (UIImageView *image in self.picScrollView.subviews) {
        [image removeFromSuperview];
    }
    if (!self.i) {
        self.i = array[0];
    }

    for (int i = 0; i < (int)array.count; i++) {

        self.feedPicView = [[YZFeedPicView alloc] initWithFrame:CGRectMake(90 * i, 0, 90, 90)];
        self.feedPicView.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
        [self.picScrollView addSubview:self.feedPicView];

        [self.feedPicView addSubview:self.feedPicView.imageView];
        UIImageView *closeImage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, 20, 20)];
        closeImage.image = [UIImage imageNamed:@"close"];
        closeImage.userInteractionEnabled = YES;
        closeImage.tag = i + 100;

        self.feedPicView.imageView.image = array[(NSUInteger)i];
        self.feedPicView.imageView.userInteractionEnabled = YES;
        self.feedPicView.imageView.tag = i;

        if (self.feedPicView.imageView.image.hash != self.i.hash) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage:)];
            [self.feedPicView addSubview:closeImage];
            [closeImage addGestureRecognizer:tap];
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage:)];
            [self.feedPicView.imageView addGestureRecognizer:tap];
        }
    }
    self.picScrollView.contentSize = CGSizeMake(array.count * 90, 0);
}
- (void)didClickImage:(UITapGestureRecognizer *)obj {
    UIView *s = obj.view;
    if (self.feedDelegate && [self.feedDelegate respondsToSelector:@selector(imageTag:)]) {
        [self.feedDelegate imageTag:(int)s.tag];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
