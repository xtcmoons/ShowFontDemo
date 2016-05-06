//
//  ViewController.m
//  ShowFontDemo
//
//  Created by 陈明 on 9/23/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import "ViewController.h"
#import "SetupFontViewController.h"
#import "collectionViewController.h"

#define kSearchBarHeight 44

@interface ViewController () <UISearchBarDelegate, UISearchDisplayDelegate> {
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDisplayController;
    BOOL _isSearching;
}

@property (nonatomic, strong) NSMutableArray<NSString *> *fontNames;
@property (nonatomic, strong) NSMutableArray<NSString *> *searchConforms;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectionViewController:)]];
    
    self.fontNames = [NSMutableArray array];
    NSArray *fontFamilyNames = [UIFont familyNames];
    for (NSString *string in fontFamilyNames) {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:string];
        [self.fontNames addObjectsFromArray:fontNames];
    }
    
    self.title = [NSString stringWithFormat:@"字体总数——%ld", self.fontNames.count];
    
    [self addSearchBar];
}

- (void)collectionViewController:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    collectionViewController *collectVc = [storyboard instantiateViewControllerWithIdentifier:@"collectionViewController"];
    [self.navigationController pushViewController:collectVc animated:YES];
}

#pragma mark - Add SearchBar
- (void)addSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar sizeToFit];
    _searchBar.placeholder = @"输入要查询的字体名字";
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    [_searchDisplayController setActive:NO animated:YES];
    
    
}

#pragma mark - UISearchDisplayController

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([_searchBar.text isEqualToString:@""]) {
        _isSearching = NO;
        [self.tableView reloadData];
        
        return;
    }
    
    [self p_searchDataWithKeyWord:_searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _isSearching = NO;
    _searchBar.text = @"";
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self p_searchDataWithKeyWord:_searchBar.text];
    [_searchBar resignFirstResponder];
}


#pragma mark - Private Method
- (void)p_searchDataWithKeyWord:(NSString *)keyword {
    _isSearching = YES;
    self.searchConforms = [NSMutableArray array];
    [self.fontNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.uppercaseString containsString:keyword] || [obj.lowercaseString containsString:keyword]) {
            [self.searchConforms addObject:obj];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.destinationViewController isKindOfClass:[SetupFontViewController class]]) {
//        SetupFontViewController *Vc = segue.destinationViewController;
//        Vc.fontName = [];
//    }
// 
//}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isSearching) {
        return self.searchConforms.count;
    }
    return self.fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellid];
    }
    
    NSString *fontName = self.fontNames[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:20];
    
    cell.textLabel.text = @"中文字体, Hello world 123456789";
    cell.detailTextLabel.text = fontName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SetupFontViewController *setupVC = [storyboard instantiateViewControllerWithIdentifier:@"SetupFontViewController"];
    
    setupVC.fontName = self.fontNames[indexPath.row];
    
    [self.navigationController pushViewController:setupVC animated:YES];
}



@end
