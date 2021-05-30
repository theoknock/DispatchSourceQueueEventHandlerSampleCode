//
//  DispatchSourceEventHandler.m
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/14/21.
//

#import "DispatchSourceEventHandler.h"
#import "GlobalDispatchSourceQueue.h"

#import "DispatchSourceObject.h"

@implementation DispatchSourceEventHandler

static DispatchSourceEventHandler * dispatchSourceEventHandler = NULL;
+ (nonnull DispatchSourceEventHandler *)dispatchSourceEventHandler
{
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^{
        if (!dispatchSourceEventHandler)
        {
            NSLog(@"%s", __PRETTY_FUNCTION__);
            dispatchSourceEventHandler = [[self alloc] init];
        }
    });
    
    return dispatchSourceEventHandler;
}


- (instancetype)init
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [super init];
    if (self) {
//        dispatch_source_set_event_handler(GlobalDispatchSourceQueue.globalDispatchSourceQueue.global_dispatch_source, ^{
//            struct DispatchSourceObjectFloat * dispatch_source_object_float_ptr = dispatch_get_context(GlobalDispatchSourceQueue.globalDispatchSourceQueue.global_dispatch_source);
//            NSLog(@"Random float = %f", dispatch_source_object_float_ptr->flt_num);
//            free(dispatch_source_object_float_ptr);
//        });
//        
//        dispatch_resume(GlobalDispatchSourceQueue.globalDispatchSourceQueue.global_dispatch_source);
    }
    return self;
}

@end
