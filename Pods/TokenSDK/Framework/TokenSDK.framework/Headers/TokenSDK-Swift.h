// Generated by Apple Swift version 5.1.2 (swiftlang-1100.0.278 clang-1100.0.33.9)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="TokenSDK",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif




SWIFT_CLASS("_TtC8TokenSDK12TKResultData")
@interface TKResultData : NSObject
@property (nonatomic) BOOL success;
@property (nonatomic, copy) NSString * _Nonnull message;
@property (nonatomic) id _Nullable data;
@property (nonatomic) NSInteger code;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8TokenSDK8TokenApi")
@interface TokenApi : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end





@class TokenGoodsModel;

@interface TokenApi (SWIFT_EXTENSION(TokenSDK))
/// <ul>
///   <li>
///     发货
///   </li>
/// </ul>
/// \param data 发货数据
///
/// \param handler 回调返回data
///
+ (void)deliveryGoodsWithData:(TokenGoodsModel * _Nonnull)data handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     确认收货
///   </li>
/// </ul>
/// \param did did
///
/// \param certId 存证ID
///
/// \param toDid 转给下一个人，空自己收货
///
/// \param handler 回调返回data
///
+ (void)receiptGoodsWithDid:(NSString * _Nonnull)did certId:(NSString * _Nonnull)certId toDid:(NSString * _Nullable)toDid toName:(NSString * _Nullable)toName handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     货物记录
///   </li>
/// </ul>
/// \param did did
///
/// \param handler 回调返回data
///
+ (void)getGoodsHistoryWithDid:(NSString * _Nonnull)did handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
@end




@interface TokenApi (SWIFT_EXTENSION(TokenSDK))
/// <ul>
///   <li>
///     初始化,获取备份数据,解密
///   </li>
/// </ul>
/// \param did did,
///
/// \param phone 手机号
///
/// \param code 验证码
///
/// \param password 密码
///
/// \param handler 回调返回success:true,false ,error:错误信息
///
+ (void)initSDKWithDid:(NSString * _Nonnull)did phone:(NSString * _Nonnull)phone code:(NSString * _Nonnull)code password:(NSString * _Nonnull)password handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler SWIFT_METHOD_FAMILY(none);
/// <ul>
///   <li>
///     创建did ,创建成功,会初始化SDK
///   </li>
/// </ul>
/// \param password 密码
///
/// \param phone 手机号
///
/// \param code 验证码
///
/// \param handler 回调返回did
///
+ (void)createUserDidWithPassword:(NSString * _Nonnull)password code:(NSString * _Nonnull)code phone:(NSString * _Nonnull)phone handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     验证手机绑定的did是否可用
///   </li>
/// </ul>
/// \param phone 手机号
///
/// \param code 验证码
///
/// \param handler (code,message,did) code=3=提示错误,  code=1=did可用， code=2=不可用去注册did
///
+ (void)availableDidWithPhone:(NSString * _Nonnull)phone code:(NSString * _Nonnull)code handler:(void (^ _Nonnull)(NSInteger, NSString * _Nullable, NSString * _Nullable))handler;
/// <ul>
///   <li>
///     验证密码,必须先初始化SDK
///   </li>
/// </ul>
/// \param password password
///
///
/// returns:
/// true,false
+ (void)availablePasswordWithDid:(NSString * _Nonnull)did password:(NSString * _Nonnull)password handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     修改密码
///   </li>
/// </ul>
/// \param did did
///
/// \param password 原密码
///
/// \param newPassword 新密码
///
+ (void)updatePasswordWithDid:(NSString * _Nonnull)did password:(NSString * _Nonnull)password newPassword:(NSString * _Nonnull)newPassword handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     对外备份数据
///   </li>
/// </ul>
/// \param did did
///
/// \param dataId 数据ID
///
/// \param dataType 数据类型
///
+ (void)token_backup_dataWithDid:(NSString * _Nonnull)did dataId:(NSString * _Nonnull)dataId dataType:(NSString * _Nonnull)dataType data:(NSString * _Nonnull)data handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     对外获取备份数据
///   </li>
/// </ul>
/// \param did did
///
+ (void)token_get_backup_dataWithDid:(NSString * _Nonnull)did dataId:(NSString * _Nonnull)dataId dataType:(NSString * _Nonnull)dataType handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
@end



@class UIImage;

@interface TokenApi (SWIFT_EXTENSION(TokenSDK))
/// <ul>
///   <li>
///     获取解密密码节点
///   </li>
/// </ul>
/// \param did did
///
/// \param handler 回调返回data
///
+ (void)getDecryptPasswordServiceNodeWithDid:(NSString * _Nonnull)did handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     解密用户数据数据
///   </li>
/// </ul>
/// \param did did
///
/// \param phone 手机号
///
/// \param code 验证码
///
/// \param handler 回调返回data
///
+ (void)decryptPasswordWithDid:(NSString * _Nonnull)did phone:(NSString * _Nonnull)phone code:(NSString * _Nonnull)code param:(NSDictionary<NSString *, id> * _Nonnull)param handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     发送验证码
///   </li>
/// </ul>
/// \param phone 手机号
///
/// \param handler 回调返回
///
+ (void)sendCodeWithPhone:(NSString * _Nonnull)phone handler:(void (^ _Nonnull)(BOOL, NSString * _Nullable))handler;
+ (void)sendServiceCodeWithService:(NSString * _Nullable)service phone:(NSString * _Nonnull)phone handler:(void (^ _Nonnull)(BOOL, NSString * _Nullable))handler;
/// <ul>
///   <li>
///     获取公函模版
///   </li>
/// </ul>
/// \param userName 姓名
///
/// \param userIdentityCode 身份证
///
/// \param handler 回调返回image
///
+ (void)letterTemplateWithDid:(NSString * _Nonnull)did orgName:(NSString * _Nonnull)orgName userIdentityCode:(NSString * _Nonnull)userIdentityCode userName:(NSString * _Nonnull)userName handler:(void (^ _Nonnull)(UIImage * _Nullable))handler;
/// <ul>
///   <li>
///     上传图片
///   </li>
/// </ul>
/// \param did did
///
/// \param file 图
///
/// \param handler 回调返回id
///
+ (void)uploadfileWithDpk:(NSString * _Nullable)dpk file:(NSData * _Nonnull)file did:(NSString * _Nonnull)did targetDid:(NSString * _Nonnull)targetDid handler:(void (^ _Nonnull)(NSString * _Nullable))handler;
/// <ul>
///   <li>
///     获取实名备份信息
///   </li>
/// </ul>
/// \param did did
///
/// \param handler 回调返回info, code: 0=失败，1=成功，2=不存在备份
///
+ (void)getUserAuthInfoWithDid:(NSString * _Nonnull)did handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     实名认证
///   </li>
/// </ul>
/// \param name 姓名
///
/// \param identityCode 身份证
///
/// \param handler 回调返回hash
///
+ (void)authUserWithDid:(NSString * _Nonnull)did name:(NSString * _Nonnull)name identityCode:(NSString * _Nonnull)identityCode identityFontImg:(UIImage * _Nonnull)identityFontImg identityBackImg:(UIImage * _Nonnull)identityBackImg identityHandImg:(UIImage * _Nonnull)identityHandImg handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     公司认证
///   </li>
/// </ul>
/// \param companyName 公司名称
///
/// \param creditCode 信用代码
///
/// \param handler 回调返回hash
///
+ (void)authCompanyWithDid:(NSString * _Nonnull)did companyName:(NSString * _Nonnull)companyName creditCode:(NSString * _Nullable)creditCode name:(NSString * _Nonnull)name identityCode:(NSString * _Nonnull)identityCode licenseImg:(UIImage * _Nonnull)licenseImg isOrg:(BOOL)isOrg handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     是否实名认证
///   </li>
/// </ul>
/// \param did 用户did
///
///
/// returns:
/// true,false
+ (void)isUserAuthenticationWithDid:(NSString * _Nonnull)did handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
/// <ul>
///   <li>
///     是否公司认证
///   </li>
/// </ul>
/// \param did 公司did
///
///
/// returns:
/// true,false
+ (void)isCompanyAuthenticationWithDid:(NSString * _Nonnull)did handler:(void (^ _Nonnull)(TKResultData * _Nonnull))handler;
@end


SWIFT_CLASS("_TtC8TokenSDK20TokenCertificateItem")
@interface TokenCertificateItem : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8TokenSDK27TokenCertificateconfirmItem")
@interface TokenCertificateconfirmItem : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8TokenSDK14TokenStoreItem")
@interface TokenStoreItem : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8TokenSDK21TokenDidInfoStoreItem")
@interface TokenDidInfoStoreItem : TokenStoreItem
@end


SWIFT_CLASS("_TtC8TokenSDK19TokenSignatureModel")
@interface TokenSignatureModel : NSObject
@property (nonatomic, copy) NSString * _Nullable did;
@property (nonatomic, copy) NSString * _Nullable timestamp;
@property (nonatomic, copy) NSString * _Nullable address;
@property (nonatomic, copy) NSString * _Nullable from;
@property (nonatomic, copy) NSString * _Nullable to;
@property (nonatomic, copy) NSString * _Nullable data;
@property (nonatomic, copy) NSString * _Nullable sign;
@property (nonatomic, copy) NSString * _Nullable txHash;
@property (nonatomic) BOOL confirmed;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8TokenSDK14TokenGoodsItem")
@interface TokenGoodsItem : TokenSignatureModel
@property (nonatomic, copy) NSString * _Nullable sellerName;
@property (nonatomic, copy) NSString * _Nullable buyerName;
@property (nonatomic, copy) NSString * _Nullable buyerDID;
@property (nonatomic, copy) NSString * _Nullable commodityName;
@property (nonatomic) NSInteger commodityCount;
@property (nonatomic) NSInteger state;
- (NSDictionary<NSString *, id> * _Nonnull)to_dict SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC8TokenSDK15TokenGoodsModel")
@interface TokenGoodsModel : TokenCertificateItem
+ (TokenGoodsModel * _Nonnull)deliveryWithDid:(NSString * _Nonnull)did sellerName:(NSString * _Nonnull)sellerName buyerName:(NSString * _Nonnull)buyerName buyerDID:(NSString * _Nonnull)buyerDID commodityName:(NSString * _Nonnull)commodityName commodityCount:(NSInteger)commodityCount SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC8TokenSDK26TokenSignatureHistoryModel")
@interface TokenSignatureHistoryModel : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified did;
@property (nonatomic, copy) NSString * _Null_unspecified id;
@property (nonatomic, copy) NSString * _Null_unspecified type;
@property (nonatomic, copy) NSString * _Nullable content;
@property (nonatomic) NSInteger expiryDate;
@property (nonatomic, copy) NSArray<TokenSignatureModel *> * _Nonnull signature;
- (nonnull instancetype)initWithDict:(NSDictionary<NSString *, id> * _Nullable)dict OBJC_DESIGNATED_INITIALIZER;
- (TokenSignatureModel * _Nullable)confirmSignatureModelWithDid:(NSString * _Nonnull)did SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end



#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop