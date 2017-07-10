//
//  JPhotoMagenage.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/23.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "JPhotoMagenage.h"
#import "PhotoNavigationViewController.h"
#import "PhotoStore.h"

@interface JPhotoMagenage ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, copy) void(^completeBlock)(NSArray <UIImage *> * images);
@property(nonatomic, copy) void(^cancelBlock)();
@property(nonatomic, copy) void(^completeOneBlock)(UIImage *image);
@property(nonatomic, assign) BOOL single;
@property(nonatomic, assign) BOOL isTakePhoto;

@end

@implementation JPhotoMagenage

+ (JPhotoMagenage *)shareInstance
{
    static JPhotoMagenage *manager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [JPhotoMagenage new];
    });
    return manager;
}


+ (void)JphotoGetFromLibrayInController:(UIViewController *)viewController
                                 finish:(void(^)(NSArray <UIImage *> * images))finish
                                 cancel:(void(^)())cancel
{
    JPhotoMagenage *manage = [self shareInstance];
    [manage showPhotosInViewController:viewController];
    manage.completeBlock = finish;
    manage.cancelBlock = cancel;
}


+ (void)JphotoGetFromSystemInController:(UIViewController *)viewController
                                 finish:(void(^)(UIImage *image))finish
                                 cancel:(void(^)())cancel
{
    JPhotoMagenage *manage = [self shareInstance];
    [manage getSystemPhotoInViewController:viewController];
    manage.completeOneBlock = finish;
    manage.cancelBlock = cancel;
}

//拍照
+ (void)JphotoTakePhotoInController:(UIViewController *)viewController
                             finish:(void(^)(UIImage *image))finish
                             cancel:(void(^)())cancel;
{
    JPhotoMagenage *manage = [self shareInstance];
    [manage takePhotoInViewController:viewController];
    manage.completeOneBlock = finish;
    manage.isTakePhoto = YES;
    manage.cancelBlock = cancel;
}

// 拍照、相册
+ (void)getImageInController:(UIViewController *)viewController
                      finish:(void(^)(NSArray <UIImage *> * images))finish
                      cancel:(void(^)())cancel
{
    JPhotoMagenage *manage = [self shareInstance];
    manage.single = NO;
    [manage showActionSheetInViewController:viewController];
    manage.completeBlock = finish;
    manage.cancelBlock = cancel;
}

+ (void)getOneImageInController:(UIViewController *)viewController
                         finish:(void(^)( UIImage *images))finish
                         cancel:(void(^)())cancel
{
    JPhotoMagenage *manage = [self shareInstance];
    manage.single = YES;
    [manage showActionSheetInViewController:viewController];
    manage.completeOneBlock = finish;
    manage.cancelBlock = cancel;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _single = NO;
        _isTakePhoto = NO;
    }
    return self;
}

- (void)showActionSheetInViewController:(UIViewController *)viewController{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    
    
    UIAlertAction *libray = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _isTakePhoto = NO;
        if (self.single) {
            [self getSystemPhotoInViewController:viewController];
        }
        else
            [self showPhotosInViewController:viewController];
    }];
    [alert addAction:libray];
    
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _isTakePhoto = NO;
        [self takePhotoInViewController:viewController];
    }];
    [alert addAction:takePhoto];
    [viewController presentViewController:alert animated:YES completion:nil];
}


- (void)showPhotosInViewController:(UIViewController *)viewController{
    __weak __typeof(self)weakSelf = self;
    CGFloat size = [UIScreen mainScreen].bounds.size.width;
    PhotoNavigationViewController *vc = [[PhotoNavigationViewController alloc]init];
    vc.imageSize = CGSizeMake((size-4)/3, (size-4)/3);
    vc.photoImageSelectBlock = ^(NSArray <UIImage *> * images){
        weakSelf.completeBlock(images);
    };
    [viewController presentViewController:vc animated:YES completion:nil];
}

- (void)takePhotoInViewController:(UIViewController *)viewController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        [viewController presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)getSystemPhotoInViewController:(UIViewController *)viewController
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [viewController presentViewController:ipc animated:YES completion:nil];
}

#pragma mark navigation 代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
	viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image;//= [info objectForKey:UIImagePickerControllerEditedImage];
    image = (_isTakePhoto == YES)?[info objectForKey:UIImagePickerControllerEditedImage]:[info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:^{
        if (self.completeOneBlock) {
            self.completeOneBlock(image);
        }
        if (self.completeBlock) {
            self.completeBlock(@[image]);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:^{
        if (self.cancelBlock) {
            self.cancelBlock();
			
        }
    }];
}


@end
