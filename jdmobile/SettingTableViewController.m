//
//  SettingTableViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AboutTableViewController.h"
@interface SettingTableViewController ()
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@end


@implementation SettingTableViewController

@synthesize autoLoginSwitch = _autoLoginSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    self.navigationItem.title = @"更多";
    if ([UserDefaultsUtils getOwnID] > 0) {
       self.tableView.tableFooterView = self.footerView;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getter
- (UISwitch *)autoLoginSwitch
{
    if (_autoLoginSwitch == nil) {
        _autoLoginSwitch = [[UISwitch alloc] init];
        //_autoLoginSwitch.thumbTintColor=[UIColor redColor];//按钮颜色
        //_autoLoginSwitch.tintColor=[UIColor redColor];//处于off时switch 的颜色
          _autoLoginSwitch.onTintColor=JDColor(240, 97, 98);//处于on时switch 的颜色
        [_autoLoginSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _autoLoginSwitch;
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark 设置每行高度（每行高度可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    switch (section) {
        case 0:  return 3;
        case 1:  return 1;
        default: return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textColor=JDColor(93, 93, 93);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text =@"2G/3G网络手动下载图片";
            cell.accessoryType = UITableViewCellAccessoryNone;
            self.autoLoginSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.autoLoginSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.autoLoginSwitch.frame.size.height) / 2, self.autoLoginSwitch.frame.size.width, self.autoLoginSwitch.frame.size.height);
            [cell.contentView addSubview:self.autoLoginSwitch];
        }else if (indexPath.row==1){
            cell.textLabel.text = @"新浪微博";
            cell.detailTextLabel.text=@"未绑定";
            cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
        }else if (indexPath.row==2){
            cell.textLabel.text = @"清除本地缓存";
            cell.detailTextLabel.text=@"3.22M";
        }
    }else if(indexPath.section==1){
        
            if (indexPath.row==0) {
                cell.textLabel.text = @"关于";
                cell.detailTextLabel.text=@"V4.2.1";
                cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
            }
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==2){
                 [MBProgressHUD showSuccess:@"清除完毕"];
            }
            break;
        case 1:
            if (indexPath.row==0) {
                AboutTableViewController * aboutTVC=[[AboutTableViewController alloc]init];
                [self.navigationController pushViewController:aboutTVC animated:YES];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, _footerView.frame.size.width - 20, 50)];
        logoutButton.layer.cornerRadius=5;
        logoutButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
        [logoutButton setBackgroundColor:JDColor(228, 64, 68)];;
        [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:logoutButton];
    }
    
    return _footerView;
}
- (void)logoutAction
{
    [UserDefaultsUtils saveOwnID:@"0" userName:@"" commodity:0 shop:0 record:0];
    [UserDefaultsUtils clearCookie];
    self.tableView.tableFooterView =nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
     [MBProgressHUD showSuccess:@"退出登录"];
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
#pragma mark - action

- (void)autoLoginChanged:(UISwitch *)autoSwitch
{
    
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
