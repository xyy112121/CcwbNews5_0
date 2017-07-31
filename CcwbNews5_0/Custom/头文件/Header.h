

//#define URLHeader @"http://172.16.5.30:82/app/public"
//接口
#define URLHeader @"http://newapp.ccwb.cn/"

//资源库n
#define URLResouceHeader @"http://cwresource.ccwb.cn/"

#define URLResouceUpLoadHeader @"http://res.ccwb.cn/"

//用户中心
#define URLInterFaceHeader  @"http://newuser.ccwb.cn/"
//#define URLInterFaceHeader @"http://172.16.5.45/UserApp/public"


//新闻连接
#define URLDetailhtml  @"/apppage/AppPage/detail.html?cw_id="
#define URLNewsDetailHref  [NSString stringWithFormat:@"%@%@",URLHeader,URLDetailhtml]

//商城
#define URLShopHeader @"http://ccwbshop.ccwb.cn" 

#define CwVersion  @"5.0" 
#define CwDevice   @"ios"
#define JMAdmin   @"admin"
#define CwQRCodeRule  @"http://cwapp.ccwb.cn"  //二维码扫描规则，只有符合这个规则的才判断
#define APP_KEY @"AijaDHgBnG7q9GEUwBQVsNAv"
#define DefaultUserInfo @"defaultuserinfo"
#define DefaultCWToken   @"defaultcwtoken"

#define TYImageText @"imagetext"  //图文 视频，直播，活动，发现
#define TYImage @"image"     //推广，广告
#define TYSudden @"sudden"    //突发
#define TYHorizontal  @"horizontal"  //晚报说
#define TYNormal  @"normal"  //常规新闻
#define TYImageArray @"imagearray"   // 图集
#define TYActivity @"activity"   // 图集
#define TYStock @"stock"	// 表示财经证券类型
#define TYNowTime @"nowtime"	// 表示返回后台时间

#define TYJWTKey @"pBsHKWefbAuZNxMofj5N"  //JWT的key
#define TYUMKey  @"5277603256240b690209fcc7"  //友盟key
#define TYEasyARkey @"n3n7iWR75u9VzHL7D7XXUZHwokqK0tETlDZa51WrDwBn3igW15pAtRXgYDbXuQAgdQhQCMW8y88CNtrl88GToK04AN0NElSMVAuRXKtABJMKGCMxV7hlq2TMTN170hwCxcl0wv6Gx4gl2fOrysSShLpYE9uYPkmwmJGg8yENi8G0chPYFfsfOa8s4TpOJN8sN2QzF9so"  //EasyAR key


#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define Tmp_path [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/videos"]
#define Cache_path [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define UserMessage [Cache_path stringByAppendingPathComponent:@"usermessage"]
#define AddGuidePage1 [Cache_path stringByAppendingPathComponent:@"addguidepage1"]
#define ApplicationFirstin [Cache_path stringByAppendingPathComponent:@"applicationfirstin"]

#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>6.3?7:6
#define CLEARCOLOR [UIColor clearcolor]
#define COLORNOW(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone6ratio 1.17  // 375/320
#define iphone6pratio 1.29 //  414/320

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//获得iOS版本
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue]

// View的right、left、bottom、top、width、height
#define XYViewRight(View)              (View.frame.origin.x + View.frame.size.width)
#define XYViewLeft(View)               (View.frame.origin.x)
#define XYViewBottom(View)             (View.frame.origin.y + View.frame.size.height)
#define XYViewTop(View)                (View.frame.origin.y)
#define XYViewWidth(View)              (View.frame.size.width)
#define XYViewHeight(View)             (View.frame.size.height)


//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]

//本地图片地址
#define LocalImageAddr(file,ext) [[NSBundle mainBundle] pathForResource:file ofType:ext]

//定义UIImage对象
#define LOADCACHEIMAGE(A) [UIImage imageWithContentsOfFile:A]

//字体
#define FONTN(F) [UIFont systemFontOfSize:F]
#define FONTB(F) [UIFont fontWithName:@"HelveticaNeue" size:F]//系统默认粗体
#define FONTHelve(F) [UIFont fontWithName:@"Helvetica" size:F]
#define FONTLIGHT(F) [UIFont fontWithName:@"STHeitiTC-Light" size:F]//黑体细体
#define FONTMEDIUM(F) [UIFont fontWithName:@"STHeitiTC-Medium" size:F]//黑体粗体
#define URLSTRING(str) [NSURL URLWithString:str]


