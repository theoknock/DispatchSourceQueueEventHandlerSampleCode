//
//  DispatchTest.h
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/30/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DispatchTest : NSObject
{
    __block long event_index;
}

+ (nonnull DispatchTest *)sharedDispatchTest;
- (void)testDispatch;

@property (strong, nonatomic) __block dispatch_queue_t textureQueue;
@property (strong, nonatomic) __block dispatch_source_t textureQueueEvent;

@property (nonatomic, strong) __block dispatch_queue_t global_dispatch_queue;


@end

NS_ASSUME_NONNULL_END
