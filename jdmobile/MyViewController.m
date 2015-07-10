//
//  MyViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "MyViewController.h"
#import "btRippleButtton.h"
#import "WalletCardButtonView.h"
#import "JDNavigationController.h"
#import "LoginViewController.h"
#import "SettingTableViewController.h"
#import "UserModel.h"
#import "UserDao.h"
#import "MyOrderTableViewController.h"
#import "MyAccountTableViewController.h"
#define CellFooterheight 70
#define HeadrCardColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
@interface MyViewController ()<UIAlertViewDelegate>
{
    UIScrollView * _scrollView;
    NSMutableArray *_myArray;//模型
}
@property (nonatomic, strong) UserModel *myInfo;
@property (nonatomic, readonly, assign) int64_t myID;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    //[self initView];
    //初始化数据
    [self initData];

    
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UserDefaultsUtils getOwnID] == 0) {
        self.tableView.tableHeaderView=[self addNoHeaderBar];
    }else{
        
        [self refreshView];
        self.tableView.tableHeaderView=[self addHeaderBar];
        
    }
}
- (void)refreshView{
    _myID = [UserDefaultsUtils getOwnID];
    if (_myID == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }else{
        DLog(@"========%lli",_myID);
        UserDao * ud=[[UserDao alloc]init];
        _myInfo=[ud selectAdd:[NSString stringWithFormat:@"%lld",_myID]];
        
    }
}

- (void)setupNavigationItem {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"my_more_btn_n" highBackgroudImageName:@"my_more_btn_h" target:self action:@selector(more)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"my_message_btn_n" highBackgroudImageName:@"my_message_btn_h" target:self action:@selector(message)];

}

- (void)more{
    
     SettingTableViewController * settingTVC=[[SettingTableViewController alloc]init];
      [self.navigationController pushViewController:settingTVC animated:YES];
}

- (void)message{
    
}

#pragma mark 加载数据
-(void)initData{
    _myArray=[[NSMutableArray alloc]init];
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
-(UIImageView*)addNoHeaderBar{
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my_unlogin_bg"];
    
    //未登录按钮光圈
    BTRippleButtton *unLoginBtnBg = [[BTRippleButtton alloc]
                                     initWithImage:[UIImage imageNamed:@"unlogin_head_n"]
                                     andFrame:CGRectMake(self.view.width/2-90/2, 20, 90, 90)
                                     onCompletion:^(BOOL success) {

                                         [self showLoginView];
                                        
                                     }];
    
    [unLoginBtnBg setRippeEffectEnabled:NO];
    [header addSubview:unLoginBtnBg];
    //头部卡片
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"head_extra_bg"];
    [header addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 50));
        make.bottom.mas_equalTo(header.mas_bottom);
    }];
    UIButton *view1 = [UIButton new];
    view1.titleLabel.font =[UIFont boldSystemFontOfSize:14 ];
    [view1 setTitle:@"关注的商品" forState:UIControlStateNormal];
    [bgView addSubview:view1];
    
    UIButton *view2 = [UIButton new];
    view2.titleLabel.font =[UIFont boldSystemFontOfSize:14 ];
    [view2 setTitle:@"关注的店铺" forState:UIControlStateNormal];
    [bgView addSubview:view2];
    
    UIButton *view3 = [UIButton new];
    view3.titleLabel.font =[UIFont boldSystemFontOfSize:14 ];
    [view3 setTitle:@"浏览记录" forState:UIControlStateNormal];
    [bgView addSubview:view3];
    
    [MasonyUtil equalSpacingView:@[view1,view2,view3]
                       viewWidth:(self.view.frame.size.width/3)-1
                      viewHeight:50
                  superViewWidth:self.view.frame.size.width];
  
    return header;
}

/**
 *  登录状态头部
 *
 *  @return 返回表格头部
 */
-(UIImageView*)addHeaderBar{
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my_login_bg"];
    
    //登录按钮光圈
    BTRippleButtton *unLoginBtnBg = [[BTRippleButtton alloc]
                                     initWithImage:[UIImage imageNamed:@"my_head_default"]
                                     andFrame:CGRectMake(20, 20, 90, 90)
                                     onCompletion:^(BOOL success) {
                                         [self.navigationController pushViewController:[[MyAccountTableViewController alloc]init] animated:YES];
                                     }];
    
    [unLoginBtnBg setRippeEffectEnabled:NO];
    [header addSubview:unLoginBtnBg];
    
    UILabel * userName=[[UILabel alloc]initWithFrame:CGRectMake(120, 25, header.size.width-120, 30)];
    userName.textColor=[UIColor whiteColor];
    userName.text=_myInfo.userName;
    [header addSubview:userName];
    
    UILabel * dengji=[[UILabel alloc]initWithFrame:CGRectMake(120, 55, header.size.width-120, 20)];
    dengji.textColor=[UIColor whiteColor];
    dengji.font=[UIFont systemFontOfSize:12];
    dengji.text=@"至尊用户";
    [header addSubview:dengji];
    
    UILabel * address=[[UILabel alloc]initWithFrame:CGRectMake(240, header.size.height-80, 120, 20)];
    address.textColor=[UIColor whiteColor];
    address.font=[UIFont systemFontOfSize:12];
    address.text=@"账户管理、收货地址〉";
    [header addSubview:address];
    //头部卡片
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"head_extra_bg"];
    [header addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 50));
        make.bottom.mas_equalTo(header.mas_bottom);
    }];
    
    WalletCardButtonView *btn11 = [WalletCardButtonView new];
    [btn11 walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.commodity] Title:@"关注的商品" Width:self.view.width/3 height:50];
    [bgView addSubview:btn11];
    
    WalletCardButtonView *btn22 = [WalletCardButtonView new];
    [btn22 walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.shop] Title:@"关注的店铺" Width:self.view.width/3 height:50];
    [bgView addSubview:btn22];
    
    
    WalletCardButtonView *btn33 = [WalletCardButtonView new];
    [btn33 walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.record] Title:@"浏览记录" Width:self.view.width/3 height:50];
    [bgView addSubview:btn33];
    
    [MasonyUtil equalSpacingView:@[btn11,btn22,btn33]
                       viewWidth:self.view.frame.size.width/3
                      viewHeight:50
                  superViewWidth:self.view.frame.size.width];
    
    return header;
}
-(void)showLoginView{
    JDNavigationController *loginView = [[JDNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    [self presentViewController:loginView animated:YES completion:nil];
}
#pragma mark 设置分组标题内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 25;
}

#pragma mark 设置尾部说明内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:  return CellFooterheight;
        case 1:  return CellFooterheight;
        default: return 1;
    }
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([UserDefaultsUtils getOwnID] == 0) {
        return 4;
    }
    return 5;
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 1;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"我的订单";
            cell.imageView.image = [UIImage imageNamed:@"my_order_icon"];
            cell.detailTextLabel.text=@"查看全部订单";
            break;
        case 1:
            cell.textLabel.text = @"我的钱包";
            cell.imageView.image = [UIImage imageNamed:@"my_wallet_icon"];
            cell.detailTextLabel.text=@"小金库、白条等";
            break;
        case 2:
            cell.textLabel.text = @"我的服务";
            cell.imageView.image = [UIImage imageNamed:@"my_service_icon"];
            cell.detailTextLabel.text=@"预约、营业厅等";
            break;
        case 3:
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"my_feedback_icon"];
            break;
        case 4:
            cell.textLabel.text = @"猜你喜欢";
            cell.imageView.image = [UIImage imageNamed:@"my_guess_icon"];
            break;
        default:
            break;
    }
    
    if(indexPath.section!=4){
        cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
    }
        
    return cell;
}

#pragma mark 返回table头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark 返回table尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer=[UIView new];
    footer.backgroundColor=[UIColor whiteColor];
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"MyAddressManager_line_new"];
    [footer addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 0.5));
        make.bottom.mas_equalTo(footer.mas_top);
    }];
    
    if (section==0) {

        UIButton *btn1 = [UIButton createButtonWithImage:@"wait_money_icon" Title:@"待付款" Target:self Selector:@selector(OnClick:)];
        btn1.tag=1;
        [footer addSubview:btn1];
        
        UIButton *btn2 = [UIButton createButtonWithImage:@"wait_product_icon" Title:@"待收货" Target:self Selector:@selector(OnClick:)];
        btn2.tag=2;
        [footer addSubview:btn2];
        
        UIButton *btn3 = [UIButton createButtonWithImage:@"wait_comment_icon" Title:@"待评价" Target:self Selector:@selector(OnClick:)];
        btn3.tag=3;
        [footer addSubview:btn3];
        
        UIButton *btn4 = [UIButton createButtonWithImage:@"wait_after_icon" Title:@"返修/退货" Target:self Selector:@selector(OnClick:)];
        btn4.tag=4;
        [footer addSubview:btn4];
        
        [MasonyUtil equalSpacingView:@[btn1,btn2,btn3,btn4]
                           viewWidth:self.view.width/4
                          viewHeight:CellFooterheight
                      superViewWidth:self.view.width];
        return footer;
    }else if(section==1){
        WalletCardButtonView *btn11 = [WalletCardButtonView new];
        [btn11 walletCardWith:@"0.00" Title:@"账户余额" Width:self.view.width/4 height:CellFooterheight];
    
        [footer addSubview:btn11];
        
        WalletCardButtonView *btn22 =[WalletCardButtonView new];
        [btn22 walletCardWith:@"0" Title:@"优惠劵" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:btn22];
        
        
        WalletCardButtonView *btn33 = [WalletCardButtonView new];
        [btn33 walletCardWith:@"0" Title:@"京豆" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:btn33];
        
        WalletCardButtonView *btn44 = [WalletCardButtonView new];
        [btn44 walletCardWith:@"0" Title:@"京东卡/E卡" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:btn44];
        
        [MasonyUtil equalSpacingView:@[btn11,btn22,btn33,btn44]
                           viewWidth:self.view.width/4
                          viewHeight:CellFooterheight
                      superViewWidth:self.view.width];
        return footer;
    }
    return nil;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"点击了第%i",(int)indexPath.section);
   [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
    if ([UserDefaultsUtils getOwnID] == 0) {
        [self showLoginView];
        return;
    }
}
- (void)OnClick:(UIButton*)sender{
    if ([UserDefaultsUtils getOwnID] == 0) {
        [self showLoginView];
        return;
    }
    MyOrderTableViewController * myOrderTVC=[[MyOrderTableViewController alloc]init];
    switch (sender.tag) {
        case 1:
            [self.navigationController pushViewController:myOrderTVC animated:YES];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
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
