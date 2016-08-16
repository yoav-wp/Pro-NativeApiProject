//
//  CategoryVC.m
//  scrollViewTest
//
//  Created by Nir Gaiger on 8/14/16.
//  Copyright © 2016 Design Webpals. All rights reserved.
//

#import "CategoryVC.h"
#import "SWRevealViewController.h"

@interface CategoryVC ()
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.selectedItem= self.tabBar.items[1];
    // Do any additional setup after loading the view.
    self.revealViewController.rightViewRevealOverdraw=4;
    [self.revealViewController panGestureRecognizer];
    [self.revealViewController tapGestureRecognizer];
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


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 1){
        [self.revealViewController rightRevealToggle:self];
    }
    if (item.tag == 5){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"HomePageSB"];
        
        SWRevealViewControllerSeguePushController *segue = [[SWRevealViewControllerSeguePushController alloc] initWithIdentifier:@"ANY_ID" source:self destination:vc];
        [segue perform];
    }
    if (item.tag == 3){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"webviewVC"];
        
        SWRevealViewControllerSeguePushController *segue = [[SWRevealViewControllerSeguePushController alloc] initWithIdentifier:@"ANY_ID" source:self destination:vc];
        [segue perform];
        
    }
    if (item.tag == 4){
    }
}


@end