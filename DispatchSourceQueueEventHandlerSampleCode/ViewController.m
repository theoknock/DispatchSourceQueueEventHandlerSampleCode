//
//  ViewController.m
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/14/21.
//

#import "ViewController.h"
#import "GlobalDispatchSourceQueue.h"
#import "DispatchSourceEventHandler.h"
#import "DispatchSourceObject.h"

#import "DispatchTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [DispatchTest.sharedDispatchTest testDispatch];
}


@end
