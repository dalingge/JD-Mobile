//
//  JDNavigationController.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "JDNavigationController.h"
#import "RightMenuTableViewController.h"
#import "UIViewController+REFrostedViewController.h"

@interface JDNavigationController ()

//@property (strong, readwrite, nonatomic) RightMenuTableViewController *rightMenuTableViewController;

@end

@implementation JDNavigationController

//第一次使用这个类的时候调用1次
+ (void)initialize
{
    // 设置UINavigationBarTheme
    [self setupBarButtonItemTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}


//设置UINavigationBarTheme主题
+ (void)setupNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    //设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = JDNavigationFont;
    
    //设置导航栏背景
    if (!iOS7){
        [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        textAttrs[NSShadowAttributeName] = [[NSShadow alloc] init];
    }
    
    [appearance setTitleTextAttributes:textAttrs];
    
}

//设置UIBarButtonItem的主题
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:JDCommonColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    // 设置高亮状态的文字属性
    //    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:SWCommonColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateDisabled];
    /**自定义导航控制器返回按钮设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //自定义返回按钮
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_bt_7"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [appearance setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
  
}

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showRightMenu
{
    [self.frostedViewController presentMenuViewController];
}

#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.frostedViewController panGestureRecognized:sender];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航子控制器按钮的加载样式
//        UINavigationItem *vcBtnItem= [viewController navigationItem];
//        
//        vcBtnItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"back_bt_7" highImageName:@"back_bt_7" title:[[self.childViewControllers lastObject] title] target:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
