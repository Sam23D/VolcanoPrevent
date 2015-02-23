//
//  SecondViewController.m
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import "SecondViewController.h"
#import "plan.h"
#import "during.h"
#import "After.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    guide = [[NSMutableArray alloc] init];
    [guide addObject:@"Plan for a volcano"];
    [guide addObject:@"During a volcano"];
    [guide addObject:@"After a volcano"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [guide count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    //Customize cell
    cell.textLabel.text = [guide objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    number = indexPath.row;
    
    if (number == 0) {
        plan *controller = (plan *) [self.storyboard instantiateViewControllerWithIdentifier:@"planvc"];
        
        [self presentViewController:controller animated:YES completion:nil];
    } else if (number == 1){
        during *controller = (during *) [self.storyboard instantiateViewControllerWithIdentifier:@"duringvc"];
        
        [self presentViewController:controller animated:YES completion:nil];
    } else if (number == 2){
        After *controller = (After *) [self.storyboard instantiateViewControllerWithIdentifier:@"aftervc"];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}

@end
