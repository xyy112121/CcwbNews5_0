//
//  XIConversationTipsCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/31.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface XIConversationTipsCellConfigurations : NSObject

@property (nonatomic, assign) CGFloat tipsHeight; // default is 30
@property (nonatomic, assign) UIEdgeInsets tipsInset; // default is (top: 5, left: 15, bottom: 5, right: 15)
@property (nonatomic, assign) CGFloat cornerRadius; // default is 0

@property (nonatomic, strong) UIColor *backgroundColor; // default is nil
@property (nonatomic, strong) UIColor *tipsTextColor; // default is #666666

@property (nonatomic, strong) UIFont *font; // default is system 12
@property (nonatomic, strong) NSDictionary<NSString *, id> *attributedText; // default is nil

@end
