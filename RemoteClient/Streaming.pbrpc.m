#import "Streaming.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation STMRepository

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"streaming" serviceName:@"Repository"]);
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}


#pragma mark store(stream Item) returns (StoreReply)

/**
 * client-side streaming RPC
 */
- (void)storeWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCTostoreWithRequestsWriter:requestWriter handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * client-side streaming RPC
 */
- (GRPCProtoCall *)RPCTostoreWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"store"
            requestsWriter:requestWriter
             responseClass:[STMStoreReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark fetch(FetchRequest) returns (stream Item)

/**
 * server-side streaming RPC
 */
- (void)fetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCTofetchWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * server-side streaming RPC
 */
- (GRPCProtoCall *)RPCTofetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"fetch"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[STMItem class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
#pragma mark storeAndFetch(stream Item) returns (stream Item)

/**
 * bidirectional streaming RPC
 */
- (void)storeAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCTostoreAndFetchWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * bidirectional streaming RPC
 */
- (GRPCProtoCall *)RPCTostoreAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"storeAndFetch"
            requestsWriter:requestWriter
             responseClass:[STMItem class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
@end
