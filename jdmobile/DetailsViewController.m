//
//  DetailseViewController.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/22.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DetailsViewController.h"
#import "SDCycleScrollView.h"
#import "CellConfig.h"
#import "CartViewController.h"
#import "CommodityInfoCell.h"
#import "CommoditySelectCell.h"
#import "LoginViewController.h"
#import "JDNavigationController.h"
#import "DetailsMode.h"
@interface DetailsViewController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSArray *_images;
    UILabel *_indexPage;
}
@property (nonatomic, strong) UITableView *tableView;
/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
/// 数据模型
@property (nonatomic, strong) DetailsMode *modelToShow;
@end

@implementation DetailsViewController


- (DetailsMode *)modelToShow
{
    if (!_modelToShow) {
        _modelToShow = [DetailsMode new];
        // 假数据
        _modelToShow.detailsName=@"苹果（Apple）iPhone 6 (A1586) 16GB 金色 移动联通电信4G手机";
        _modelToShow.detailsActivity=@"初心未变，全场普惠，天天618.详情尽在iPhone天天618";
        _modelToShow.detailsPrice=@"￥4783.00";
        _modelToShow.detailsImgZX=@"ZX_Phone";
        _modelToShow.detailsTxtZX=@"比电脑购买省5元";
        _modelToShow.detailsSelect=@"金色 公开版 16GB 非合约机1个 可选延保";
        _modelToShow.detailsAddress=@"辽宁 沈阳市 铁西区";
        _modelToShow.detailsPraise=@"95%";
        _modelToShow.detailsPerson=@"46331人评论";
        
    }
    return _modelToShow;
}
/**
 *  改变不同类型cell的顺序、增删时，只需在此修改即可，
 *  无需在多个tableView代理方法中逐个修改
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        _dataArray = [NSMutableArray array];

        // 购买信息
        CellConfig *comInfo = [CellConfig cellConfigWithClassName:NSStringFromClass([CommodityInfoCell class]) title:@"购买信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightCommodityInfo cellType:NO];
        
        CellConfig *comSelect = [CellConfig cellConfigWithClassName:@"CommoditySelectCell" title:@"已选" showInfoMethod:@selector(showInfo:) heightOfCell:80.0f cellType:YES];
        
        CellConfig *comAddress = [CellConfig cellConfigWithClassName:@"CommodityAddressCell" title:@"地址" showInfoMethod:@selector(showInfo:) heightOfCell:180.0f cellType:YES];
        
        CellConfig *comPack = [CellConfig cellConfigWithClassName:@"CommodityPackCell" title:@"包装" showInfoMethod:@selector(showInfo:) heightOfCell:50.0f cellType:YES];
        
        CellConfig *comPraise = [CellConfig cellConfigWithClassName:@"CommodityPraiseCell" title:@"评价" showInfoMethod:@selector(showInfo:) heightOfCell:80.0f cellType:YES];
        
        CellConfig *comSection = [CellConfig cellConfigWithClassName:@"CommoditySectionCell" title:@"专区" showInfoMethod:@selector(showInfo:) heightOfCell:110.0f cellType:YES];
        
        CellConfig *comComponent = [CellConfig cellConfigWithClassName:@"CommodityComponentCell" title:@"配件" showInfoMethod:@selector(showInfo:) heightOfCell:50.0f cellType:YES];
        
        [_dataArray addObject:@[comInfo,comSelect,comAddress,comPack,comPraise,comSection,comComponent]];
        // 注意，是self.dataArray二维数组，所以这里要套一层数组
        
    }
     return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView];
}

- (void)setupNavigationItem {
    self.navigationItem.title=@"商品详情";
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.rightBarButtonItems =@[[UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ware_more" highBackgroudImageName:nil target:self action:@selector(wareMoreClick)], [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ware_histroy" highBackgroudImageName:nil target:self action:@selector(wareMoreClick)]];

}

- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView =[self addHeaderView];
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-60, self.view.width, 60)];
    view.backgroundColor=rgba(0, 0, 0, 0.8);
    [self.view addSubview:view];
    
    UIButton * addCart =[UIButton createButtonWithFrame:CGRectMake(view.size.width-160, 0, 160, view.size.height) Title:@"加入购物车" Target:self Selector:@selector(addCartClick)];
    [addCart.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addCart setBackgroundColor:JDColor(255, 100, 98)];
    [view addSubview:addCart];
    UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, view.size.width-addCart.size.width, view.size.height)];
    [view addSubview:view1];
    UIButton * focus =[UIButton createButtonWithImage:@"wareb_focus" Title:@"关注" Target:self Selector:@selector(addCartClick)];
    [focus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    focus.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 20, 0);
    focus.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);
    [view1 addSubview:focus];
    
    UIButton * cart =[UIButton createButtonWithImage:@"btn_ware_buy_h" Title:@"购物车" Target:self Selector:@selector(cartClick)];
    [cart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cart.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 20, 0);
    cart.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);
    [view1 addSubview:cart];
    [MasonyUtil equalSpacingView:@[focus,cart]
                       viewWidth:view1.size.width/2
                      viewHeight:view1.size.height
                  superViewWidth:view1.size.width];
}

- (UIView*)addHeaderView{
    _images = @[[UIImage imageNamed:@"h1.jpg"],
                [UIImage imageNamed:@"h2.jpg"],
                [UIImage imageNamed:@"h3.jpg"],
                [UIImage imageNamed:@"h4.jpg"]
                 ];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-280)];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, view.size.width, view.size.height) imagesGroup:_images];
    cycleScrollView.autoScroll = NO;
    cycleScrollView.infiniteLoop = NO;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [view addSubview:cycleScrollView];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circleBackground"]];
    imageView.frame=CGRectMake(cycleScrollView.size.width-70, cycleScrollView.size.height-70, 50, 50);
    [cycleScrollView addSubview:imageView];
    _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, imageView.size.width, imageView.size.height)];
    _indexPage.textAlignment = NSTextAlignmentCenter;
    _indexPage.font=[UIFont systemFontOfSize:24];
    _indexPage.textColor=[UIColor whiteColor];
    _indexPage.text=[NSString stringWithFormat:@"%i/%i",cycleScrollView.indexPage+1,(int)_images.count];
    [imageView addSubview:_indexPage];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return [self.dataArray[section] count];
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    CellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.modelToShow cellForRowAtIndexPath:indexPath];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    return cellConfig.heightOfCell;
}
#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==5) {
        return 15;;
    }
    return 0.001;
}



- (void)wareMoreClick{
    
}
-(void)showLoginView{
    JDNavigationController *loginView = [[JDNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    [self presentViewController:loginView animated:YES completion:nil];
}
- (void)addCartClick{
    
    if ([UserDefaultsUtils getOwnID] == 0) {
        [self showLoginView];
        return;
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"26x-Checkmark"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"恭喜,已添加至购物车。";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

- (void)cartClick{
    CartViewController * cartVC=[[CartViewController alloc]init];
    [self.navigationController pushViewController:cartVC animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}
- (void)indexOnPageControl:(NSInteger)index{
     _indexPage.text=[NSString stringWithFormat:@"%i/%i",(int)index+1,(int)_images.count];
}
@end
