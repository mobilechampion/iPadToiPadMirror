//
//  DisconnectConfirmViewController.m
//  iPadToiPad
//
//  Created by gold on 8/5/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "public.h"
#import "DisconnectConfirmViewController.h"

@interface DisconnectConfirmViewController ()

@end

@implementation DisconnectConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width/3, 30)];
    titleLbl.center = CGPointMake(self.view.width/2, 150);
    titleLbl.text = @"iPad to iPad Beta";
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    [titleLbl setTextColor:[UIColor blackColor]];
    titleLbl.font = [UIFont boldSystemFontOfSize:28];
    
    [self.view addSubview:titleLbl];
    
    
    UILabel *confirmLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLbl.bottom + 300, self.view.width/2, 30)];
    confirmLbl.center = self.view.center;
    confirmLbl.text = @"Are you sure you want to disconnect?";
    [confirmLbl setTextAlignment:NSTextAlignmentCenter];
    [confirmLbl setTextColor:[UIColor blackColor]];
    confirmLbl.font = [UIFont boldSystemFontOfSize:27];
    
    [self.view addSubview:confirmLbl];

    
    UIButton *yesBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    yesBtn.right = self.view.center.x - 50;
    yesBtn.top = confirmLbl.bottom + 90;
    [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
    [yesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    yesBtn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [yesBtn addTarget:self action:@selector(yesClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:yesBtn];
    
    
    UIButton *noBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    noBtn.left = self.view.center.x + 50;
    noBtn.top = yesBtn.top;
    [noBtn setTitle:@"No" forState:UIControlStateNormal];
    [noBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    noBtn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [noBtn addTarget:self action:@selector(noClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:noBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yesClick:(id)sender{
    //do release all buletooth controls
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)noClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
