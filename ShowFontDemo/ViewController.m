//
//  ViewController.m
//  ShowFontDemo
//
//  Created by 陈明 on 9/23/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *failyName = [[UIFont familyNames] objectAtIndex:section];
    return [[UIFont fontNamesForFamilyName:failyName] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellid];
    }
    
    NSString *failyName = [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    NSString *fontName = [[UIFont fontNamesForFamilyName:failyName] objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:20];
    
    cell.textLabel.text = @"中文字体显示模版，效果";
    cell.detailTextLabel.text = fontName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



@end
