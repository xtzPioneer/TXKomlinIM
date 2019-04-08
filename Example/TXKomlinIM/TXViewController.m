//
//  TXViewController.m
//  TXKomlinIM
//
//  Created by 907689522@qq.com on 04/08/2019.
//  Copyright (c) 2019 907689522@qq.com. All rights reserved.
//

#import "TXViewController.h"
#import "TXKomlinIM.h"

@interface TXViewController ()<TXKomlinIMDelegate>
@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,weak)UITextField *userTextField;
@property (nonatomic,weak)UITextField *msgTextField;
@property (nonatomic,strong)TXKomlinIMDelegate *komlinIMDelegate;
@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat viewW=self.view.frame.size.width;
    CGFloat viewH=self.view.frame.size.height;
    // 提示
    UILabel *prompt1=[[UILabel alloc]init];
    prompt1.text=@"接收到的消息:";
    prompt1.textColor=[UIColor blackColor];
    prompt1.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:prompt1];
    CGFloat prompt1X=15;
    CGFloat prompt1Y=40;
    CGFloat prompt1W=viewW-prompt1X*2;
    CGFloat prompt1H=20;
    prompt1.frame=CGRectMake(prompt1X, prompt1Y, prompt1W, prompt1H);
    // textView
    UITextView *textView=[[UITextView alloc]init];
    textView.layer.borderWidth=1;
    textView.layer.borderColor=[UIColor grayColor].CGColor;
    textView.layer.cornerRadius=10;
    textView.layer.masksToBounds=YES;
    textView.editable=NO;
    [self.view addSubview:textView];
    self.textView=textView;
    CGFloat textViewX=15;
    CGFloat textViewY=CGRectGetMaxY(prompt1.frame)+15;
    CGFloat textViewW=viewW-textViewX*2;
    CGFloat textViewH=100;
    self.textView.frame=CGRectMake(textViewX, textViewY, textViewW, textViewH);
    // 提示
    UILabel *prompt2=[[UILabel alloc]init];
    prompt2.text=@"接收用户:";
    prompt2.textColor=[UIColor blackColor];
    prompt2.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:prompt2];
    CGFloat prompt2X=prompt1X;
    CGFloat prompt2Y=CGRectGetMaxY(self.textView.frame)+15;
    CGFloat prompt2W=prompt1W;
    CGFloat prompt2H=prompt1H;
    prompt2.frame=CGRectMake(prompt2X, prompt2Y, prompt2W, prompt2H);
    // userTextField
    UITextField *userTextField=[[UITextField alloc]init];
    userTextField.layer.borderWidth=1;
    userTextField.layer.borderColor=[UIColor grayColor].CGColor;
    userTextField.layer.cornerRadius=10;
    userTextField.layer.masksToBounds=YES;
    userTextField.text=@"yl";
    [self.view addSubview:userTextField];
    self.userTextField=userTextField;
    CGFloat userTextFieldX=textViewX;
    CGFloat userTextFieldY=CGRectGetMaxY(prompt2.frame)+15;
    CGFloat userTextFieldW=textViewW;
    CGFloat userTextFieldH=40;
    self.userTextField.frame=CGRectMake(userTextFieldX, userTextFieldY, userTextFieldW, userTextFieldH);
    // 提示
    UILabel *prompt3=[[UILabel alloc]init];
    prompt3.text=@"发送的信息:";
    prompt3.textColor=[UIColor blackColor];
    prompt3.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:prompt3];
    CGFloat prompt3X=prompt1X;
    CGFloat prompt3Y=CGRectGetMaxY(self.userTextField.frame)+15;
    CGFloat prompt3W=prompt1W;
    CGFloat prompt3H=prompt1H;
    prompt3.frame=CGRectMake(prompt3X, prompt3Y, prompt3W, prompt3H);
    // msgTextField
    UITextField *msgTextField=[[UITextField alloc]init];
    msgTextField.layer.borderWidth=1;
    msgTextField.layer.borderColor=[UIColor grayColor].CGColor;
    msgTextField.layer.cornerRadius=10;
    msgTextField.layer.masksToBounds=YES;
    msgTextField.text=@"测试001";
    [self.view addSubview:msgTextField];
    self.msgTextField=msgTextField;
    CGFloat msgTextFieldX=textViewX;
    CGFloat msgTextFieldY=CGRectGetMaxY(prompt3.frame)+15;
    CGFloat msgTextFieldW=textViewW;
    CGFloat msgTextFieldH=40;
    self.msgTextField.frame=CGRectMake(msgTextFieldX, msgTextFieldY, msgTextFieldW, msgTextFieldH);
    // 按钮
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:@"点击发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonX=15;
    CGFloat buttonY=CGRectGetMaxY(self.msgTextField.frame)+15;
    CGFloat buttonW=viewW-buttonX*2;
    CGFloat buttonH=25;
    button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [self.view addSubview:button];
    // 按钮
    UIButton *button2=[[UIButton alloc]init];
    [button2 setTitle:@"点击注册" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(button2Event:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat button2X=15;
    CGFloat button2Y=CGRectGetMaxY(button.frame)+15;
    CGFloat button2W=viewW-buttonX*2;
    CGFloat button2H=25;
    button2.frame=CGRectMake(button2X, button2Y, button2W, button2H);
    [self.view addSubview:button2];
    // 按钮
    UIButton *button3=[[UIButton alloc]init];
    [button3 setTitle:@"点击登出" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button3 addTarget:self action:@selector(button3Event:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat button3X=15;
    CGFloat button3Y=CGRectGetMaxY(button2.frame)+15;
    CGFloat button3W=viewW-buttonX*2;
    CGFloat button3H=25;
    button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);
    [self.view addSubview:button3];
    // 按钮
    UIButton *button4=[[UIButton alloc]init];
    [button4 setTitle:@"点击登录" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button4 addTarget:self action:@selector(button4Event:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat button4X=15;
    CGFloat button4Y=CGRectGetMaxY(button3.frame)+15;
    CGFloat button4W=viewW-buttonX*2;
    CGFloat button4H=25;
    button4.frame=CGRectMake(button4X, button4Y, button4W, button4H);
    [self.view addSubview:button4];
    // 按钮
    UIButton *button5=[[UIButton alloc]init];
    [button5 setTitle:@"点击下线" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button5 addTarget:self action:@selector(button5Event:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat button5X=15;
    CGFloat button5Y=CGRectGetMaxY(button4.frame)+15;
    CGFloat button5W=viewW-buttonX*2;
    CGFloat button5H=25;
    button5.frame=CGRectMake(button5X, button5Y, button5W, button5H);
    [self.view addSubview:button5];
    // 按钮
    UIButton *button6=[[UIButton alloc]init];
    [button6 setTitle:@"点击上线" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button6 addTarget:self action:@selector(button6Event:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat button6X=15;
    CGFloat button6Y=CGRectGetMaxY(button5.frame)+15;
    CGFloat button6W=viewW-buttonX*2;
    CGFloat button6H=25;
    button6.frame=CGRectMake(button6X, button6Y, button6W, button6H);
    [self.view addSubview:button6];
    
    // 监听
    self.komlinIMDelegate=[[TXKomlinIMDelegate alloc]init];
    self.komlinIMDelegate.delegate=self;
    // 登录
    [self button4Event:button4];
	// Do any additional setup after loading the view, typically from a nib.
}

/** 按钮事件 */
- (void)buttonEvent:(id)sender{
    XMPPMessage *aMessage=[[XMPPMessage alloc]initWithType:@"chat" to:[XMPPJID jidWithUser:@"yl" domain:[TXKomlinIMManager manager].configuration.komlinIMDomain resource:[TXKomlinIMManager manager].configuration.komlinIMResource]];
    [aMessage addBody:self.msgTextField.text];
    [TXKomlinIMManager sendMessageWithMessage:aMessage];
}

/** 按钮2事件 */
- (void)button2Event:(id)sender{
    [TXKomlinIMManager registeredWithUserName:@"dj" password:@"123456"];
}

/** 按钮3事件 */
- (void)button3Event:(id)sender{
    [TXKomlinIMManager signOut];
}

/** 按钮4事件 */
- (void)button4Event:(id)sender{
    // 登录
    [TXKomlinIMManager logInWithUserName:@"zx" password:@"123456"];
}

/** 按钮5事件 */
- (void)button5Event:(id)sender{
    [TXKomlinIMManager Offline];
}

/** 按钮6事件 */
- (void)button6Event:(id)sender{
    [TXKomlinIMManager online];
}

/**
 *  服务器连接状态
 *  @param delegate 代理对象
 *  @param serverConnectStatus 服务器连接状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate serverConnectStatus:(TXKomlinIMConnectStatus)serverConnectStatus info:(NSDictionary*)info{
    NSString*msg=nil;
    switch (serverConnectStatus) {
        case 0:
        {
            msg=@"无状态";
        }
            break;
        case 1:
        {
            msg=@"正在连接服务器...";
        }
            break;
        case 2:
        {
            msg=@"服务器连接失败";
        }
            break;
        case 3:
        {
            msg=@"服务器连接超时";
        }
            break;
        case 4:
        {
            msg=@"服务器连接成功";
        }
            break;
        case 5:
        {
            msg=@"断开连接或连接失败";
        }
            break;
            
        default:
            break;
    }
    self.textView.text=msg;
}

/**
 *  登录状态
 *  @param delegate 代理对象
 *  @param loginStatus 登录状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate loginStatus:(TXKomlinIMLoginStatus)loginStatus info:(NSDictionary*)info{
    NSString*msg=nil;
    switch (loginStatus) {
        case 0:
        {
            msg=@"无状态";
        }
            break;
        case 1:
        {
            msg=[NSString stringWithFormat:@"%@正在登录...",delegate.manager.myJID.user];
        }
            break;
        case 2:
        {
            msg=[NSString stringWithFormat:@"%@登录成功",delegate.manager.myJID.user];
        }
            break;
        case 3:
        {
            msg=[NSString stringWithFormat:@"%@登录失败...",delegate.manager.myJID.user];;
        }
            break;
            
        default:
            break;
    }
    self.textView.text=msg;
}

/**
 *  注册状态
 *  @param delegate 代理对象
 *  @param registrationStatus 注册状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate registrationStatus:(TXKomlinIMLoginStatus)registrationStatus info:(NSDictionary*)info{
    NSString*msg=nil;
    switch (registrationStatus) {
        case 0:
        {
            msg=@"无状态";
        }
            break;
        case 1:
        {
            msg=[NSString stringWithFormat:@"%@正在注册...",delegate.manager.myJID.user];
        }
            break;
        case 2:
        {
            msg=[NSString stringWithFormat:@"%@注册成功",delegate.manager.myJID.user];
        }
            break;
        case 3:
        {
            msg=[NSString stringWithFormat:@"%@注册失败",delegate.manager.myJID.user];
        }
            break;
            
        default:
            break;
    }
    self.textView.text=msg;
}

/**
 *  接收消息
 *  @param delegate 代理对象
 *  @param message 消息
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate message:(XMPPMessage*)message info:(NSDictionary*)info{
    self.textView.text=message.body;
}

/**
 *  发送状态
 *  @param delegate 代理对象
 *  @param message 消息
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate sendStatus:(TXKomlinIMSendStatus)sendStatus message:(XMPPMessage*)message info:(NSDictionary*)info{
    NSString*msg=nil;
    switch (sendStatus) {
        case 0:
        {
            msg=@"无状态";
        }
            break;
        case 1:
        {
            msg=@"正在发送...";
        }
            break;
        case 2:
        {
            msg=@"发送成功";
        }
            break;
        case 3:
        {
            msg=@"发送失败";
        }
            break;
            
        default:
            break;
    }
    self.textView.text=[NSString stringWithFormat:@"%@%@",message.body,msg];
}

/**
 *  意外断开连接
 *  @param delegate 代理对象
 *  @param unexpectedDisconnectStatus 状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate unexpectedDisconnectStatus:(NSInteger)unexpectedDisconnectStatus info:(NSDictionary*)info{
}

/**
 *  自动连接
 *  @param delegate 代理对象
 *  @param autoConnectStatus 状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate autoConnectStatus:(NSInteger)autoConnectStatus info:(NSDictionary*)info{
}

/**
 *  心跳
 *  @param delegate 代理对象
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate heartbeat:(NSDictionary*)info{
}

/**
 *  超时心跳
 *  @param delegate 代理对象
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate timeoutHeartbeat:(NSDictionary*)info{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
