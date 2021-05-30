//
//  GlobalDispatchSourceQueue.m
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/14/21.
//

#import "GlobalDispatchSourceQueue.h"

@implementation GlobalDispatchSourceQueue

static GlobalDispatchSourceQueue * globalDispatchSourceQueue = NULL;
+ (nonnull GlobalDispatchSourceQueue *)globalDispatchSourceQueue
{
        if (!globalDispatchSourceQueue)
        {
            NSLog(@"%s", __PRETTY_FUNCTION__);
            globalDispatchSourceQueue = [[self alloc] init];
        }
    
    return globalDispatchSourceQueue;
}

static dispatch_queue_t global_dispatch_queue = NULL;
- (nonnull dispatch_queue_t)global_dispatch_queue
{
        if (!global_dispatch_queue)
        {
            NSLog(@"%s", __PRETTY_FUNCTION__);
            global_dispatch_queue = dispatch_queue_create_with_target("Concurrent Dispatch Queue", DISPATCH_QUEUE_CONCURRENT, dispatch_get_main_queue());
        }
    
    return global_dispatch_queue;
}

static dispatch_source_t global_dispatch_source = NULL;
- (nonnull dispatch_source_t)global_dispatch_source
{
        if (!global_dispatch_source)
        {
            NSLog(@"%s", __PRETTY_FUNCTION__);
            global_dispatch_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, global_dispatch_queue);
            
        }
    
    return global_dispatch_source;
}


- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    
    return self;
}


@end
