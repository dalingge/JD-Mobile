//
//  CartViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CartViewController.h"
#import "SDRefresh.h"
#import "DBYScrollView.h"
#import "DBYScrollViewButton.h"
#import "CartScrollModel.h"
#import "JDNavigationController.h"
#import "LoginViewController.h"
#import "TYAttributedLabel.h"
#import "CartTableViewCell.h"
#import "OrderViewController.h"
@interface CartViewController ()<UITableViewDataSource, UITableViewDelegate,DBYScrollViewDataSource,DBYScrollViewDelegate>
{
    NSMutableArray *_myArray;//模型
    TYAttributedLabel *_test;
    UIImageView * _loginBg;
    UIView * _buttomView;
    UILabel * price;
    
    float _money;
    int _currentNum;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;

@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;


@end


@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    
    //设置导航栏
    [self setupNavigationItem];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //启动下拉刷新
    [self setupHeader];
    [self initView];
    
    //初始化数据
    [self initData];
   // self.tableView.tableHeaderView=[self addHeaderBar];
    self.tableView.tableFooterView=[self addFooterBar];
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UserDefaultsUtils getOwnID] > 0) {
        _loginBg.hidden=YES;
        _test.hidden=YES;
        _buttomView.hidden=NO;
        self.tableView.tableHeaderView=nil;
    }else{
        self.tableView.tableHeaderView=[self addHeaderBar];
        _loginBg.hidden=NO;
        _test.hidden=NO;
        _buttomView.hidden=YES;
    }
}
#pragma mark 设置导航栏
- (void)setupNavigationItem {
    
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editClick)];
}

- (void)editClick{
    
}
-(void)initView{
    _buttomView =[UIView new];
    _buttomView.backgroundColor=rgba(0, 0, 0, 0.8);
    [self.view addSubview:_buttomView];
    [_buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 60));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UIButton * selectedBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
    [selectedBtn setImage:[UIImage imageNamed:@"syncart_round_check2" ] forState:UIControlStateNormal];
    selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [selectedBtn setTitle:@"全选" forState:UIControlStateNormal];
     [_buttomView addSubview:selectedBtn];
    price=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 150, 60)];
    price.textColor=[UIColor whiteColor];
    price.font=[UIFont systemFontOfSize:18];
    price.text=@"合计:￥4783.00";
    [_buttomView addSubview:price];
    UIButton * addCart =[UIButton createButtonWithFrame:CGRectMake(self.view.width-140, 0, 140, 60) Title:@"去结算" Target:self Selector:@selector(jieShuanClick)];
    [addCart.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addCart setBackgroundColor:JDColor(255, 100, 98)];
    [_buttomView addSubview:addCart];
}


-(void)jieShuanClick{
    [self.navigationController pushViewController:[[OrderViewController alloc]initWithOrderCount:_currentNum money:_money] animated:YES];
}

#pragma mark 启动下拉刷新
- (void)setupHeader{
    
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    //默认是在navigationController环境下，如果不是在此环境下，请设置
    refreshHeader.isEffectedByNavigationController = YES;
    [refreshHeader addToScrollView:self.tableView];
    
    UIImageView *headerBackground=[[UIImageView alloc] init];
    headerBackground.frame = CGRectMake(30, 0, 50, refreshHeader.bounds.size.height);
    headerBackground.image = [UIImage imageNamed:@"speed"];
    [refreshHeader addSubview:headerBackground];
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    animationView.frame = CGRectMake(80, 20, 50, refreshHeader.bounds.size.height);
    animationView.image = [UIImage imageNamed:@"staticDeliveryStaff"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;
    
    UIImageView *boxView = [[UIImageView alloc] init];
    boxView.frame = CGRectMake(200, 10, 15, 8);
    boxView.image = [UIImage imageNamed:@"box"];
    [refreshHeader addSubview:boxView];
    _boxView = boxView;
    
    UILabel *title= [[UILabel alloc] init];
    title.frame = CGRectMake(animationView.frame.size.width+110, 15, 200, 20);
    title.text = @"让购物更便捷";
    title.textColor = JDColor(128,128,128);
    title.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [refreshHeader addSubview:title];
    
    UILabel *label= [[UILabel alloc] init];
    label.frame = CGRectMake(animationView.frame.size.width+110, 40, 200, 20);
    label.text = @"下拉更新...";
    label.textColor = JDColor(182,182,182);
    label.font = [UIFont systemFontOfSize:14];
    [refreshHeader addSubview:label];
    _label = label;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        // 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakRefreshHeader endRefreshing];
        });
    };
    // normal状态执行的操作
    refreshHeader.normalStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        refreshView.hidden = NO;
        if (progress == 0) {
            _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _boxView.hidden = NO;
            _label.text = @"下拉更新...";
            [_animationView stopAnimating];
        }
        
        self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
        self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 90, progress * 35);
    };
    
    // willRefresh状态执行的操作
    refreshHeader.willRefreshStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _boxView.hidden = YES;
        _label.text = @"松手更新...";
        _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
        NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                            [UIImage imageNamed:@"deliveryStaff1"],
                            [UIImage imageNamed:@"deliveryStaff2"],
                            [UIImage imageNamed:@"deliveryStaff3"]
                            ];
        _animationView.animationImages = images;
        [_animationView startAnimating];
    };
    
    // refreshing状态执行的操作
    refreshHeader.refreshingStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _label.text = @"更新中...";
        //                [UIView animateWithDuration:1.5 animations:^{
        //                    self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
        //                }];
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader beginRefreshing];
}

#pragma mark 加载数据
-(void)initData{
    _myArray=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<12; i++) {
        CartScrollModel * model = [[CartScrollModel alloc]init];
        switch (arc4random()%6) {
            case 0:
                 model=[CartScrollModel initWithFirstTitle:@"联想（lenovo)" andPriceName:@"￥3899.00" andImageNumber:@"IMG_2206.PNG"];
                break;
            case 1:
                model=[CartScrollModel initWithFirstTitle:@"（printrite" andPriceName:@"￥39.00" andImageNumber:@"IMG_2203.PNG"];
                break;
            case 2:
                model=[CartScrollModel initWithFirstTitle:@"惠普（HP）M177fw彩" andPriceName:@"￥3330.00" andImageNumber:@"IMG_2205.PNG"];
                break;
            case 3:
                model=[CartScrollModel initWithFirstTitle:@"爱玛科MB-818智能无线蓝牙" andPriceName:@"￥199.00" andImageNumber:@"IMG_2207.PNG"];
                break;
            case 4:
                model=[CartScrollModel initWithFirstTitle:@"天色DR3150嗮鼓适应兄弟" andPriceName:@"￥439.00" andImageNumber:@"IMG_2211.PNG"];
                break;
            case 5:
                model=[CartScrollModel initWithFirstTitle:@"奥速V5剑客高清网络" andPriceName:@"￥99.00" andImageNumber:@"IMG_2223.PNG"];
                break;
                
                
            default:
                break;
        }
       

        [_myArray addObject:model];
    }
    
    
}

#pragma mark 顶部登陆视图
-(UIView*)addHeaderBar{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 320)];
    headerView.backgroundColor=JDColor(247, 247, 247);
    
    _loginBg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerView.size.width, 65)];
    _loginBg.image=[UIImage imageNamed:@"syn_header_top_bg"];
    [headerView addSubview:_loginBg];
    _test = [[TYAttributedLabel alloc ]initWithFrame:CGRectMake(10,10, CGRectGetWidth(self.view.frame)-10, 0)];
    // 文字间隙
    //label.characterSpacing = 2;
    // 文本行间隙
    _test.linesSpacing = 5;
    _test.textColor=[UIColor blackColor];
    _test.font=[UIFont systemFontOfSize:14];
    NSString *text = @"，您可以同步电脑与手机购物车中的商品。";
    [_test appendText:@"温馨提示：现在"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage: [UIImage  imageWithName:@"syn_login_bt1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 75, 30);
    [_test appendView:button];
    [_test appendText:text];
    
    // 自适应高度
    [_test sizeToFit];
    [headerView addSubview:_test];
    
    UIView * bgView = [UIView new];
    [headerView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 320-_loginBg.frame.size.height));
        make.bottom.mas_equalTo(headerView.mas_bottom);
    }];
    UIImageView * cartBg=[UIImageView new];
    cartBg.image=[UIImage imageWithName:@"cartNoContentIcon"];
    cartBg.userInteractionEnabled = YES;
    [bgView addSubview:cartBg];
    [MasonyUtil centerView:cartBg size:CGSizeMake(115, 100)];
 
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 185, headerView.size.width, 20)];
    title.text=@"购物车是空的";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor grayColor];
    [bgView addSubview:title];
    
    return headerView;
}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([UserDefaultsUtils getOwnID] == 0) {
        
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
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
    UIImageView * radio =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    radio.contentMode =  UIViewContentModeCenter;
    radio.image=[UIImage imageNamed:@"syncart_round_check2"];
    [header addSubview:radio];
    UIImageView * groupIoc =[[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 40, 40)];
    groupIoc.contentMode =  UIViewContentModeCenter;
    groupIoc.image=[UIImage imageNamed:@"orderDetail_JDShopIcon"];
    [header addSubview:groupIoc];
    
    UILabel * groupTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 100, 40)];
    groupTitle.text=@"京东自营";
    groupTitle.font=[UIFont systemFontOfSize:15];
    [header addSubview:groupTitle];

    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"Cell";
    CartTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil][0];
    }

    cell.cartRedio.image=[UIImage imageNamed:@"syncart_round_check2"];
    cell.cartImg.image=[UIImage imageNamed:@"C_0"];
    cell.cartTitle.text=@"苹果（Apple）iPhone6 （A1586）16GB金色 移动联通电信4G手机";
    cell.cartPrice.text=@"￥4783.00";
    cell.cartNumber.text=@"1";
    _money=4783;
    cell.callBack = ^(int currentNum){
        _currentNum=currentNum;
        price.text=[NSString stringWithFormat:@"合计:￥%.2f",_money*_currentNum];
    };
    
    return cell;
}

#pragma mark 返回table尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectio{
    UIView * footer =[[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
}

#pragma mark 低部滚动视图
- (UIView *)addFooterBar{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 230)];
    footerView.backgroundColor=[UIColor whiteColor];
    UILabel * title = [UILabel new];
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:18];
    title.text=@"    你可能想要";
    [footerView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(footerView.size.width, 45));
        make.top.mas_equalTo(footerView.mas_top);
    }];
    
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"MyAddressManager_line_new"];
    [title addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 0.5));
        make.bottom.mas_equalTo(title.mas_bottom);
    }];
    
    DBYScrollView *scrollView = [[DBYScrollView alloc]initWithFrame:CGRectMake(0, 45, footerView.size.width, 185)];
    scrollView.dataSource = self;
    scrollView.delegate = self;
    //scrollView.cycleEnabled = NO;//如果设置为NO，则关闭循环滚动功能。
    [footerView addSubview:scrollView];
    
    return footerView;
}



#pragma mark DBYScrollViewDataSource
-(UIView *)viewForDBYScrollView:(DBYScrollView *)adScrollView atPage:(NSInteger)pageIndex{
    UIView *view = [adScrollView dequeueReusableView];//先获取重用池里面的
    
    if (!view) {//如果重用池里面没有就创建
        view = [[UIView alloc]init];
        NSMutableArray * btnArray = [[NSMutableArray alloc]init];
        for (int i=3*(int)pageIndex; i<3*(pageIndex+1); i++) {
            
            DBYScrollViewButton * button=[DBYScrollViewButton new];
            CartScrollModel * model=_myArray[i];
            [button scrollViewButtonWith:model.price Title:model.title Image:[UIImage imageNamed:model.image]];
            [view addSubview:button];
            [btnArray addObject:button];
        }
        [MasonyUtil equalSpacingView:btnArray
                           viewWidth:(view.size.width/3)
                          viewHeight:150
                      superViewWidth:view.size.width];

    }
    

    return view;
}
-(NSUInteger)numberOfViewsForDBYScrollView:(DBYScrollView *)adScrollView{
  
    return _myArray.count/3;
}
#pragma mark DBYScrollViewDelegate
-(void)adScrollView:(DBYScrollView *)adScrollView didClickedAtPage:(NSInteger)pageIndex{
    NSLog(@"-->>点击了:%@",[ _myArray objectAtIndex:pageIndex]);
}
-(void)adScrollView:(DBYScrollView *)adScrollView didScrollToPage:(NSInteger)pageIndex{
    
    NSLog(@"--->>当前已展示:%@",[_myArray objectAtIndex:pageIndex]);
}
-(void)showLoginView{
    JDNavigationController *loginView = [[JDNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    [self presentViewController:loginView animated:YES completion:nil];
}

- (void)loginClick{
    [self showLoginView];
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
