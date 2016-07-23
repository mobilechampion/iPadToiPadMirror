//
//  ViewController.m
//  iPadToiPad
//
//  Created by gold on 8/5/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "public.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "AvailableSessionViewController.h"
#import "ParticipantsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *joinSession_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width/4, 30)];
    joinSession_btn.center = CGPointMake(self.view.width/2, self.view.height/3);
    [joinSession_btn setTitle:@"Join Session" forState:UIControlStateNormal];
    [joinSession_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    joinSession_btn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [joinSession_btn addTarget:self action:@selector(joinSession:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinSession_btn];
    
    
    UIButton *newSession_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width/4, 30)];
    newSession_btn.center = CGPointMake(self.view.width/2, joinSession_btn.bottom+ 80);
    [newSession_btn setTitle:@"New Session" forState:UIControlStateNormal];
    [newSession_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newSession_btn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [newSession_btn addTarget:self action:@selector(newSession:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newSession_btn];
    
    
    UIButton *exit_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, newSession_btn.width/3, 30)];
    exit_btn.center = CGPointMake(self.view.width/2, newSession_btn.bottom + 180);
    [exit_btn setTitle:@"Exit" forState:UIControlStateNormal];
    [exit_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exit_btn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [exit_btn addTarget:self action:@selector(exitSession:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit_btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinSession:(id)sender{
    NSLog(@"enter join session");
    AvailableSessionViewController *availableListVC = [[AvailableSessionViewController alloc]init];
    [self.navigationController pushViewController:availableListVC animated:YES];
}

- (IBAction)newSession:(id)sender {
    NSLog(@"enter new session");
    ParticipantsViewController *participantVC = [[ParticipantsViewController alloc]init];
    [self.navigationController pushViewController:participantVC animated:YES];
}

- (IBAction)exitSession:(id)sender{
    exit(0);
}

@end
