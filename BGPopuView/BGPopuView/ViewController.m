//
//  ViewController.m
//  BGPopuView
//
//  Created by 冉彬 on 2018/10/3.
//  Copyright © 2018年 Binge. All rights reserved.
//

#import "ViewController.h"
#import "BGPopupView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    [btn setTitle:@"点击弹框" forState:0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)btnAction
{
    int typeNum = arc4random()%10;
//    [BGPopupView showCenterView:self.popView animationType:typeNum];
    
    [BGPopupView showView:self.popView frame:CGRectMake(50, 300, 200, 200) bgAlpa:0.1 animationType:typeNum hiddenBlock:^{
        NSLog(@"消失");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Get
-(UIView *)popView
{
    if (!_popView)
    {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
        _popView.backgroundColor = [UIColor greenColor];
        
    }
    
    return _popView;
}



@end
