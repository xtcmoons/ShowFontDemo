//
//  SetupFontViewController.m
//  ShowFontDemo
//
//  Created by 陈明 on 9/24/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import "SetupFontViewController.h"

@interface SetupFontViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SetupFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nameLabel.text = self.fontName;
    self.label.font = [UIFont fontWithName:self.fontName size:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setupFontSizeAction:(UISlider *)sender {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@__%.0f", self.fontName, sender.value];
    self.label.font = [UIFont fontWithName:self.fontName size:sender.value];
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
