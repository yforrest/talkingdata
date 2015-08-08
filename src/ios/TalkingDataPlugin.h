//
//  TalkingDataPlugin.h
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 13-12-2.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface TalkingDataPlugin : CDVPlugin
- (void)sessionStarted:(CDVInvokedUrlCommand*)command;
- (void)openDebugLog:(CDVInvokedUrlCommand*)command;
- (void)getDeviceId:(CDVInvokedUrlCommand*)command;
- (void)setExceptionReportEnabled:(CDVInvokedUrlCommand*)command;
- (void)setSignalReportEnabled:(CDVInvokedUrlCommand*)command;
- (void)setLocation:(CDVInvokedUrlCommand*)command;
- (void)setLogEnabled:(CDVInvokedUrlCommand*)command;
- (void)trackEvent:(CDVInvokedUrlCommand*)command;
- (void)trackEventWithLabel:(CDVInvokedUrlCommand*)command;
- (void)trackEventWithParameters:(CDVInvokedUrlCommand*)command;
- (void)trackPage:(CDVInvokedUrlCommand*)command;
- (void)trackPageBegin:(CDVInvokedUrlCommand*)command;
- (void)trackPageEnd:(CDVInvokedUrlCommand*)command;
@end
