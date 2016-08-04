#import "BookModel.h"

@implementation BookModel
@synthesize bookName = _bookName;
@synthesize iconUrl = _iconUrl;
@synthesize publisher = _publisher;
@synthesize price = _price;
@synthesize numRatings = _numRatings;
@synthesize rating = _rating;
@synthesize autherName = _autherName;
@synthesize pubdate = _pubdate;
@synthesize translator = _translator;
@synthesize introUrl = _introUrl;
- (void)dealloc{
    [_introUrl release];
    [_pubdate release];
    [_bookName release];
    [_iconUrl release];
    [_publisher release];
    [_price release];
    [_autherName release];
    [_translator release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
