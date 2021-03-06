//
//  DispatchTest.m
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/30/21.
//

#import "DispatchTest.h"

static int (^generateRandomInt)(void) = ^int(void) {
    int random_int = arc4random_uniform((uint)time(0));
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

static DispatchTest * sharedDispatchTest = NULL;
+ (nonnull DispatchTest *)sharedDispatchTest
{
    if (!sharedDispatchTest)
    {
        sharedDispatchTest = [[self alloc] init];
    }
    
    return sharedDispatchTest;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        event_index = 1;
        dispatch_queue_t dispatch_queue =  [self textureQueue];
        dispatch_source_t dispatch_source = [self textureQueueEvent];
        
        
    }
    
    return self;
}


- (void)testDispatch
{
   dispatch_async(self->_textureQueue, ^{
        do {
            [self textureQueueEvent];
            struct DispatchSourceObjectInt * dispatch_source_object_int_ptr_1 = randomInt();
            
            NSLog(@"Setting index = %ld\t\tRandom integer = %d", self->event_index, dispatch_source_object_int_ptr_1->rnd_int);
            const char *label = [[NSString stringWithFormat:@"%ld", self->event_index] cStringUsingEncoding:NSUTF8StringEncoding];
            dispatch_queue_set_specific(self->_textureQueue, label, dispatch_source_object_int_ptr_1, NULL);
            dispatch_source_merge_data(self->_textureQueueEvent, self->event_index);
            
            self->_textureQueueEvent = nil;
            self->event_index++;
        } while (self->event_index < 11);
    });
}

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
                
                NSLog(@"Getting index = %ld\t\tRandom integer = %d", (long)index, random_integer_struct->rnd_int);
            });
        });
        dispatch_set_target_queue(dispatch_source, dispatch_queue);
        
        
        self->_textureQueueEvent = dispatch_source;
        dispatch_resume(self->_textureQueueEvent);
    }
    
    return self->_textureQueueEvent;
}


@end
