//
//  AboutTableViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "AboutTableViewController.h"

@interface AboutTableViewController ()
{
    
}

@end

@implementation AboutTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //设置导航栏
    [self setupNavigationItem];
    
    self.tableView.tableHeaderView=[self addHeaderView];
    self.tableView.tableFooterView=[self addFooterView];
    self.tableView.scrollEnabled = NO;
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"关于";
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"more_share" highBackgroudImageName:@"more_share_p" target:self action:@selector(shareOnClick)];
}
- (void)shareOnClick{
    
}

- (UIView*)addHeaderView{
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/2)];
    UIImageView * iamgeView=[UIImageView new];
    iamgeView.layer.borderWidth=2;
    iamgeView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    iamgeView.layer.cornerRadius=10;
    iamgeView.image=[UIImage imageNamed:@"yaya.png"];
    [headerView addSubview:iamgeView];
    [MasonyUtil centerView:iamgeView size:CGSizeMake(150, 150)];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, headerView.size.height-60, headerView.size.width, 30)];
    label.text=@"扫描二维码，您的朋友也可以关注下小黄鸭！";
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [headerView addSubview:label];
    return headerView;
}

- (UIView*)addFooterView{
    UIView * footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.view.height/2-40*3)];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, footerView.size.height-100, self.view.width, 30)];
    label.text=@"Copyright©2011-2015";
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, footerView.size.height-115, self.view.width, 30)];
    label1.text=@"小黄鸭XHY.com版权所有";
    label1.textColor=[UIColor grayColor];
    label1.font=[UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label1];
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @[@"特别声明", @"使用帮助",@"给我评分"][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
