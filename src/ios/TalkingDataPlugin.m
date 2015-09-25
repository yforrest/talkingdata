//
//  TalkingDataPlugin.m
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 13-12-2.
//
//

#import "TalkingDataPlugin.h"
#import "TalkingData.h"

@interface TalkingDataPlugin ()

#if __has_feature(objc_arc)
@property (nonatomic, strong) NSString *currPageName;
#else
@property (nonatomic, retain) NSString *currPageName;
#endif

@end

@implementation TalkingDataPlugin

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
    [self.currPageName release];
}
#endif

- (void)sessionStarted:(CDVInvokedUrlCommand*)command {
    NSString *appKey = [command.arguments objectAtIndex:0];
    if (appKey == nil || [appKey isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *channelId = [command.arguments objectAtIndex:1];
    if ([channelId isKindOfClass:[NSNull class]]) {
        channelId = nil;
    }
    [TalkingData sessionStarted:appKey withChannelId:channelId];
}

- (void)openDebugLog:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    // [TalkingData openDebugLog:enabled];
}

- (void)getDeviceId:(CDVInvokedUrlCommand*)command {
    NSString *deviceId = [TalkingData getDeviceID];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceId];
    // [self writeJavascript:[pluginResult toSuccessCallbackString:command.callbackId]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setExceptionReportEnabled:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setExceptionReportEnabled:enabled];
}

- (void)setSignalReportEnabled:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setSignalReportEnabled:enabled];
}

- (void)setLocation:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    NSString *arg1 = [command.arguments objectAtIndex:1];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]] || arg1 == nil || [arg1 isKindOfClass:[NSNull class]]) {
        return;
    }
    double latitude = [arg0 doubleValue];
    double longitude = [arg1 doubleValue];
    [TalkingData setLatitude:latitude longitude:longitude];
}

- (void)setLogEnabled:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setLogEnabled:enabled];
}

- (void)trackEvent:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingData trackEvent:eventId];
}

- (void)trackEventWithLabel:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    [TalkingData trackEvent:eventId label:eventLabel];
}

- (void)trackEventWithParameters:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    NSDictionary *parameters = nil;
    NSString *parametersJson = [command.arguments objectAtIndex:2];
    if (![parametersJson isKindOfClass:[NSNull class]]) {
        parameters = [parametersJson JSONObject];
    }
    [TalkingData trackEvent:eventId label:eventLabel parameters:parameters];
}

- (void)trackPage:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (self.currPageName) {
        [TalkingData trackPageEnd:pageName];
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:pageName];
}

- (void)trackPageBegin:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:pageName];
}

- (void)trackPageEnd:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPageName = nil;
    [TalkingData trackPageEnd:pageName];
}

@end
