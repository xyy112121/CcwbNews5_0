//
//  ApplicationHpView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/7/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationHpView.h"

@implementation ApplicationHpView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor redColor];
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
        [self initview:nil];
	}
	return self;
}

-(void)initview:(NSDictionary *)dic
{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47-20)];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self addSubview:tableview];

}

#pragma mark tableviewdelegate
#pragma mark tableview 代理
-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 160;
   // return [[arrayheight objectAtIndex:indexPath.row] floatValue];
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 3;///[arrayheight count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    float nowheight;
   // NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    EnCellType celltype= EnCellTypeFocus;// = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
    FocusApplicationView *focusnews;
    
    switch (celltype)
    {
        case EnCellTypeFocus:
            focusnews = [[FocusApplicationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) Focus:nil];
            focusnews.delegate1 = self;
            [cell.contentView addSubview:focusnews];
            break;
        
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"123+%d",(int)indexPath.row];
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
