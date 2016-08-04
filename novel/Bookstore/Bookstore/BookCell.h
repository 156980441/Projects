#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "BookModel.h"
@interface BookCell : UITableViewCell
{
    UIImageView* _iconView;
    UILabel* _priceLabel;
    UILabel* _publisherLabel;
    UILabel* _bookNameLabel;
    UILabel* _numRatingsLabel;
    RatingView* _ratingView;
    
    BookModel* _book;
}
@property(retain, nonatomic)BookModel* book;
@end
