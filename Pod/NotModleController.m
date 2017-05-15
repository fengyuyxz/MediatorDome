//
//  NotModleController.m
//  MediatorDome
//
//  Created by yanxuezhou on 2017/5/12.
//  Copyright © 2017年 yanxuezhou. All rights reserved.
//

#import "NotModleController.h"

@interface NotModleController ()

@end

@implementation NotModleController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, 50)];
    [self.view addSubview:lable];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=@"改模块暂未实现敬请期待";
    self.view.backgroundColor=[UIColor whiteColor];
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
