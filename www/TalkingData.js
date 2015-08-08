var TalkingData = {
    init:function(appKey, channelId) {
        Cordova.exec(null, null, "TalkingData", "sessionStarted", [appKey, channelId]);
    },
    trackEvent:function(eventId) {
        Cordova.exec(null, null, "TalkingData", "trackEvent", [eventId]);
    },
    trackEventWithLabel:function(eventId, eventLabel) {
        Cordova.exec(null, null, "TalkingData", "trackEventWithLabel", [eventId, eventLabel]);
    },
    trackEventWithParameters:function(eventId, eventLabel, eventData) {
        var eventDataJson = JSON.stringify(eventData);
        Cordova.exec(null, null, "TalkingData", "trackEventWithParameters", [eventId, eventLabel, eventDataJson]);
    },
    trackPage:function(pageName) {
        Cordova.exec(null, null, "TalkingData", "trackPage", [pageName]);
    },
    trackPageBegin:function(pageName) {
        Cordova.exec(null, null, "TalkingData", "trackPageBegin", [pageName]);
    },
    trackPageEnd:function(pageName) {
        Cordova.exec(null, null, "TalkingData", "trackPageEnd", [pageName]);
    },
    setLocation:function(latitude, longitude) {
        Cordova.exec(null, null, "TalkingData", "setLocation", [latitude, longitude]);
    },
    getDeviceId:function(callBack) {
        Cordova.exec(callBack, null, "TalkingData", "getDeviceId", []);
    },
    openDebugLog:function(enabled) {
        Cordova.exec(null, null, "TalkingData", "openDebugLog", [enabled]);
    },
    setExceptionReportEnabled:function(enabled) {
        Cordova.exec(null, null, "TalkingData", "setExceptionReportEnabled", [enabled]);
    },
    setSignalReportEnabled:function(enabled) {
        Cordova.exec(null, null, "TalkingData", "setSignalReportEnabled", [enabled]);
    },
    setLogEnabled:function(enabled) {
        Cordova.exec(null, null, "TalkingData", "setLogEnabled", [enabled]);
    }
};
