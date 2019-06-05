package com.roman.sms_client.model.scp;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.roman.sms_client.user.User;

public class ScpJsonFormat {
	
	
	@SuppressWarnings("unchecked")
	public static String createAuthJsonString(User user) {
		if (user == null) return null;
		
		JSONObject authJson = new JSONObject();  
		
		  JSONObject innerJson = new JSONObject();
		  Map<String, String> pars = new HashMap<String, String>();
		 
		  pars.put(SCP.KEY_LOGIN, user.getLogin());
		  pars.put(SCP.KEY_PASS, user.getPassword());
		  pars.put(SCP.KEY_COMMENTS, user.getComments());
		  innerJson.putAll(pars);
		
		 authJson.put(SCP.KEY_AUTH, innerJson);
		
		return authJson.toJSONString();
	}
	
	

	
	
	@SuppressWarnings("unchecked")
	public static String createSmsJsonString(User user) {
		if (user == null) return null;
		
		JSONObject smsJson = new JSONObject();
		
		JSONObject innerJson = new JSONObject();
		Map<String, Set<String>> telPars = new HashMap<String, Set<String>>();
		innerJson.put(SCP.KEY_SMS_MSG, user.getSmsMessage());
		innerJson.put(SCP.KEY_COMMENTS, user.getComments());
	
		if (user.getTels() != null && user.getTels().size() > 0) {
			telPars.put(SCP.KEY_TEL_LIST, user.getTels());
			innerJson.putAll(telPars);
		} 		
		
		smsJson.put(SCP.PROT_SMS, innerJson);
		
		return smsJson.toJSONString();		
	}
	
	@SuppressWarnings("unchecked")
	public static String createGreetingJsonString(User user) {
	
		if (user == null) return null;
		JSONObject greetingJson = new JSONObject();
		  
		  JSONObject innerJson = new JSONObject();
		  innerJson.put(SCP.KEY_CRYPT, user.isEncryptEnabled());
		  innerJson.put(SCP.KEY_COMMENTS, user.getComments());
		//  innerJson.put(SCP.KEY_AUTH, user.getAuthorized());
	    greetingJson.put(SCP.PROT_HELLO, innerJson);
		  
		  
		return greetingJson.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	public static String createConnectionJsonString(User user) {
		if (user == null) return null;
		JSONObject connJson = new JSONObject();
		  JSONObject innerJson = new JSONObject();
		  innerJson.put(SCP.KEY_COMMENTS, user.getComments());
		  innerJson.put(SCP.KEY_SOCK_CLOSE, user.isCloseSocket());
		  
		connJson.put(SCP.PROT_CONNECTION, innerJson);
		
		return connJson.toJSONString();
	}
	
	/**
	 * {"greeting":{"encryption":"false", "comment":"", "authorized":"false"}}
	 * */
	
	public static User getJsonGreetingData(String json, User user) throws ParseException {
		if (user == null) return null;
		JSONParser parser = new JSONParser();
		JSONObject greetingJson = (JSONObject)parser.parse(json);
		
		JSONObject greet = (JSONObject) greetingJson.get(SCP.PROT_HELLO);
		
		  user.setAuthorized(Boolean.parseBoolean(greet.get(SCP.KEY_AUTHORIZED).toString()));
		  user.setComments(greet.get(SCP.KEY_COMMENTS).toString());
		  user.setEncryptEnabled(Boolean.parseBoolean(greet.get(SCP.KEY_CRYPT).toString()));
		  
		return user;
	}
	
	/**
	 * {"sms":{"smsMessage":"Any message for sending",
	 *  "comment":"", "status":"sending"}}
	 * @throws ParseException 
	 * */
	
	public static User getJsonSmsData(String json, User user) throws ParseException {
		if (user == null) return null;
		JSONParser parser = new JSONParser();
		JSONObject joSms = (JSONObject) parser.parse(json);
		JSONObject joSmsValues = (JSONObject) joSms.get(SCP.PROT_SMS);
		   
		user.setComments(joSmsValues.get(SCP.KEY_COMMENTS).toString());
		user.setSmsMessage(joSmsValues.get(SCP.KEY_SMS_MSG).toString());
		user.setStatus(joSmsValues.get(SCP.KEY_STATUS).toString());
		
		return user;	
	}
	
	/**
	 * {"auth":{"authorized":"true", "comment":"", "status":"ok"}}
	 * @throws ParseException 
	 * */
	
	public static User getJsonAuthData(String json, User user) throws ParseException {
		if (user == null) return null;
		JSONParser parser = new JSONParser();
		JSONObject joAuth = (JSONObject) parser.parse(json);
		JSONObject joAuthValues = (JSONObject) joAuth.get(SCP.PROT_AUTH);		
		
		user.setAuthorized(Boolean.parseBoolean(joAuthValues.get(SCP.KEY_AUTHORIZED).toString()));
		user.setComments(joAuthValues.get(SCP.KEY_COMMENTS).toString());
		//user.setStatus(joAuthValues.get(SCP.KEY_STATUS).toString());
		user.setCloseSocket(Boolean.parseBoolean(joAuthValues.get(SCP.KEY_SOCK_CLOSE).toString()));
		
		return user;			
	}
	
	/**
	 * {"error":{"errType":"", "errMsg":"", "closeSocket":"true"}}
	 * */
	
	public static User getJsonErrorData(String json, User user) throws ParseException {
		if (user == null) return null;
		JSONParser parser = new JSONParser();
		JSONObject joErr = (JSONObject) parser.parse(json);
		JSONObject joErrValues = (JSONObject) joErr.get(SCP.PROT_UNKNOWN);
		
	    	user.setErrMsg(joErrValues.get(SCP.KEY_ERR_MSG).toString());
		    user.setErrType(joErrValues.get(SCP.KEY_ERR_TYPE).toString());		
		
		return user;		
	}
	
	/**
	 * {"connection":{"comment":"", "closeSocket":"true"}}
	 * */
	
	public static User getJsonConnectionData(String json, User user) throws ParseException {
		if (user == null) return null;
		JSONParser parser = new JSONParser();
		JSONObject joConnection = (JSONObject) parser.parse(json);
		JSONObject joConnectionValues = (JSONObject) joConnection.get(SCP.PROT_CONNECTION);
		  
		   user.setComments(joConnectionValues.get(SCP.KEY_COMMENTS).toString());
		   user.setCloseSocket(Boolean.parseBoolean(joConnectionValues.get(SCP.KEY_SOCK_CLOSE).toString()));
		
		return user;
	}

}
