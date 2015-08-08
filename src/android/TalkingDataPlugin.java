package com.talkingdata.analytics;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.content.Context;

import com.tendcloud.tenddata.TCAgent;;

public class TalkingDataPlugin extends CordovaPlugin {
	Activity act;
	Context ctx;
	String currPageName;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		this.act = cordova.getActivity();
		this.ctx = cordova.getActivity().getApplicationContext();
	}
	
	@Override
	public void onResume(boolean multitasking) {
		super.onResume(multitasking);
		TCAgent.onResume(act);
	}
	
	@Override
	public void onPause(boolean multitasking) {
		super.onPause(multitasking);
		TCAgent.onPause(act);
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("sessionStarted")) {
			String appKey = args.getString(0);
			String channelId = args.getString(1);
			TCAgent.init(ctx, appKey, channelId);
			return true;
		} else if (action.equals("trackEvent")) {
			String eventId = args.getString(0);
			TCAgent.onEvent(ctx, eventId);
			return true;
		} else if (action.equals("trackEventWithLabel")) {
			String eventId = args.getString(0);
			String eventLabel = args.getString(1);
			TCAgent.onEvent(ctx, eventId, eventLabel);
			return true;
		} else if (action.equals("trackEventWithParameters")) {
			String eventId = args.getString(0);
			String eventLabel = args.getString(1);
			String eventDataJson = args.getString(2);
			if (eventDataJson != null) {
				Map<String, Object> eventData = this.toMap(eventDataJson);
				TCAgent.onEvent(ctx, eventId, eventLabel, eventData);
			}
			return true;
		} else if (action.equals("trackPage")) {
			String pageName = args.getString(0);
			if (currPageName) {
				TCAgent.onPageEnd(act, currPageName);
			}
			currPageName = pageName;
			TCAgent.onPageStart(act, pageName);
			return true;
		} else if (action.equals("trackPageBegin")) {
			String pageName = args.getString(0);
			currPageName = pageName;
			TCAgent.onPageStart(act, pageName);
			return true;
		} else if (action.equals("trackPageEnd")) {
			String pageName = args.getString(0);
			currPageName = null;
			TCAgent.onPageEnd(act, pageName);
			return true;
		} else if (action.equals("getDeviceId")) {
			String deviceId = TCAgent.getDeviceId(ctx);
			callbackContext.success(deviceId);
			return true;
		} else if (action.equals("setSignalReportEnabled")) {
			TCAgent.setReportUncaughtExceptions(args.getBoolean(0));
			return true;
		} else if (action.equals("setLogEnabled")) {
			TCAgent.LOG_ON = args.getBoolean(0);
			return true;
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	private Map<String, Object> toMap(String jsonStr)
	{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			JSONObject jsonObj = new JSONObject(jsonStr);
			Iterator<String> keys = jsonObj.keys();
			String key = null;
			Object value = null;
			while (keys.hasNext())
			{
				key = keys.next();
				value = jsonObj.get(key);
				result.put(key, value);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return result;
	}
}
