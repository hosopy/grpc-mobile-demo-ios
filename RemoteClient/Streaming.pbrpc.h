#import "Streaming.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>



NS_ASSUME_NONNULL_BEGIN

@protocol STMRepository <NSObject>

#pragma mark store(stream Item) returns (StoreReply)

/**
 * client-side streaming RPC
 */
- (void)storeWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler;

/**
 * client-side streaming RPC
 */
- (GRPCProtoCall *)RPCTostoreWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark fetch(FetchRequest) returns (stream Item)

/**
 * server-side streaming RPC
 */
- (void)fetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * server-side streaming RPC
 */
- (GRPCProtoCall *)RPCTofetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark storeAndFetch(stream Item) returns (stream Item)

/**
 * bidirectional streaming RPC
 */
- (void)storeAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * bidirectional streaming RPC
 */
- (GRPCProtoCall *)RPCTostoreAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface STMRepository : GRPCProtoService<STMRepository>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
