package com.roman.sms_client.model;


import java.util.Date;


import com.roman.sms_client.user.User;



public abstract class SimpleConnectionProtocol {
	
	public static final String KEY_LOGIN = "username";
	public static final String KEY_PASS = "password";
	public static final String KEY_COMMENTS = "comments";
	public static final String KEY_SMS_MSG = "smsMessage";
	public static final String KEY_TEL_LIST = "tels";
	public static final String KEY_AUTH = "auth";
	public static final String KEY_STATUS = "status";
	public static final String KEY_CRYPT = "encryption";
	public static final String KEY_AUTHORIZED = "authorized";
	public static final String KEY_ERR_TYPE = "errType";
	public static final String KEY_ERR_MSG = "errMsg";
	public static final String KEY_SOCK_CLOSE = "closeSocket";
	
	public static final String PROT_HELLO = "greeting";
	public static final String PROT_AUTH = "auth";
	public static final String PROT_SMS = "sms";
	public static final String PROT_UNKNOWN = "error";
	public static final String PROT_CONNECTION = "connection";
	
	public static final String ERR_INFO = "Error [class: %s] >> описание: %s";
	public static final String ERR_INFO_SERVER = "[Server error]: %s << %s:%d << [Type: %s] описание: %s";
	public static final String MSG_INFO = "Info [class: %s] >> %s";
	public static final String MSG_INFO_MAIN = "Info [main] >> %s";
	public static final String MSG_INFO_IP = "[Server]: %s << %s:%d << %s";
	public static final String MSG_INFO_IP_SEND = "[Client]: %s >> %s:%d >> %s";
	
	public static final String MSG_INFO_CLOSE_SOCKET = "Соединение с сервером закрыто...";
	
	public enum CmdType {
		GREETING, ACCESS, SMS, UNKNOWN_CMD, CLOSE_SOCK;
	}
	
	public enum MsgType {
		ERR, INFO, INFO_IP, INFO_IP_SEND;
	}
	
	public static void MsgLog(String msg, Object object, MsgType mType) {
		switch (mType) {
		case ERR: 
			System.out.println(String.format(ERR_INFO, object.getClass().getSimpleName(), msg));
			break;
		case INFO:
			if (object != null)
			    System.out.println(String.format(MSG_INFO, object.getClass().getSimpleName(), msg));
			else
				System.out.println(String.format(MSG_INFO_MAIN, msg));
			break;
		case INFO_IP:
			if (object.getClass() == User.class) {
			  System.out.println(String.format(MSG_INFO_IP, new Date(),
					  ((User)object).getIpAddress(), ((User)object).getPort(), msg));
			}
			break;
		case INFO_IP_SEND:
			if (object.getClass() == User.class) {
			  System.out.println(String.format(MSG_INFO_IP_SEND, new Date(),
					  ((User)object).getIpAddress(), ((User)object).getPort(), msg));	
			}
			break;
		}			
	}
	
	public static void serverErrLog(User user) {
	 if (user != null) { 	
		System.out.println(String.format(ERR_INFO_SERVER, new Date(), user.getIpAddress(),
				user.getPort(), user.getErrType(), user.getErrMsg()));
	 }
	}
	

	public abstract boolean hasCommand(String cmd);
	public abstract void parseCmd(String cmd, CmdType stat);
	public abstract void sendAuth(User user);
	public abstract void sendSmsMsg(User user);
	public abstract void sendGreeting(User user);
	public abstract void sendConnectionStat(User user);
}
