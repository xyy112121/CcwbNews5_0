//
//  Enum_set.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#ifndef Enum_set_h
#define Enum_set_h

typedef enum{
	//各个tag表示的意思
	EnCellTypeFocus=100,   //焦点类型
	EnCellTypeSudden,  //突发类型
	EnCellTypeFunction, //首页功能类型
	EnCellTypeNews,		//新闻列表
	EnCellTypeNewsGroup,    //专题
	EnCellTypeMore,  //更多类型
	EnCellTypeActivity,   //活动类型
	EnCellTypeApp,      //app推荐
	EnCellTypeBiz,     //商城
	EnCellTypeUrl,     //url类型
	EnCellTypePhoto,   //单图集多图片
	EnCellTypePhotoGroup,  //图集
    EnCellTypeSortFanKui,//排行榜与反馈
    EnCellTypeAddApplication,//添加就用
    EnCellTypeApplicationapp,//添加就用列表类型
    EnCellTypeAdUrl //普通url类型
}EnCellType;


typedef enum{
	EnFolded,         //折叠
	EnUnFolded        //展开
}EnTypeFunctionFoled;

//选择类型
typedef enum{
	EnNomalAppType,
	EnAddAppType
}EnSelectTypeApp;

//爆料来源
typedef enum
{
	FromCcwb,   //来自ccwb的回复
	FromUser    //来自用户的提问
}EnFromTypeBroke;

typedef enum    //极光IM是否登录
{
	EnJMLogin,
	ENJMNotLogin
}EnJMLoginStatus;

typedef enum  //webview是显示单页面还是多页面问题
{
	EnWebViewSingle,
	EnWebViewMuli
}EnWebViewWindowsType;

//音频播放状态
typedef enum
{
	EnPlay,   //来自ccwb的回复
	EnStop    //来自用户的提问
}EnPlaytatus;


//扫码选择类型
typedef enum
{
	EnQRCode,   //扫描二维码
	EnARCode    //AR扫描
}EnScanstatus;

typedef enum
{
	EnNavigateionYES,   //有导航 栏
	EnNavigateionNO    //无导航 栏
}EnNavigationFlag;

#endif /* Enum_set_h */


#define EnGuideViewTag  50000   //引导页view
#define EnHomePopAdViewTag   50010  //首屏广告页面
#define EnHomePopAdTimeLabelTag  50020  //首屏广告页面上的时间
#define EnHomePOPAdImageViewTag  50030  //全屏的首页广告图片
#define EnYLImageViewTag       50040   //YLImageView动画
#define EnFocusTitleLabelTag 50050 //焦点图的标题
#define EnFocusSMPageControlTag 50060  //滚动图片的SMPageControl
#define EnAppRecommendBtTag 50070  //应用添加按钮button
#define EnPersonModelBtTag  50080   //个人中心几个功能模块
#define EnHpNctlViewTag   50090  //首页导航 view
#define EnWebViewCustomTag  50100  //webviewcustomview  tag
#define EnPersonModelImageViewTag  50110   //个人中心几个功能模块的图片
#define EnPersonHeaderImageViewBgTag  50120  //个人中心图标背景
#define EnPersonHeaderImageViewTag  50130  //个人中心图片
#define EnPersonHeaderNameTag  50140  //个人中心图片
#define EnAddApplicationRightBtTag  50150  //添加 应用最右边的按钮
#define EnBottomApplicationBtTag  50200  //底部应用按钮
#define EnBottomApplicationImageviewTag  50300  //底部应用图片
#define EnAddApplicationScrollviewRightBtTag  50400  //添加 应用scrollview上的button
#define EnAddApplicationWebViewTag    50410   //添加应用的webview
#define EnTuJiListItemImageViewTag    50420   //图集的图片
#define EnActivityImageviewTag        50440    //activity imageview
#define EnSingleTujiItemImageViewTag  50450    //单个图片
#define EnGetWeatherInfoLabelTag1      50500 //获取天气信息
#define EnGetWeatherInfoLabelTag2      50501 //获取天气信息
#define EnHpFunctionButtonTag       50510  //首页function功能
#define EnGoodsCellSMPageControlTag  50600
#define EnGoodsCellFocusScrollviewTag  50610
#define EnHpChannelImageViewTag     50620 //channel的红线
#define EnHpChannelButtonTag     50630 //channel的button
#define EnHpChannelViewTAG     50640 //频道view
#define EnSearchHotWordBtTag    50650  //搜索热词按钮
#define EnRecordSecondLabel     50750   //爆料录间显示多少秒的label
#define EnBrokePicDisplayView   50800  //点击爆料显示图片

#define EnAddApplicationLeftFixedBtTag 51000  //底部左边固定图片
#define EnBottomApplicationLeftFixedImageviewTag  51100  //底部左边固定button

#define EnPopAdViewTag   51200  //弹窗广告
#define EnGoodsCellOneViewTag        51300    //商品循环的view
#define EnTuZuSaidViewTag     51400 //图组view
#define EnHpUserHeaderPic  51500 //首页头像pic
#define EnSearchTextFieldTag 51600 //搜索框textfield
#define EnNoSearchImageview   51700//搜索框

