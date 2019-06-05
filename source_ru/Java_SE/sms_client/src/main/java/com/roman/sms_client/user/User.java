package com.roman.sms_client.user;

import java.util.HashSet;
import java.util.Set;

public class User {
   private Set<String> tels = null;
   private String smsMessage = "";
   private String login = "";
   private String password = "";   
   private boolean encryptEnabled = false;
   private String encryptKeyCode = "";   
   private String errMsg = "";
   private String errType = "";
   private String comments = "";
   private boolean authorized = false;
   private String status = "";
   private boolean closeSocket;
   private String cmdMsg;
   
   public String getCmdMsg() {
	   return cmdMsg;
   }

   public void setCmdMsg(String logMsg) {
	   this.cmdMsg = logMsg;
   }

private int port;
   private String ipAddress;
   
    public boolean getAuthorized() {
     	return authorized;
    }

    public void setAuthorized(boolean authorized) {
    	this.authorized = authorized;
    }

    public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

    public String getErrType() {
		return errType;
	}

	public boolean isCloseSocket() {
    	return closeSocket;
    }

    public void setCloseSocket(boolean closeSocket) {
    	this.closeSocket = closeSocket;
    }

	public void setErrType(String errType) {
		this.errType = errType;
	}

    public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


  

   public User() {
	  
   }
   
   public String getErrMsg() {
    	return errMsg;
   }
  
   public void setErrMsg(String errMsg) {
    	this.errMsg = errMsg;
   }
  
   public Set<String> getTels() {
	return tels;
   }
  
   public void setTels(Set<String> tels) {
	this.tels = tels;
   }
  
   public String getSmsMessage() {
	return smsMessage;
   }
 
   public void setSmsMessage(String smsMessage) {
	this.smsMessage = smsMessage;
   }
  
   public String getLogin() {
	return login;
   }
 
   public void setLogin(String login) {
	this.login = login;
   }
  
   public String getPassword() {
	return password;
   }
  
   public void setPassword(String password) {
	this.password = password;
   }
  
   public boolean isEncryptEnabled() {
	return encryptEnabled;
   }
 
   public void setEncryptEnabled(boolean encryptEnabled) {
	this.encryptEnabled = encryptEnabled;
   }
 
   public String getEncryptKeyCode() {
	return encryptKeyCode;
   }
 
   public void setEncryptKeyCode(String encryptKeyCode) {
	this.encryptKeyCode = encryptKeyCode;
   }
}
