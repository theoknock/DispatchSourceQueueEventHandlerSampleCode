//
//  GlobalDispatchSourceQueue.h
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/14/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define AppServices ((AppDelegate *)[[UIApplication sharedApplication] delegate])


typedef struct GlobalDispatchSourceQueueContextData {
    float data;
} GlobalDispatchSourceQueueContextData;

@interface GlobalDispatchSourceQueue : NSObject

+ (nonnull GlobalDispatchSourceQueue *)globalDispatchSourceQueue;
@property (nonatomic, strong) __block dispatch_queue_t global_dispatch_queue;
@property (nonatomic, strong) __block dispatch_source_t global_dispatch_source;
//@property (strong, nonatomic) dispatch_queue_t   global_dispatch_queue;
//@property (strong, nonatomic) dispatch_source_t  global_dispatch_source;

@end

NS_ASSUME_NONNULL_END
