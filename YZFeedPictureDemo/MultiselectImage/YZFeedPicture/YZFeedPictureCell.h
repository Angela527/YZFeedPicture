//
//  YZFeedPictureCell.h
//  MultiselectImage
//
//  Created by QiQi on 16/02/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZFeedPicView;
@protocol DidClickImageDelegete <NSObject>
- (void)imageTag:(int)tag;
@end

@interface YZFeedPictureCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *picScrollView;
@property (assign, nonatomic) id<DidClickImageDelegete> feedDelegate;
@property (strong, nonatomic) YZFeedPicView *feedPicView;

@property (strong, nonatomic) UIImage *i;
- (void)imageArray:(NSMutableArray *)array;

@end
