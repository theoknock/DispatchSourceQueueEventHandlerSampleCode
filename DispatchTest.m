//
//  DispatchTest.m
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/30/21.
//

#import "DispatchTest.h"
//#import "GlobalDispatchSourceQueue.h"
//#import "DispatchSourceEventHandler.h"
//#import "DispatchSourceObject.h"

static int (^generateRandomInt)(void) = ^int(void) {
    int random_int = arc4random_uniform((uint)time(0));
    //    NSLog(@"random_int = %d", random_int);
    return random_int;
};

typedef struct DispatchSourceObjectInt
{
    int rnd_int;
} DispatchSourceObjectInt;

static DispatchSourceObjectInt * (^randomInt)(void) = ^DispatchSourceObjectInt *(void) {
    struct DispatchSourceObjectInt * dispatch_source_object_int_ptr = malloc(sizeof(struct DispatchSourceObjectInt));
    dispatch_source_object_int_ptr->rnd_int = generateRandomInt();
    return dispatch_source_object_int_ptr;
};


@implementation DispatchTest
{
    NSUInteger event_index;
}

static DispatchTest * sharedDispatchTest = NULL;
+ (nonnull DispatchTest *)sharedDispatchTest
{
    if (!sharedDispatchTest)
    {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        sharedDispatchTest = [[self alloc] init];
        
        //        [DispatchSourceEventHandler dispatchSourceEventHandler];
    }
    
    return sharedDispatchTest;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        //        [GlobalDispatchSourceQueue globalDispatchSourceQueue];
        event_index = -1;
        [self textureQueue];
        [self textureQueueEvent];
    }
    
    return self;
}


- (void)testDispatch
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //    dispatch_source_set_event_handler([[GlobalDispatchSourceQueue globalDispatchSourceQueue] global_dispatch_source], self->_textureQueueEvent); /*^{
    //                printf("HANDLER\t%s", __PRETTY_FUNCTION__);
    //
    //                NSInteger index = dispatch_source_get_data([[GlobalDispatchSourceQueue globalDispatchSourceQueue] global_dispatch_source]);
    //                struct DispatchSourceObjectInt * random_integer_struct = (struct DispatchSourceObjectInt *)dispatch_queue_get_specific([self global_dispatch_queue],
    //                                                                                                          [[NSString stringWithFormat:@"%lu", index]
    //                                                                                                           cStringUsingEncoding:NSUTF8StringEncoding]);
    //
    //                NSLog(@"Random integer = %ld, %d", (long)index, random_integer_struct->rnd_int);
    //            });
    //    dispatch_set_target_queue([[GlobalDispatchSourceQueue globalDispatchSourceQueue] global_dispatch_source], [self global_dispatch_queue]);
    //    dispatch_resume([[GlobalDispatchSourceQueue globalDispatchSourceQueue] global_dispatch_source]);
    
    //    dispatch_async([self global_dispatch_queue], ^{
    //        struct DispatchSourceObjectInt * dispatch_source_object_int_ptr_1 = malloc(sizeof(struct DispatchSourceObjectInt));
    //        dispatch_source_object_int_ptr_1->rnd_int = 1;//generateRandomInt();
    //
    //        NSInteger index = event_index++;
    //        //    dispatch_async(GlobalDispatchSourceQueue.global_dispatch_queue, ^{
    //        const char *label = [[NSString stringWithFormat:@"%ld", (long)index] cStringUsingEncoding:NSUTF8StringEncoding];
    //        dispatch_queue_set_specific(self->_global_dispatch_queue, label, dispatch_source_object_int_ptr_1, NULL);
    //        dispatch_source_merge_data(self->_textureQueueEvent, (long)index);
    //    });
    //        dispatch_set_context([self textureQueueEvent], &dispatch_source_object_int_ptr_1);
    //    });
    
    //    dispatch_queue_set_specific(GlobalDispatchSourceQueue.global_dispatch_queue, &dispatch_source_object_int_ptr_1, (void*)dispatch_source_object_int_ptr_1, DISPATCH_DATA_DESTRUCTOR_DEFAULT);
    //    dispatch_set_context(GlobalDispatchSourceQueue.global_dispatch_source, &dispatch_source_object_int_ptr_1);
    //    dispatch_source_merge_data(GlobalDispatchSourceQueue.global_dispatch_source, 1);
    
    //    struct DispatchSourceObjectInt * dispatch_source_object_int_ptr_2 = malloc(sizeof(struct DispatchSourceObjectInt));
    //    dispatch_source_object_int_ptr_2->rnd_int = 2;//generateRandomInt();
    //    dispatch_queue_set_specific(GlobalDispatchSourceQueue.global_dispatch_queue, &dispatch_source_object_int_ptr_2, (void*)dispatch_source_object_int_ptr_2, DISPATCH_DATA_DESTRUCTOR_DEFAULT);
    ////    dispatch_set_context(GlobalDispatchSourceQueue.global_dispatch_source, &dispatch_source_object_int_ptr_2);
    //    dispatch_source_merge_data(GlobalDispatchSourceQueue.global_dispatch_source, 2);
    
}

//static dispatch_queue_t global_dispatch_queue = NULL;
//- (nonnull dispatch_queue_t)global_dispatch_queue
//{
//    if (!global_dispatch_queue)
//    {
//        NSLog(@"%s", __PRETTY_FUNCTION__);
//        global_dispatch_queue = dispatch_queue_create_with_target("Concurrent Dispatch Queue", DISPATCH_QUEUE_CONCURRENT, dispatch_get_main_queue());
//    }
//    
//    return global_dispatch_queue;
//}

- (dispatch_queue_t)textureQueue
{
    __block dispatch_queue_t q = self->_textureQueue;
    if (!q)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            q = dispatch_queue_create_with_target("_textureQueue", DISPATCH_QUEUE_CONCURRENT, dispatch_get_main_queue());
            self->_textureQueue = q;
        });
    }
    
    return q;
}

- (dispatch_source_t)textureQueueEvent
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    dispatch_queue_t dispatch_queue = self->_textureQueue;
    dispatch_source_t dispatch_source = self->_textureQueueEvent;
    if (!dispatch_source)
    {
        dispatch_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_queue);
        dispatch_source_set_event_handler(dispatch_source, ^{
            dispatch_async(dispatch_queue, ^{
                NSInteger index = dispatch_source_get_data(dispatch_source);
                struct DispatchSourceObjectInt * random_integer_struct = (struct DispatchSourceObjectInt *)dispatch_queue_get_specific(dispatch_queue,
                                                                                                                                       [[NSString stringWithFormat:@"%lu", index]
                                                                                                                                        cStringUsingEncoding:NSUTF8StringEncoding]);
                
                NSLog(@"index = %ld\t\tRandom integer = %d", (long)index, random_integer_struct->rnd_int);
            });
        });
        dispatch_set_target_queue(dispatch_source, dispatch_queue);
        
        
        self->_textureQueueEvent = dispatch_source;
        dispatch_resume(self->_textureQueueEvent);
        
        //        dispatch_async(dispatch_queue, ^{
        
        
    }
    
    struct DispatchSourceObjectInt * dispatch_source_object_int_ptr_1 = calloc(10, sizeof(struct DispatchSourceObjectInt));
    dispatch_source_object_int_ptr_1->rnd_int = generateRandomInt();
    
    NSInteger index = event_index++;
    NSLog(@"index = %ld\t\tRandom integer = %d", (long)index, dispatch_source_object_int_ptr_1->rnd_int);
    //    dispatch_async(GlobalDispatchSourceQueue.global_dispatch_queue, ^{
    const char *label = [[NSString stringWithFormat:@"%ld", (long)index] cStringUsingEncoding:NSUTF8StringEncoding];
    dispatch_queue_set_specific(dispatch_queue, label, dispatch_source_object_int_ptr_1, NULL);
    dispatch_source_merge_data(self->_textureQueueEvent, (long)index);
    for (int i = 0; i < 10; i++)
    {
        [self textureQueueEvent];
    }
    
    return self->_textureQueueEvent;
}


@end
