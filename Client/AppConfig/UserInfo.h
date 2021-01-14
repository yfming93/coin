//
//  UserInfo.h
//  application
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 stormorai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBaseModel.h"

@interface account : FMBaseModel<NSCoding>
proBool(hasSetedPayPwd)
proNSString(icon)
proNSString(memberLevelId)
proNSString(receivingCount)
proNSString(growth)
proNSString(thirdParentId)
proNSString(commentCount)
proNSString(couponsCount)
proNSString(realname)
proNSString(secondParentId)
proNSString(parents)
proNSString(attentionsCount)
proNSString(cartCount)
proNSString(luckeyCount)
proNSString(payDoneCount)
proNSString(birthday)
proNSString(payPassword)
proNSString(historyIntegration)
proNSString(username)
proNSString(status)
proNSString(city)
proNSString(personalizedSignature)
proNSString(integration)
proNSString(available)
proNSString(sourceType)
proNSString(toPayCount)
proNSString(job)
proNSString(gender)
proNSString(openId)
proNSString(createTime)
proNSString(shareCode)
proNSString(parentId)
proNSString(storeCount)
proNSString(phone)
proNSString(levelName)
proNSString(nickname)
proNSString(userLevel)

// 我的服务里面的字段
proNSString(tokenAvailable)
proNSString(integralAvailable)
proNSString(evAvailable)

@end
@interface User : FMBaseModel<NSCoding>

@end
@interface UserInfo : FMBaseModel<NSCoding>
@property (nonatomic, strong) account *account;
@property (nonatomic, strong) User *user;
proNSMutableArrayType(NSDictionary, arrHistory)
proStrongType(NSMutableDictionary, dic)
proNSString(token)
proNSString(authorization)

@end
@interface member : FMBaseModel 

proNSString(firstName)
proNSString(lastName)
proNSString(passportId)
proNSString(passportImage)
proNSString(passportFront)
proNSString(passportBack)
proNSInteger(status)
proNSString(creator)
proNSString(createDate)
proNSString(sex)
proNSString(verifyDetail)
@end
