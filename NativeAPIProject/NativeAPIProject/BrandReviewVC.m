//
//  BrandReviewVC.m
//  NativeAPIProject
//
//  Created by Nir Gaiger on 8/31/16.
//  Copyright © 2016 Domain Planet Limited. All rights reserved.
//

#import "BrandReviewVC.h"
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "CategoryVC.h"
#import "WebViewVC.h"
#import "AccordionView.h"
#import "NavigationManager.h"

@interface BrandReviewVC()

@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (weak, nonatomic) IBOutlet UIView *accordionView;
@property (weak, nonatomic) IBOutlet UIView *firstTabView;
@property (weak, nonatomic) IBOutlet UIView *secondTabView;
@property (weak, nonatomic) IBOutlet UIView *thirdTabView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accordionHeightConstraint;
@property (weak, nonatomic) IBOutlet UIWebView *secondTabWebView;


//bottom view of the third tab's view
@property (weak, nonatomic) IBOutlet UIView *thirdsBottomView;

@end


CGFloat maxAccordionHeight = 0;

@implementation BrandReviewVC{

    //will be passed to navigation manager with a tag, so we heve the tag-url relation
    NSMutableDictionary *_tags2URLs;
    NSMutableArray * accordionWVArray;
    AccordionView *accordion;
    NavigationManager *_nav;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.tabBar.selectedItem= self.tabBar.items[0];
    //for the menu
    _nav = [[NavigationManager alloc] init];
    self.revealViewController.rightViewRevealOverdraw=4;
    [self.revealViewController panGestureRecognizer];
    [self.revealViewController tapGestureRecognizer];
    [self initSegmentViews];
    [self initAccordionView];
    [self initWV];
    [self initSecondTabWebView];
    [self initSomeUI];
}

// Some general page UI
-(void)initSomeUI{
    //borders
    _thirdsBottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _thirdsBottomView.layer.borderWidth = 0.5f;
}


-(void)viewDidAppear:(BOOL)animated{
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"enter finishload for  : %ld", (long)webView.tag);
    
    //get best fitting size
    CGSize fittingSize = [webView sizeThatFits:CGSizeMake(webView.superview.frame.size.width, 1)];
    [webView.scrollView setScrollEnabled:NO];
    //init a new frame (with just another one)
    CGRect newFrame = webView.frame;
    //give the newFrame the fitting size
    newFrame.size = fittingSize;
    //set newFrame for the wv
    webView.frame = newFrame;
    NSLog(@"aaa %f",webView.frame.size.height);
}


-(void)initSegmentViews{
    _firstTabView.hidden=NO;
    _secondTabView.hidden=YES;
    _thirdTabView.hidden=YES;
}

-(void)initAccordionView{

    accordionWVArray = [NSMutableArray array];
    _accordionHeightConstraint.constant = 760;
    
    CGFloat width = self.view.frame.size.width;
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(0, 0, width, [[UIScreen mainScreen] bounds].size.height)];
    [self.accordionView addSubview:accordion];
    self.accordionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.000];
    
    int i = 1;
    for(i = 1 ; i< 4 ; i++){
        // Only height is taken into account, so other parameters are just dummy
        UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [header1 setTitle:@"Welcone Bonus" forState:UIControlStateNormal];
        header1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.000];
        [header1 setTitleColor:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:1.000] forState:UIControlStateNormal];
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 242)];
        view1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.000];
        
        [accordion addHeader:header1 withView:view1];
        view1.tag = 3*i;
        
        UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
        wv.delegate = self;
        wv.tag = i;
        [[wv scrollView] setScrollEnabled:NO];


        [view1 addSubview:wv];
        [wv loadHTMLString:@"<div>second WYSIWYG <b>this is bold</b><p>Lets <a href=\"http://www.onlinecasinos.expert/page4.js\">start</a> a new paragraph and close it</p> this is the second <i>WYSIWYG</i> for thisthe second <i>WYSIWYG</i> for this Homepage Homepage Homepage Homepage<i>WYSIWYG</i> for this Homepage Homepage HomepageHomepage Homepagthe second <i>WYSIWYG</i> for this Homepage Homepage Homepage Homepage<i>WYSIWYG</i> for this Homepage Homepage HomepageHomepage Homepagthe second <i>WYSIWYG</i> for this Homepage Homepage Homepage Homepage<i>WYSIWYG</i>page</div>" baseURL:nil];
        
        [accordionWVArray addObject:wv];
        
        //update total height for best scrolling
        maxAccordionHeight += 300;
        
    }

    [accordion setNeedsLayout];
    
    // Set this if you want to allow multiple selection
    [accordion setAllowsMultipleSelection:YES];
    
    // Set this to NO if you want to have at least one open section at all times
    [accordion setAllowsEmptySelection:YES];
}




-(void)initWV{
    NSString *s = [self.pp brandReviewGetWysiwyg];
}

-(void)initSecondTabWebView{
    NSString *s = [self.pp brandReviewGetSecondTabWysiwyg];
    [_secondTabWebView loadHTMLString:s baseURL:nil];
}

//
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGRect frame = _webview.frame;
//    frame.size.height = 1;
//    _webview.frame = frame;
//    CGSize fittingSize = [_webview sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    _webview.frame = frame;
//    _webviewHeight.constant = frame.size.height;
//}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [[request URL] absoluteString];
    NavigationManager *nav = [[NavigationManager alloc] init];
    NSLog(@"url : %@",url);
    if([url containsString:@"onlinecasinos.expert"]){
        [nav navigateWithItemID:-42 WithURL:url WithURLsDict:_tags2URLs WithSourceVC:self];
        return NO;
    }
    return YES;
}

- (IBAction)segmentValueChanged:(id)sender {
    
    CGRect frame = _thirdTabView.frame;
    CGSize fittingSize = [_thirdTabView sizeThatFits:_thirdTabView.frame.size];
    frame.size = fittingSize;
    NSLog(@"changed %ld, size : %f",(long)_segment.selectedSegmentIndex, frame.size.height);
    switch (_segment.selectedSegmentIndex) {
        case 0:
            _secondTabView.hidden=YES;
            _thirdTabView.hidden=YES;
            _firstTabView.hidden=NO;
            break;
        case 1:
            _firstTabView.hidden=YES;
            _thirdTabView.hidden=YES;
            _secondTabView.hidden=NO;
            break;
            
        case 2:
            _firstTabView.hidden=YES;
            _secondTabView.hidden=YES;
            _thirdTabView.hidden=NO;
            break;
            
        default:
            //default show 0
            break;
    }
}


//call all the widgets initializations
//better view WILL appear, did appear for debug
-(void)viewWillAppear:(BOOL)animated{
    // Do any additional setup after loading the view, typically from a nib.
    [self initTabBar];
    [self setActiveTabbarItem];
}


//Sharing
-(void)handleSharingEvent{
    // create a message
    NSString *theMessage = [self.pp fullURL];
    NSArray *items = @[@"hello", [UIImage imageNamed:@"betwaylogo"]];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
    NSLog(@"Share it !");
}
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    if ( [controller respondsToSelector:@selector(popoverPresentationController)] ) {
        // iOS8
        controller.popoverPresentationController.sourceView = self.view;
    }
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}


//menu tag: 42, homepage tag: 24
-(void)initTabBar{
    _tags2URLs = [[NSMutableDictionary alloc] init];
    NSMutableArray *tabBarArray;
    int i;
    self.tabbarElements = [self.pp getTabBarElements];
    tabBarArray = [[NSMutableArray alloc] init];
    UITabBarItem *homeItem;
    UITabBarItem *menuItem;
    UITabBarItem *shareItem;
    
    //set middle items
    //Homepage, Share and menu position in the json array doesnt matter, for the others it does.
    for(i = 0; i < self.tabbarElements.count; i++){
        NSDictionary *tabbarDict = self.tabbarElements[i];
        UITabBarItem *item;
        if([[tabbarDict valueForKey:@"id"] isEqualToString:@"share_item"]){
            shareItem = [[UITabBarItem alloc] initWithTitle:[tabbarDict valueForKey:@"button_text"] image:nil tag:84];
            [_tags2URLs setObject:[tabbarDict valueForKey:@"link"] forKey:[NSNumber numberWithInteger:84]];
            continue;
        }
        if([[tabbarDict valueForKey:@"id"] isEqualToString:@"menu_item"]){
            menuItem = [[UITabBarItem alloc] initWithTitle:[tabbarDict valueForKey:@"button_text"] image:nil tag:42];
            [_tags2URLs setObject:[tabbarDict valueForKey:@"link"] forKey:[NSNumber numberWithInteger:42]];
            continue;
        }
        if([[tabbarDict valueForKey:@"id"] isEqualToString:@"homepage_item"]){
            homeItem = [[UITabBarItem alloc] initWithTitle:[tabbarDict valueForKey:@"button_text"] image:nil tag:24];
            [_tags2URLs setObject:[tabbarDict valueForKey:@"link"] forKey:[NSNumber numberWithInteger:24]];
            continue;
        }
        
        item = [[UITabBarItem alloc] initWithTitle:[tabbarDict valueForKey:@"button_text"] image:nil tag:10+i];
        [_tags2URLs setObject:[tabbarDict valueForKey:@"link"] forKey:[NSNumber numberWithInteger:10+i]];
        [tabBarArray addObject:item];
    }
    //set menu and homepage items
    [tabBarArray insertObject:homeItem atIndex:0];
    [tabBarArray addObject:shareItem];
    [tabBarArray addObject:menuItem];
    
    //concatenating tabBarArray to (the empty) [_tabbar items]
    [_tabbar setItems:[tabBarArray arrayByAddingObjectsFromArray:[_tabbar items]]];
}
-(void)setActiveTabbarItem{
    int i = 0;
    NSArray *ar = [_tabbar items];
    for(i = 0 ; i< ar.count ; i++){
        UITabBarItem *it = ar[i];
        if(it.tag == _activeTab){
            _tabbar.selectedItem = it;
            break;
        }
    }
}
//Handle tabBar clicks
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //On homepage, homepage click does nothing
    if (item.tag == 42){
        [self.revealViewController rightRevealToggle:self];
    }
    if(item.tag == 84){
        [self handleSharingEvent];
    }
    else if(item.tag == _activeTab){
        return;
    }else{
        [_nav navigateWithItemID:item.tag WithURL:nil WithURLsDict:_tags2URLs WithSourceVC:self];
    }
}



@end
