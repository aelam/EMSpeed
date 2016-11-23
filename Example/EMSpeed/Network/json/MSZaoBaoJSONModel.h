//
//  MSZaoBaoJSONModel.h
//  EMSpeed
//
//  Created by flora on 16/11/18.
//  Copyright © 2016年 Ryan Wang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MSZaoBaoItem
@end

@interface MSZaoBaoJSONModel : JSONModel

@property (nonatomic, strong) NSArray<MSZaoBaoItem> *data;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * topid;
@property (nonatomic , strong) NSNumber              * hasNextPage;
@property (nonatomic , copy) NSString              * lastid;
@end



@interface MSZaoBaoItem :JSONModel

@property (nonatomic , copy) NSString              * newsId;
@property (nonatomic , strong) NSNumber            * accessNum;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , strong) NSNumber            * Type;
@property (nonatomic , copy) NSString              * htmlUrl;
@property (nonatomic , copy) NSString              * createTime;

@end
