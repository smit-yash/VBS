#import <Foundation/Foundation.h>

@interface WebServices : NSObject

- (void)loginWithPhoneNumber:(NSInteger)phoneNumber;
- (void)verifyOTP:(NSInteger)otp;
- (void)fetchHomeMessageWithId:(NSInteger)id;
- (void)fetchLeadersVoice;
- (void)fetchCategories;
- (void)fetchPDFsForCategoryId:(NSInteger)categoryId;
- (void)fetchScores;
- (void)fetchQuiz;

@end
