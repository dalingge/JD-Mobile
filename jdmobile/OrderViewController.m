//
//  OrderViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/25.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "OrderViewController.h"
#import "CashierTableViewController.h"
@interface OrderViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView * _buttomView;
    int _count;
    float _money;
}
@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OrderViewController


- (instancetype)initWithOrderCount:(int)count money:(float)money{
    self = [super init];
    if (self) {
        _count=count;
        _money=money;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    // Do any additional setup after loading the view.
    //设置导航栏
    [self setupNavigationItem];
     [self initView];
}

#pragma mark 设置导航栏
- (void)setupNavigationItem {
    
    self.navigationItem.title=@"填写订单";
}

-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView=[self addHeaderBar];
    _tableView.tableFooterView=[self addFooterBar];
    
    _buttomView =[UIView new];
    _buttomView.backgroundColor=rgba(0, 0, 0, 0.8);
    [self.view addSubview:_buttomView];
    [_buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 60));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UILabel* price=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 170, 60)];
    price.textColor=[UIColor whiteColor];
    price.font=[UIFont systemFontOfSize:18];
    price.text=[NSString stringWithFormat:@"实付款：￥%.2f",_money*_count];
    [_buttomView addSubview:price];
    UIButton * addCart =[UIButton createButtonWithFrame:CGRectMake(self.view.width-140, 0, 140, 60) Title:@"提交订单" Target:self Selector:@selector(submitClick)];
    [addCart.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addCart setBackgroundColor:JDColor(255, 100, 98)];
    [_buttomView addSubview:addCart];
}

-(void)submitClick{
    [self.navigationController pushViewController:[[CashierTableViewController alloc]initWithOrderMoney:_money*_count] animated:YES];
}

- (UIView*)addHeaderBar{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 115)];
    
    UIImageView * addressBg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, headerView.size.width, headerView.size.height-15)];
    addressBg.image=[UIImage imageNamed:@"address_info_bg"];
    [headerView addSubview:addressBg];
    UIImageView * nameImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 20, 20)];
    nameImg.contentMode =  UIViewContentModeCenter;
    nameImg.image=[UIImage imageNamed:@"address_name_icon"];
    [addressBg addSubview:nameImg];
    UILabel * name =[[UILabel alloc]initWithFrame:CGRectMake(30, 20, 100, 20)];
    name.text=@"丁博洋";
    [addressBg addSubview:name];
    
    UIImageView * phoneImg=[[UIImageView alloc]initWithFrame:CGRectMake(130, 20, 20, 20)];
    phoneImg.contentMode =  UIViewContentModeCenter;
    phoneImg.image=[UIImage imageNamed:@"address_phone_icon"];
    [addressBg addSubview:phoneImg];
    
    UILabel * phone =[[UILabel alloc]initWithFrame:CGRectMake(155, 20, 100, 20)];
    phone.text=@"158****1990";
    [addressBg addSubview:phone];
    
    UILabel * address = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, headerView.size.width-30, 40)];
    address.font=[UIFont systemFontOfSize:14];
    address.textColor=[UIColor darkGrayColor];
    address.numberOfLines =2;
    address.text=@"辽宁沈阳市铁西区二环内保工街12路狮城花园11号楼2-6-1";
    [addressBg addSubview:address];
    
    UIImageView * moreImg =[[UIImageView alloc]initWithFrame:CGRectMake(headerView.size.width-30, 0, 30, headerView.size.height)];
    moreImg.contentMode =  UIViewContentModeCenter;
    moreImg.image=[UIImage imageNamed:@"address_more_icon"];
    [addressBg addSubview:moreImg];
    return headerView;
}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 50;
    }
    return 80;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 15;
    }
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:  return 1;
        case 1:  return 2;
        case 2:  return 2;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                cell.imageView.image = [[UIImage imageWithName:@"C_0"] scaleImageWithSize:CGSizeMake(60, 60)];
                UIView * view=[[UIView alloc]initWithFrame:CGRectMake(80, 0, 190, 80)];
                UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.size.width, view.size.height-20)];
                name.text= @"苹果（Apple）iPhone6 (A1586)16GB金色 移动联通电信4G手机";
                name.numberOfLines=2;
                name.textColor=JDColor(147, 147, 147);
                name.font=[UIFont systemFontOfSize:15];
                [view addSubview:name];
                UILabel *count=[[UILabel alloc]initWithFrame:CGRectMake(0, view.size.height-35, view.size.width, 20)];
                count.textColor=JDColor(79, 79, 79);
                count.text= [NSString stringWithFormat:@"x%i",_count];
                count.font=[UIFont systemFontOfSize:15];
                [view addSubview:count];
                [cell.contentView addSubview:view];
                cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",_money];
                cell.detailTextLabel.textColor=JDColor(255, 100, 98);
                cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            }
   
            break;
        case 1:
            if (indexPath.row==0) {
                cell.textLabel.text=@"支付配送";
                UILabel *peixong=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width-30, 80)];
                peixong.font=[UIFont systemFontOfSize:15];
                peixong.text=@"在线支付\n京东快递\n2015-7-1(周三) 09:00-15:00";
                peixong.textAlignment = NSTextAlignmentRight;
                peixong.numberOfLines = 0;
                [cell.contentView addSubview:peixong];
            }else if (indexPath.row==1){
                cell.textLabel.text=@"发票信息";
                
                UILabel *xinxi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width-30, 80)];
                xinxi.font=[UIFont systemFontOfSize:15];
                xinxi.text=@"纸质发票\n个人\n非图书商品-明细";
                xinxi.textAlignment = NSTextAlignmentRight;
                xinxi.numberOfLines = 0;
                [cell.contentView addSubview:xinxi];
            }
            cell.textLabel.textColor=JDColor(147, 147, 147);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor=JDColor(79, 79, 79);
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            break;
        case 2:
            if (indexPath.row==0) {
                cell.textLabel.text=@"京东卡/E卡";
                cell.detailTextLabel.text=@"未使用";
                UILabel * wukeyong=[[UILabel alloc]initWithFrame:CGRectMake(100, 15, 40, 20)];
                wukeyong.textAlignment = NSTextAlignmentCenter;
                wukeyong.backgroundColor=[UIColor redColor];
                wukeyong.font = [UIFont systemFontOfSize:11];
                wukeyong.textColor=[UIColor whiteColor];
                wukeyong.text=@"无可用";
                [cell.contentView addSubview:wukeyong];
            }else if (indexPath.row==1){
                cell.textLabel.text=@"京豆";
                //cell.detailTextLabel.text=@"可用400京豆，抵￥4.00";
                self.autoSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_autoLoginSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _autoLoginSwitch.frame.size.height) / 2, _autoLoginSwitch.frame.size.width, _autoLoginSwitch.frame.size.height);
                [cell.contentView addSubview:_autoLoginSwitch];
                
                
                UILabel * jingdou=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 150, 20)];
                jingdou.font = [UIFont systemFontOfSize:12];
                jingdou.text=@"可用400京豆,抵￥4.00";
                [cell.contentView addSubview:jingdou];
            }
            cell.textLabel.textColor=JDColor(147, 147, 147);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor=JDColor(79, 79, 79);
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            break;
            
        default:
            break;
    }
    
    if (indexPath.section!=2 || indexPath.row!=1) {
         cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"address_more_icon"]];
    }
  
    return cell;
}

- (UIView*)addFooterBar{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 80+60)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * moneyName=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, view.size.width-15, view.size.height/2)];
    moneyName.text=@"商品金额";
    moneyName.textColor=JDColor(147, 147, 147);
    moneyName.font = [UIFont systemFontOfSize:15];
    [view addSubview:moneyName];
    
    UILabel * money=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.size.width-15, view.size.height/2)];
    money.text=[NSString stringWithFormat:@"￥%.2f",_money*_count];
    money.textAlignment = NSTextAlignmentRight;
    money.textColor=JDColor(255, 100, 98);
    money.font = [UIFont systemFontOfSize:15];
    [view addSubview:money];
    
    UILabel * freightName=[[UILabel alloc]initWithFrame:CGRectMake(15, view.size.height/2, view.size.width-15, view.size.height/2)];
    freightName.text=@"运费";
    freightName.textColor=JDColor(147, 147, 147);
    freightName.font = [UIFont systemFontOfSize:15];
    [view addSubview:freightName];

    UILabel * freight=[[UILabel alloc]initWithFrame:CGRectMake(0, view.size.height/2, view.size.width-15, view.size.height/2)];
    freight.text=@"+ ￥0.00";
    freight.textAlignment = NSTextAlignmentRight;
    freight.textColor=JDColor(255, 100, 98);
    freight.font = [UIFont systemFontOfSize:15];
    [view addSubview:freight];
    
    [footerView addSubview:view];
    return footerView;
}
#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UISwitch *)autoSwitch
{
    if (_autoLoginSwitch == nil) {
        _autoLoginSwitch = [[UISwitch alloc] init];
        //_autoLoginSwitch.thumbTintColor=[UIColor redColor];//按钮颜色
        //_autoLoginSwitch.tintColor=[UIColor redColor];//处于off时switch 的颜色
        _autoLoginSwitch.onTintColor=JDColor(240, 97, 98);//处于on时switch 的颜色
        [_autoLoginSwitch addTarget:self action:@selector(autoChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _autoLoginSwitch;
}

#pragma mark - action

- (void)autoChanged:(UISwitch *)autoSwitch
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
