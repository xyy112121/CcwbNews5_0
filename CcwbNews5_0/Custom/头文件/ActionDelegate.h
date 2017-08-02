//
//  ActionDelegate.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-6-18.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActionDelegate<NSObject>
@optional

-(void)DGclickArrowFolded:(EnTypeFunctionFoled)sender;  //点击 箭头展开
-(void)DGclickAddAppMachine:(NSDictionary *)sender;
-(void)DGclickpersoncenter:(id)sender;   //首页导航 栏个人中心
-(void)DGclickpersonlogin:(id)sender;  //登录注册
-(void)DGclickAddApplication:(int)clickflag;//点击添加应用
-(void)DGclickApplicationItem:(NSDictionary *)clickapp;   //点击选择某个底部应用
-(void)DGClickOpenAppManger:(id)sender;  //跳转到appmanger
-(void)DGclickTuJiPic:(id)sender;//列表上的图集
-(void)DGFocusClickNumberPic:(NSDictionary *)sender;//点击 某个焦点图
-(void)DGClickSingleTuJipic:(id)sender;//点击 单个图集
-(void)DGClickActivityPic:(id)sender;//点击
-(void)DGClickBurstNews:(NSDictionary *)dictemp; // 点击突发新闻
-(void)DGClickMoreNewsUrl:(NSDictionary *)moreurl;//点击 更多
-(void)DGClickwkwebviewCustomview:(NSString *)clickurl;//在view不是viewcontroller上点击开连接
-(void)DGClickHpFunctionView:(NSDictionary *)funcitem;//点击首页function
-(void)DGClickWkWebViewAlert:(id)sender;
-(void)DGClickOpenApplication:(NSString *)sender;  //点击打开应用
-(void)DGClickGoToSearch:(id)sender; //首页点击去搜索页面
-(void)DGClickSearchCannel:(id)sender;//搜索的取消
-(void)DGClickselectphoto:(id)sender;//爆料选择图片
- (void)DGClickselectcamera:(id)sender;//爆料选择照相
-(void)DGGototakevideo:(id)sender;//爆料选择视频
-(void)DGClickBrokeDisPlayPic:(NSString *)picpath ConView:(UIView *)conview FormImage:(UIImage *)fromimage;//点击爆料中的图片
-(void)DGUpLoadBrokeContentItem:(NSString *)fromtype FileURL:(NSString *)fileurl FileId:(NSString *)fileid Content:(NSString *)content TimeLength:(NSString *)timelength;//上传内容到爆料内容到表中
-(void)DGPlayaudio:(NSString *)mp3path PlayStatus:(EnPlaytatus)playstatus;//播放爆料音频
-(void)DGSetvideopath:(NSString *)sender Thumbimg:(UIImage *)thumbing;  //爆料视频回调
-(void)DGPlayVideo:(NSString *)videopath;//爆料播放视频
-(void)DGClickgotoqrcode:(id)sender;//点击跳转到二维码
-(void)DGGotoPopAdView:(NSString *)popadurl;//弹窗点击跳转
-(void)DGGotoGoodsDetailView:(NSDictionary *)goodsurl;//点击进入商品页面
-(void)DGClickShare:(NSString *)sender;//点击分享
-(void)DGclickNewsZuPic:(NSDictionary *)sender;//点击新闻组
-(void)DGCLickNctlEvent:(NSString *)jsevent;//导航栏点击事件
-(void)DGClickSearchTextField:(NSString *)strsearch;//搜索的时候点击 搜索
-(void)DGDeleteSearchTextfield:(NSString *)strsearch;//搜索删除
-(void)DGClickWebViewOpenApp:(NSString *)srcid;  //新闻详情页打开app
-(void)DGClickApplicationHpViewManger:(id)sender;  //应用管理页打开
-(void)DGClickWebViewAddApp:(NSString *)dictemp;
-(void)DGLoginSuccess:(NSString *)success;



-(void)clickchangeapplication:(int)sender ClickApp:(NSDictionary *)clickapp;  //点击 选择不同的应用
-(void)clickusermenu:(int)sener; //点击个人中心的四个按钮
-(void)loginsuccess:(id)sender;//登录成功
-(void)RefreshAddApplication:(id)sender; //选择应用后刷新 应用
-(void)gototakevideo:(id)sender;  //录制小视频
-(void)closetuji:(id)sender;
-(void)clicknewsarray:(NSDictionary *)dictemp;  //点击新闻组里面的新闻

-(void)hidePicWord:(id)sender;
-(void)removehomepagepop:(UIButton *)sender;
-(void)clickpoppush:(id)sender;

-(void)gotosetting:(id)sender;
-(void)clickwebviewurl:(NSString *)urlsrc;   //点击发现里面的url
-(void)openapplication:(NSDictionary *)dicapp; //点击打开
-(void)clickfindqrcode;
-(void)clickfindopenAR;  //发现里的ar

//gudie
-(void)guideviewsnift:(id)sender;//滑动guide最后一页，准备删除
-(void)gotoprepage:(int)sender;
-(void)gotoguidenextpage:(int)sender;

@end
