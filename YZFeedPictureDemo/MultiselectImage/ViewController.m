//
//  ViewController.m
//  MultiselectImage
//
//  Created by QiQi on 16/9/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "ViewController.h"
#import "YZFeedPictureCell.h"

static NSString *const FeedPictureCellreuseIdentifier = @"YZFeedPictureCell";

@interface ViewController ()<DidClickImageDelegete>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * picArray;
@property (strong, nonatomic) UIImage * image;
@property (assign, nonatomic) BOOL hashImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.picArray = [NSMutableArray new];
    self.image = [UIImage imageNamed:@"add"];
    [self.picArray addObject:self.image];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YZFeedPictureCell"
                                                 bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:FeedPictureCellreuseIdentifier];
    
}

#pragma mark - TabelView Delegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        YZFeedPictureCell *picCell = [tableView dequeueReusableCellWithIdentifier:FeedPictureCellreuseIdentifier forIndexPath:indexPath];
        picCell.feedDelegate = self;
        [picCell imageArray:self.picArray];
        return picCell;
}

- (void)imageTag:(int)tag {
    if (tag < 100) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        return;
    } else {
        [self.picArray removeObjectAtIndex:(NSUInteger)tag - 100];
        for (UIImage *image in self.picArray) {
            if (self.image.hash != image.hash) {
                self.hashImage = YES;
            } else {
                self.hashImage = NO;
            }
        }
        if (self.hashImage == YES) {
            [self.picArray addObject:self.image];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - UIImagePickerControllerDelegate协议的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
        UIImage *image = info[UIImagePickerControllerEditedImage];
        if (image) {
            [self.picArray insertObject:image atIndex:0];
            if (self.picArray.count == 6) {
                [self.picArray removeObjectAtIndex:5];
            }
            [self.tableView reloadData];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
