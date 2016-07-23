//
//  ParticipantsViewController.m
//  iPadToiPad
//
//  Created by gold on 8/5/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "public.h"
#import "ParticipantsViewController.h"

@interface ParticipantsViewController ()

@end

@implementation ParticipantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 30)];
    titleLbl.center = CGPointMake(self.view.frame.size.width/2, 150);
    titleLbl.text = @"Participants";
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    [titleLbl setTextColor:[UIColor blackColor]];
    titleLbl.font = [UIFont boldSystemFontOfSize:28];
    
    [self.view addSubview:titleLbl];

    
    UITableView *connectionTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2.5, self.view.height/2.5) style:UITableViewStyleGrouped];
    connectionTable.top = titleLbl.bottom + 90;
    connectionTable.center = self.view.center;
    connectionTable.delegate = self;
    connectionTable.dataSource = self;
    connectionTable.backgroundColor = [UIColor whiteColor];
    connectionTable.tableFooterView = [UIView new];
    connectionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [connectionTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"connectionTableViewCellIdentifier"];
    
    [self.view addSubview:connectionTable];

    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    backBtn.left = self.view.width/4;
    backBtn.top = connectionTable.bottom + 90;
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - TableView Delegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"connectionTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.textLabel.font = [UIFont systemFontOfSize:27];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = @"James's iPad";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger deviceIndex = indexPath.row;
    // send push notification via Parse.com
    NSLog(@"%ldth iPad is selected", (long)deviceIndex);
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
