#import <Foundation/Foundation.h>
@interface BookModel : NSObject
{
    NSString* _iconUrl;
    NSString* _bookName;
    NSString* _publisher;
    NSString* _price;
    NSString* _autherName;
    NSString* _pubdate;
    NSString* _translator;
    NSString* _introUrl;
    NSInteger _numRatings;
    CGFloat _rating;
}
@property(retain, nonatomic)NSString* iconUrl;
@property(retain, nonatomic)NSString* pubdate;
@property(retain, nonatomic)NSString* introUrl;
@property(retain, nonatomic)NSString* autherName;
@property(retain, nonatomic)NSString* translator;;
@property(retain, nonatomic)NSString* bookName;
@property(retain, nonatomic)NSString* publisher;
@property(retain, nonatomic)NSString* price;
@property(assign, nonatomic)NSInteger numRatings;
@property(assign, nonatomic)CGFloat rating;
@end
