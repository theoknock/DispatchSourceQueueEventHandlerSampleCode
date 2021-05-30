//
//  ViewController.h
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/14/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) dispatch_queue_t   global_dispatch_queue;
@property (strong, nonatomic) dispatch_source_t  global_dispatch_source;


@end

