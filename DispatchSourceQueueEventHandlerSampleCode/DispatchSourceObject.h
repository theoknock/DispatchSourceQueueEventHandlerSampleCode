//
//  DispatchSourceObjects.h
//  DispatchSourceQueueEventHandlerSampleCode
//
//  Created by Xcode Developer on 5/16/21.
//

#ifndef DispatchSourceObject_h
#define DispatchSourceObject_h

extern const void * DispatchSourceObject;

static const void * key_1;
static const void * key_2;
static const void * key_3;

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


#endif /* DispatchSourceObjects_h */
