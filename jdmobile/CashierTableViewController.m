 //
//  CashierTableViewController.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CashierTableViewController.h"

@interface CashierTableViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
    float _money;
}
@end

@implementation CashierTableViewController


- (instancetype)initWithOrderMoney:(float)money{
    self=[super init];
    if (self) {
        _money=money;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //设置导航栏
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    self.navigationItem.title=@"京东收银台";
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
#pragma mark 返回table头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header =[[UIView alloc]init];
    header.backgroundColor = [UIColor whiteColor];
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"order_split"];
    [header addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 0.5));
        make.bottom.mas_equalTo(header.mas_bottom);
    }];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.width-100, 40)];
    title.text=@"请选择支付方式";
    title.textColor=[UIColor grayColor];
    title.font=[UIFont systemFontOfSize:15];
    [header addSubview:title];
    
    UILabel * price = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width-110, 0, 90, 40)];
    price.text=[NSString stringWithFormat:@"%.2f元",_money];
    price.textAlignment = NSTextAlignmentRight;
    price.textColor=[UIColor redColor];
    price.font=[UIFont systemFontOfSize:15];
    [header addSubview:price];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image=[[UIImage imageNamed:@"JDPAY"]scaleImageWithSize:CGSizeMake(35, 35)];
                cell.textLabel.text=@"京东支付";
                cell.detailTextLabel.text=@"首次使用，满19立减5元（限实物）";
                cell.detailTextLabel.textColor=[UIColor redColor];
                break;
            case 1:
                cell.imageView.image=[[UIImage imageNamed:@"KJPAY"]scaleImageWithSize:CGSizeMake(35, 35)];
                cell.textLabel.text=@"快捷支付";
                cell.detailTextLabel.text=@"京东快捷支付服务）";
                break;
            case 2:
                cell.imageView.image=[[UIImage imageNamed:@"WCPAY"] scaleImageWithSize:CGSizeMake(35, 35)];
                cell.textLabel.text=@"微信支付";
                cell.detailTextLabel.text=@"微信安全支付";
                break;
                
            default:
                break;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
    
     HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"支付中";
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    

    
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(5);
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"支付成功";
//    [MBProgressHUD showSuccess:@"支付成功"];
    sleep(2);
}
@end
