//
//  CommodityTableViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityTableViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "SearchBarView.h"
#import "JDNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "CommodityModel.h"
#import "CommodityTableViewCell.h"
#import "DetailsViewController.h"
@interface CommodityTableViewController ()<SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_commodity;
}
@end

@implementation CommodityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
    //初始化数据
    [self initData];
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView];
}


#pragma mark 加载数据
-(void)initData{

    NSString *path=[[NSBundle mainBundle] pathForResource:@"Commodity" ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    _commodity=[[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_commodity addObject:[CommodityModel commodityWithDictionary:obj]];
    }];
}
- (void)setupNavigationItem {
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"back_bt_7" highBackgroudImageName:nil target:self action:@selector(backClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"changeProductListGrid" highBackgroudImageName:nil target:self action:@selector(changeClick)];
    //将搜索条放在一个UIView上
    SearchBarView *searchView = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 7, 240 , 30)];
    searchView.delegate=self;
    self.navigationItem.titleView = searchView;
    self.navigationController.navigationBar.shadowImage=[[UIImage alloc]init];
}

- (void)initView{
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc]
                                        initWithFrame:CGRectMake(0, 64, self.view.width, 40)
                                        items:
                                        @[@{@"text":@"综合",@"icon":@"icon-sort"},
                                          @{@"text":@"销量"},
                                          @{@"text":@"价格",@"icon":@"icon-sort"},
                                          @{@"text":@"筛选",@"icon":@"icon-glass"}
                                          ]
                                        iconPosition:IconPositionRight
                                        andSelectionBlock:^(NSUInteger segmentIndex) {
                                            switch (segmentIndex) {
                                                case 0:
                                                    
                                                    break;
                                                case 1:
                                                    
                                                    break;
                                                case 2:
                                                    
                                                    break;
                                                case 3:
                                                    [(JDNavigationController*)self.navigationController showRightMenu];
                                                    break;
                                                    
                                                default:
                                                    break;
                                            }
                                                                         }];
    
    segmented.color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]];
    segmented.borderColor=[UIColor darkGrayColor];
    //segmented.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName:JDColor(135, 127, 141)};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                        NSForegroundColorAttributeName:JDColor(243, 106, 107)};
    
    [self.view addSubview:segmented];
    
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.width, self.view.height-104) style:UITableViewStylePlain];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor=JDColor(240, 243, 245);
    [self.view addSubview:_tableView];
    
}


- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource数据源方法
//#pragma mark 返回分组数
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commodity.count;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
     CommodityTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
           cell=[[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil][0];
    }

    CommodityModel *commodity =_commodity[indexPath.row];
    
    cell.commodityImg.image=[UIImage imageNamed:commodity.commodityImageUrl];
    cell.commodityName.text=commodity.commodityName;
    cell.commodityPrice.text=[NSString stringWithFormat:@"￥%@",commodity.commodityPrice];
    cell.commodityZX.image=[UIImage imageNamed:commodity.commodityZX];
    cell.commodityPraise.text=commodity.praise;
    
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark 每行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell selected at index path %i", (int)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController * detailsTVC = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:detailsTVC animated:YES];
    
}

#pragma mark 滑动事件
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scroll view did begin dragging");
}


@end
