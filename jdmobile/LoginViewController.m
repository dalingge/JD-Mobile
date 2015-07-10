//
//  LoginViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/17.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "LoginViewController.h"
#import "DKTextField.h"
#import "CustomSwitch.h"
#import "RegisterViewController.h"
#import "UserDao.h"
#import "UserModel.h"
#import <KINWebBrowser/KINWebBrowserViewController.h>
static NSString *const defaultAddress = @"https://plogin.m.jd.com/user/login.action?appid=100&returnurl=http%3A%2F%2Fhome.m.jd.com%2FmyJd%2Fhome.action%3Fsid%3D6af1aba874fe8ed128b711e9d45f5216";

@interface LoginViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate,CustomSwitchDelegate,KINWebBrowserDelegate,MBProgressHUDDelegate>
{
     KINWebBrowserViewController *webBrowser;
     MBProgressHUD * HUD;

}
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) DKTextField *passwordField;
@property (nonatomic, strong) CustomSwitch *passwordSwitch;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *backPwdButton;

@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JDColor(240, 243, 245);
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView];
    
    NSArray *accountAndPassword = [UserDefaultsUtils getOwnAccountAndPassword];
    _accountField.text = accountAndPassword? accountAndPassword[0] : @"";
    //_passwordField.text = accountAndPassword? accountAndPassword[1] : @"";
}



- (void)setupNavigationItem {
    self.navigationItem.title=@"登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}

- (void)initView{
    //头部
    UIImageView * loginHeadBg = [UIImageView new];
    loginHeadBg.image = [UIImage imageNamed:@"login_head"];
    [self.view addSubview:loginHeadBg];
    
    [loginHeadBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 200));
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    UIImageView * loginBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 210, self.view.width, 120)];
    loginBg.image=[UIImage imageWithName:@"login_background"];
    [self.view addSubview:loginBg];
    //账号框
    _accountField =[UITextField new];
    _accountField.placeholder = @"用户名/邮箱/手机号";
    _accountField.textColor = [UIColor blackColor];
    _accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母是否大写
    _accountField.borderStyle=UITextBorderStyleNone; //外框类型
    _accountField.delegate = self;//设置代理 用于实现协议
    _accountField.returnKeyType = UIReturnKeyNext;//设置键盘按键类型
    _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;//UITextField 的一件清除按钮是否出现
    _accountField.enablesReturnKeyAutomatically = YES;//这里设置为无文字就灰色不可点
    [_accountField setLeftViewMode:UITextFieldViewModeAlways];
    [_accountField setLeftView:[_LolitaFunctions leftViewForTextFieldWithTest:@"账号："]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 60.5, loginBg.size.width-80, 0.5)];
    view.alpha = 0.5;
    view.backgroundColor = [UIColor grayColor];
    [loginBg addSubview:view];
    //密码框
    _passwordField = [DKTextField new];
    _passwordField.placeholder = @"请输入密码";
    _passwordField.textColor = [UIColor blackColor];
    _passwordField.secureTextEntry = YES;//是否以密码形式显示
    _passwordField.delegate = self;
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.enablesReturnKeyAutomatically = YES;
    [_passwordField setLeftViewMode:UITextFieldViewModeAlways];
    [_passwordField setLeftView:[_LolitaFunctions leftViewForTextFieldWithTest:@"密码："]];
    
    // 密码显示开关
    _passwordSwitch = [[CustomSwitch alloc]initWithFrame:CGRectMake(loginBg.size.width-100, 270, 100, 60)];
    _passwordSwitch.delegate=self;
    _passwordSwitch.arrange = CustomSwitchArrangeONLeftOFFRight;
    _passwordSwitch.onImage = [UIImage imageWithName:@"register_passwd_on"] ;
    _passwordSwitch.offImage = [UIImage imageWithName:@"register_passwd_off"];
    _passwordSwitch.status = CustomSwitchStatusOff;
     [self.view addSubview: _passwordSwitch];
   
    [_accountField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview: _accountField];
    [self.view addSubview: _passwordField];
    [_accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width-10, 60));
        make.top.mas_equalTo(loginBg.mas_top);
    }];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width-100, 60));
        make.bottom.mas_equalTo(loginBg.mas_bottom);
    }];
    //登录按钮
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20,350 ,self.view.width-20*2, 40)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn_gray"] forState:UIControlStateNormal];
     _loginButton.enabled = NO;
    [_loginButton addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _registerButton = [UIButton createButtonWithFrame:CGRectMake(20, 410, 100, 20) Title:@"手机快速注册" Target:self Selector:@selector(onClick:)];
    _registerButton.tag=0;
    [self.view addSubview:_registerButton];
    
    _backPwdButton = [UIButton createButtonWithFrame:CGRectMake(self.view.width-120, 410, 100, 20) Title:@"找回密码" Target:self Selector:@selector(onClick:)];
    _backPwdButton.tag=1;
    [self.view addSubview:_backPwdButton];
    //尾部
    UIView * loginFootBg =[UIView new];
    loginFootBg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:loginFootBg];
    [loginFootBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 40));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UIButton *WeChatBtn = [UIButton createButtonWithTitle:@"微信登录" Image:@"login_icon_wechat"  Target:self Selector:@selector(onClick:)];
    [loginFootBg addSubview:WeChatBtn];
    
    UIButton *QQBtn = [UIButton createButtonWithTitle:@"QQ登录" Image:@"login_icon_qq"  Target:self Selector:@selector(onClick:)];
    [QQBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
    [loginFootBg addSubview:QQBtn];
    
    UIButton *OthertBtn = [UIButton createButtonWithTitle:@"其他方式登录" Image:@""  Target:self Selector:@selector(onClick:)];
    [loginFootBg addSubview:OthertBtn];
    
    [MasonyUtil equalSpacingView:@[WeChatBtn,QQBtn,OthertBtn]
                       viewWidth:self.view.width/3
                      viewHeight:40
                  superViewWidth:self.view.width];
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
}

- (void)onClick:(UIButton*)sender{
       RegisterViewController *registerView = [[RegisterViewController alloc] init];
    switch (sender.tag) {
        case 0:
            registerView.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:registerView animated:YES];
            break;
        case 1:
            webBrowser = [KINWebBrowserViewController webBrowser];
            [webBrowser setDelegate:self];
            webBrowser.barTintColor=JDColor(249, 249, 249);
            webBrowser.showsPageTitleInNavigationBar = YES;
            [self.navigationController pushViewController:webBrowser animated:YES];
            [webBrowser loadURLString:defaultAddress];
            break;
            
        default:
            break;
    }
}

- (void)cancel{
     [self dismissViewControllerAnimated:YES completion:nil];
}


//登录操作
- (void)loginBtnClick{
    [self hidenKeyboard];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"登录中";
    
    UserDao * ud=[[UserDao alloc]init];
    UserModel *um=[ud selectLogin:_accountField.text :_passwordField.text];
    if (um!=nil) {
        [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        [UserDefaultsUtils saveOwnAccount:_accountField.text andPassword:_passwordField.text];
        [UserDefaultsUtils saveOwnID:um.userId userName:um.userName commodity:(int)um.commodity shop:(int)um.shop record:(int)um.record];
        [self saveCookies];
        
    }else{
        [MBProgressHUD showSuccess:@"账户和密码不匹配"];
    }
    
}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(5);
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"登录成功";
    //    [MBProgressHUD showSuccess:@"支付成功"];
    sleep(0.5);
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*** 不知为何有时退出应用后，cookie不保存，所以这里手动保存cookie ***/

- (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

#pragma mark - 键盘操作

- (void)hidenKeyboard
{
    [_accountField resignFirstResponder];
    [_passwordField resignFirstResponder];
}


- (void)returnOnKeyboard:(UITextField *)sender
{
    
    if (_accountField.text.length != 0 && _passwordField.text.length !=0 ) {
        _loginButton.enabled = YES;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn_red"] forState:UIControlStateNormal];
    } else {
        _loginButton.enabled = NO;
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn_gray"] forState:UIControlStateNormal];
        
    }
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _accountField) {
        return [_passwordField becomeFirstResponder];
    } else {
        [self hidenKeyboard];
        return [_passwordField resignFirstResponder];
    }
}

#pragma mark - customSwitch delegate
-(void)customSwitchSetStatus:(CustomSwitchStatus)status
{
    switch (status) {
        case CustomSwitchStatusOn:
             DLog(@"on")
             _passwordField.secureTextEntry = NO;
            break;
        case CustomSwitchStatusOff:
             DLog(@"off");
             _passwordField.secureTextEntry = YES;
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
