//
//  PhotoNavigationViewController.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoNavigationViewController.h"
#import "PhotoGroupViewController.h"

@interface PhotoNavigationViewController ()

@end

@implementation PhotoNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.maxNumberOfSelectImages ==0) self.maxNumberOfSelectImages = 9;
    
    self.viewControllers = @[[[PhotoGroupViewController alloc]init]];
    
    //设置rootViewController
    PhotoGroupViewController * rootViewController = self.viewControllers.firstObject;
    [rootViewController setValue:[NSNumber numberWithUnsignedInteger:_maxNumberOfSelectImages]  forKey:@"maxNumberOfSelectImages"];
    __weak typeof(self) weakSelf = self;
    rootViewController.photosDidSelectBlock = ^(NSArray <PHAsset *> * assets,NSArray <NSNumber *> * status){
        if (weakSelf.photosDidSelectBlock != nil)
        {
            weakSelf.photosDidSelectBlock(assets,status);
        }
        if (weakSelf.photoImageSelectBlock != nil)
        {
            //开始请求图片对象
            [PhotoStoreHandleClass imagesWithAssets:assets status:status Size:weakSelf.imageSize complete:^(NSArray<UIImage *> * _Nonnull images) {
                weakSelf.photoImageSelectBlock(images);
                //dismiss掉
                [weakSelf dismissViewControllerAnimated:true completion:^{}];
            }];
        }
        if (weakSelf.photoImageSelectBlock == nil)
        {
            [weakSelf dismissViewControllerAnimated:true completion:^{}];
        }
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
