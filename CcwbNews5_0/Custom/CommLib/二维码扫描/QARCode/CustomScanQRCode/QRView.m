//
//  QRView.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRView.h"
#import "Masonry.h"

@implementation QRView {
    
    UIImageView *_line;
    BOOL isStop;
}

- (instancetype)init{
    if(self=[super init]){
        [self initLine];
    }
    
    return self;
}

- (void)initLine {
    if(!_line){
//		CGSize viewSize =self.bounds.size;
		CGRect screenDrawRect =CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
		CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
										  screenDrawRect.size.height / 2 - self.transparentArea.height / 2 -40,
										  self.transparentArea.width,self.transparentArea.height);
        _line  = [[UIImageView alloc] initWithFrame:CGRectMake(clearDrawRect.origin.x, clearDrawRect.origin.y+12, self.transparentArea.width, 12)];
		_line.image = LOADIMAGE(@"QRCodeScanLine", @"png");//[UIImage imageNamed:@"QRCodeScanLine"];
        [_line setBackgroundColor:[UIColor clearColor]];
        _line.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_line];
    }
}

- (void)layoutLine{
	
	//中间清空的矩形框
	CGSize viewSize =self.bounds.size;
	CGRect screenDrawRect =CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
	CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
									  screenDrawRect.size.height / 2 - self.transparentArea.height / 2 -40,
									  self.transparentArea.width,self.transparentArea.height);
	_line.frame = CGRectMake(clearDrawRect.origin.x, clearDrawRect.origin.y+12, self.transparentArea.width, 12);
	
	DLog(@"_line====%f,%f,%f,%f",viewSize.width,viewSize.height,_line.frame.origin.x,_line.frame.origin.y);
}

- (void)startAnimation{
    if(!_line || isStop){
        return;
    }
    
    [self layoutLine];
    DLog(@"layoutLine====%f,%f",_line.frame.origin.x,_line.frame.origin.y);
    [UIView animateWithDuration:3 animations:^{
        _line.transform = CGAffineTransformMakeTranslation(0, self.transparentArea.height-24);
    } completion:^(BOOL finished) {
        _line.transform = CGAffineTransformIdentity;
        [self startAnimation];
    }];
    
}

- (void)startScan{
    if(_line){
        isStop = NO;
        if(nil == _line.superview){
            [self addSubview:_line];
        }
        [self startAnimation];
    }
}

- (void)stopScan{
    isStop = YES;
    [_line removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    
    //整个二维码扫描界面的颜色
    CGSize viewSize =self.bounds.size;
    CGRect screenDrawRect =CGRectMake(0, 0, viewSize.width,viewSize.height);
    
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                      screenDrawRect.size.height / 2 - self.transparentArea.height / 2 -40,
                                      self.transparentArea.width,self.transparentArea.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];
    
    [self addCenterClearRect:ctx rect:clearDrawRect];
    
    [self addWhiteRect:ctx rect:clearDrawRect];
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect];
    
    
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 60 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 232 /255.0, 56/255.0, 47/255.0, 1);//蓝色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
	CGContextSetLineWidth(ctx, 3.0);//线的宽度
	CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


@end
