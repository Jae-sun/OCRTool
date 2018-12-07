//
//  OTRecord+CoreDataProperties.m
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//
//

#import "OTRecord+CoreDataProperties.h"

@implementation OTRecord (CoreDataProperties)

+ (NSFetchRequest<OTRecord *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OTRecord"];
}

@dynamic recordID;
@dynamic imgName;
@dynamic resultTxt;
@dynamic type;
@dynamic resultTime;

@end
