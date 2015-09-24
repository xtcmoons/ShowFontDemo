//
//  SetupFontViewController.m
//  ShowFontDemo
//
//  Created by 陈明 on 9/24/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import "SetupFontViewController.h"
#import "StorageFont.h"
#import "UIColor+Hex.h"


@interface SetupFontViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *colorText;
@property (weak, nonatomic) IBOutlet UIButton *isCollectionBtn;

@end

@implementation SetupFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.fontName;
    self.label.font = [UIFont fontWithName:self.fontName size:20];
    
    [self.isCollectionBtn addTarget:self action:@selector(collectionFontName:) forControlEvents:UIControlEventTouchUpInside];
    
    [self p_setupCollectionBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_setupCollectionBtn {
    StorageFont *storageFont = [StorageFont sharedInstanceStorageFont];
    NSMutableArray *array = storageFont.fontNames;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = (NSString *)obj;
        if ([string isEqualToString:self.fontName]) {
            self.isCollectionBtn.selected = YES;
            
            *stop = YES;
        }
        
    }];
}


#pragma mark - UITextFieldDelegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.label.textColor = [UIColor colorWithHexString:textField.text];
    
    [textField endEditing:YES];
    
    return YES;
}


- (void)collectionFontName:(UIButton *)sender {
    
    StorageFont *storageFont = [StorageFont sharedInstanceStorageFont];
    
    if (sender.selected) {
        [storageFont cancelFontName:self.fontName];
        sender.selected = NO;
    } else {
        [storageFont saveFontName:self.fontName];
        sender.selected = YES;
    }
    
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
