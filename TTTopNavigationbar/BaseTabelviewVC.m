//
//  BaseTabelviewVC.m
//  TTTopNavigationbar
//
//  Created by TT_code on 16/4/22.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "BaseTabelviewVC.h"

@interface BaseTabelviewVC ()

@end

@implementation BaseTabelviewVC
static NSString* idetifier=@"mycll";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idetifier];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
    cell.textLabel.text=[NSString stringWithFormat:@"%@---%ld",self.title,indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



@end
