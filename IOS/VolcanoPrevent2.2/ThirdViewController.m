//
//  ThirdViewController.m
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    news = [[NSMutableArray alloc] init];
    icon = [[NSMutableArray alloc] init];
    help = [UIImage imageNamed:@"help.png"];
    warning = [UIImage imageNamed:@"warning.png"];
    info = [UIImage imageNamed:@"info.png"];

}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [news count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if ([[icon objectAtIndex:indexPath.row]  isEqual: @"help"]) {
        cell.imageView.image = help;
    } else if ([[icon objectAtIndex:indexPath.row]  isEqual: @"warning"]){
        cell.imageView.image = warning;
    } else if ([[icon objectAtIndex:indexPath.row]  isEqual: @"info"]){
        cell.imageView.image = info;
    }
    
    //Customize cell
    cell.textLabel.text = [news objectAtIndex:indexPath.row];
    
    return cell;
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
