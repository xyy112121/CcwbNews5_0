//
//  PhotoGroupViewController.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoGroupViewController.h"
#import "PhotoViewController.h"
#import "PhotoTableViewCell.h"
#import "PHFetchResult+PhotoObject.h"

@interface PhotoGroupViewController ()<UITableViewDelegate,UITableViewDataSource,PhotosControllerDelegate>
{
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) PhotoStore * photoStore;
@property (nonatomic, strong) NSArray<PHAssetCollection *> * groups;
@property (nonatomic, strong) NSNumber * maxNumberOfSelectImages;

@end

@implementation PhotoGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UI_init];
    [self DATA_init];
    
}

#pragma mark - data
- (void)DATA_init
{
    __weak __typeof(self)weakSelf = self;
    self.photoStore = [[PhotoStore alloc]init];
    [self.photoStore fetchDefaultAllPhotosGroup:^(NSArray<PHAssetCollection *> * _Nonnull groups , PHFetchResult * _Nonnull fetchResult){
        weakSelf.groups = groups;
        [weakSelf.tableView reloadData];
        [weakSelf pushPhotosViewController:[NSIndexPath indexPathForRow:0 inSection:0] Animate:false];
    }];
}

#pragma mark - ui
- (void)UI_init
{
    self.navigationItem.title = @"相册";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidTap)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:0];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    tableView.tableFooterView = [UIView new];
    [tableView registerClass:[PhotoTableViewCell class] forCellReuseIdentifier:@"PhotoTableViewCell"];
}

- (void)rightBarButtonItemDidTap
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (IBAction)cancleItemButtonDidTap:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PhotoTableViewCell class]) forIndexPath:indexPath];
    PHAssetCollection * collection = [self.groups objectAtIndex:indexPath.row];
    __weak typeof(cell) weakCell = cell;
    [collection representationImageWithSize:CGSizeMake(60, 60) complete:^(NSString * _Nonnull title, NSUInteger estimatedCount, UIImage * _Nullable image) {
        NSString * localTitle = title;
        weakCell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",localTitle,@(estimatedCount)];
        weakCell.GruopImageView.image = image;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    [self pushPhotosViewController:indexPath Animate:true];
}

#pragma mark - push photosviewcontroller
- (void)pushPhotosViewController:(NSIndexPath *)indexPath Animate:(BOOL)animate
{
    PhotoViewController * collectionViewController = [[PhotoViewController alloc]init];
    //传递组对象
    [collectionViewController setValue:[self.photoStore fetchPhotos:self.groups[indexPath.row]] forKey:@"assets"];
    [collectionViewController setValue:self.groups[indexPath.row].localizedTitle forKey:@"itemTitle"];
    [collectionViewController setValue:self.maxNumberOfSelectImages forKey:@"maxNumberOfSelectImages"];
    collectionViewController.delegate = self;
    [self.navigationController pushViewController:collectionViewController animated:animate];
}

#pragma mark  PhotosControllerDelegate
-(void)photosController:(PhotoViewController *)viewController photosSelected:(nonnull NSArray<PHAsset *> *)assets Status:(nonnull NSArray<NSNumber *> *)status
{
    self.photosDidSelectBlock(assets,status);
}

-(void)photosControllerShouldBack:(PhotoViewController *)viewController
{
    [self dismissViewControllerAnimated:true completion:^{}];
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
