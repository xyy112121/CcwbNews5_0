//
//  PhotoViewController.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoFooter.h"
#import "PhotoCollectionViewCell.h"
#import "PHFetchResult+PhotoObject.h"

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIViewControllerPreviewingDelegate>

/// @brief 显示的集合视图
@property (nonatomic, strong) UICollectionView * collectionView;
/// @brief cell‘s size
@property (nonatomic, assign) CGSize assetSize;
/// @brief 所有的照片资源
@property (nonatomic, strong) PHFetchResult * assets;
/// @brief 导航标题
@property (nonatomic, copy) NSString * itemTitle;
/// @brief 对应浏览控制器进行图片控制
@property (nonatomic, strong)NSMutableArray <PHAsset *> * selectAssets;
/// @brief 对应选中图片的状态，高清还是原图
@property (nonatomic, strong)NSMutableArray <NSNumber *> * selectAssetStatus;
/// @brief 最大允许的选择数目
@property (nonatomic, strong) NSNumber * maxNumberOfSelectImages;
/// @brief 底部的tabBar
@property (nonatomic, strong) UITabBar * bottomBar;
/// @brief 发送按钮
@property (strong, nonatomic) UIButton * sendButton;
/// @brief 显示数目
@property (strong, nonatomic) UILabel * numberOfLabel;
/// @brief 预览按钮
@property (strong, nonatomic) UIButton * bowerButton;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self DATA_init];
    [self UI_init];
}

#pragma mark - data
- (void)DATA_init
{
    _selectAssets = [NSMutableArray arrayWithCapacity:0];
    _selectAssetStatus = [NSMutableArray arrayWithCapacity:0];
    CGFloat sizeHeight = (self.view.frame.size.width - 3) /4;
    _assetSize = CGSizeMake(sizeHeight, sizeHeight);
}

#pragma mark - ui
- (void)UI_init
{
    //设置navigationItem
    self.navigationItem.title = _itemTitle;//Localized(_itemTitle);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleButtonDidTap)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomBar];
    if (_assets != nil && _assets.count >= 1) {
        //滚动到最后一个
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_assets.count - 1 inSection:0]atScrollPosition:UICollectionViewScrollPositionBottom animated:false];
        //重置偏移量
        [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y + 64)];
    }
}

#pragma mark - 设置numberOfLabel的数目
/** 设置当前选择后的资源数量 */
- (void)setNumbersForSelectAssets:(NSUInteger)number
{
    if (number == 0)
    {
        _numberOfLabel.hidden = true;
        _bowerButton.enabled = false;
        _sendButton.enabled = false;
        return;
    }
    _numberOfLabel.hidden = false;
    _bowerButton.enabled = true;
    _sendButton.enabled = true;
    _numberOfLabel.text = [NSString stringWithFormat:@"%@",@(number)];
    _numberOfLabel.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    //设置动画
    [UIView animateWithDuration:0.3 animations:^{
        _numberOfLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
}

-(UITabBar *)bottomBar
{
    if (_bottomBar == nil)
    {
        _bottomBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
        //add subviews
        [_bottomBar addSubview:self.sendButton];
        [_bottomBar addSubview:self.numberOfLabel];
        [_bottomBar addSubview:self.bowerButton];
    }
    return _bottomBar;
}

-(UIButton *)bowerButton
{
    if (_bowerButton == nil)
    {
        _bowerButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 60, 30)];
        [_bowerButton setTitle:@"预览" forState:UIControlStateNormal];
        [_bowerButton setTitle:@"预览" forState:UIControlStateDisabled];
        [_bowerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bowerButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.25] forState:UIControlStateDisabled];
        [_bowerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_bowerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        //默认不可点击
        _bowerButton.enabled = false;
        [_bowerButton addTarget:self action:@selector(bowerButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bowerButton;
}

-(UIButton *)sendButton
{
    if (_sendButton == nil)
    {
        _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_bottomBar.frame.size.width - 50 - 5, 0, 50, 40)];
//        _sendButton.center = CGPointMake(_sendButton.center.x, _bottomBar.center.y - _bottomBar.f_top);
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateDisabled];
        [_sendButton setTitleColor:UIColorFromRGB(0x2dd58a) forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sendButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //默认为不可点击
        _sendButton.enabled = false;
        [_sendButton addTarget:self action:@selector(chooseImagesComplete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(UILabel *)numberOfLabel
{
    if (_numberOfLabel == nil)
    {
        _numberOfLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sendButton.frame.origin.x - 20, 0, 20, 20)];
        _numberOfLabel.center = CGPointMake(_numberOfLabel.center.x, _sendButton.center.y);
        _numberOfLabel.backgroundColor = UIColorFromRGB(0x2dd58a);
        _numberOfLabel.textAlignment = NSTextAlignmentCenter;
        _numberOfLabel.font = [UIFont boldSystemFontOfSize:14];
        _numberOfLabel.text = @"";
        _numberOfLabel.hidden = true;
        _numberOfLabel.textColor = [UIColor whiteColor];
        _numberOfLabel.layer.cornerRadius = _numberOfLabel.frame.size.width / 2.0;
        _numberOfLabel.clipsToBounds = true;
    }
    return _numberOfLabel;
}


#pragma mark - Getter Function
-(UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64-44) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        //protocol
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
#ifdef __IPHONE_10_0
//        _collectionView.prefetchDataSource = self;
#endif
        //property
        _collectionView.backgroundColor = [UIColor whiteColor];
        //register View
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
        [_collectionView registerClass:[PhotoFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhotoFooter"];
    }
    return _collectionView;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    //获取当前cell的indexPath
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
//设置footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    PhotoFooter * resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhotoFooter" forIndexPath:indexPath];
    resuableView.numberOfAsset = self.assets.count;
    return resuableView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
#ifdef __IPHONE_9_0
    BOOL isPhoto = (((PHAsset *)[self.assets objectAtIndex:indexPath.row]).mediaType == PHAssetMediaTypeImage);
    //确定为图片
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable && isPhoto == true)
    {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
#endif
    /**********避免block中进行retail影响对象释放，造成内存泄露*********/
    __weak typeof(PhotoCollectionViewCell *)copy_cell = cell;
    __weak typeof(self) copy_self = self;
    __weak typeof(UICollectionView *)weakCollectionView = collectionView;
    /**********end*********/
    [((PHAsset *)[self.assets objectAtIndex:indexPath.row]) representationImageWithSize:_assetSize complete:^(UIImage * _Nullable image, PHAsset * _Nonnull asset) {
        // Configure the cell
        copy_cell.imageView.image = image;
        //如果不是photo类型,隐藏选择标志
        if (asset.mediaType != PHAssetMediaTypeImage)
        {
            copy_cell.chooseImageView.hidden = true;
            copy_cell.messageView.hidden = false;
            copy_cell.messageLabel.text =  [PhotosTimeHandleObject timeStringWithTimeDuration:asset.duration];
        }
        else{
            if ([copy_self.selectAssets containsObject:asset]) [copy_cell cellDidSelect];
            else [copy_cell cellDidDeselect];
        }
    }];
    cell.imageSelectedBlock = ^(PhotoCollectionViewCell * cell){
        if (copy_self.selectAssets.count >= copy_self.maxNumberOfSelectImages.unsignedIntegerValue)
        {
            //不再变化状态
            [cell cellDidDeselect];
            //alertController提示
            [copy_self alertControllerShouldPresent];
        }
        else//此图没有原图选项，所以都为高清
        {
            [copy_self.selectAssets addObject:[copy_self.assets objectAtIndex:[weakCollectionView indexPathForCell:cell].item]];
            [copy_self.selectAssetStatus addObject:[NSNumber numberWithUnsignedInteger:0]];
        }
        [copy_self setNumbersForSelectAssets:copy_self.selectAssets.count];
    };
    cell.imageDeselectedBlock = ^(PhotoCollectionViewCell * cell){
        PHAsset * deleteAsset = [copy_self.assets objectAtIndex:[weakCollectionView indexPathForCell:cell].item];
        //移除状态位
        [copy_self.selectAssetStatus removeObjectAtIndex:[copy_self.selectAssets indexOfObject:deleteAsset]];
        [copy_self.selectAssets removeObject:deleteAsset];
        [copy_self setNumbersForSelectAssets:copy_self.selectAssets.count];
    };
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.assetSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (((PHAsset *)[self.assets objectAtIndex:indexPath.row]).mediaType != PHAssetMediaTypeImage) return false;
    return true;
}


#pragma mark - action
- (void)btnAction:(id)sender
{
    
}

- (void)bowerButtonDidTap//预览按钮被点击
{
    NSLog(@"预览啦!");
}

- (void)cancleButtonDidTap//cancle button did tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photosControllerShouldBack:)])
    {
        [self.delegate photosControllerShouldBack:self];
        [self.navigationController popViewControllerAnimated:false];
    }
}

- (void)chooseImagesComplete//click finish buttonItem
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(photosController:photosSelected:Status:)])
    {
        [self.delegate photosController:self photosSelected:[_selectAssets mutableCopy] Status:[_selectAssetStatus mutableCopy]];;
        _selectAssets = nil;
        _selectAssetStatus = nil;
        [self.navigationController popViewControllerAnimated:false];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.assets = nil;
    self.selectAssets = nil;
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    NSLog(@"YPPhotosController Dealloc");
}

#pragma mark - UIAlertController
- (void)alertControllerShouldPresent
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你最多只能选择%@张照片",@(_maxNumberOfSelectImages.unsignedIntegerValue)] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
}


@end

@implementation PhotosTimeHandleObject

+(NSString *)timeStringWithTimeDuration:(NSTimeInterval)timeInterval
{
    NSUInteger time = (NSUInteger)timeInterval;
    
    //大于1小时
    if (time >= 60 * 60)
    {
        NSUInteger hour = time / 60 / 60;
        NSUInteger minute = time % 3600 / 60;
        NSUInteger second = time % (3600 * 60);
        
        return [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu",(unsigned long)hour,(unsigned long)minute,(unsigned long)second];
    }
    
    
    if (time >= 60)
    {
        NSUInteger mintue = time / 60;
        NSUInteger second = time % 60;
        
        return [NSString stringWithFormat:@"%.2lu:%.2lu",(unsigned long)mintue,(unsigned long)second];
    }
    
    return [NSString stringWithFormat:@"00:%.2lu",(unsigned long)time];
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
