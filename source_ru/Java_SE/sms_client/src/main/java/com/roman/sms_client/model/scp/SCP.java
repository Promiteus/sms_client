package com.roman.sms_client.model.scp;

import java.io.PrintWriter;




import com.roman.sms_client.model.SimpleConnectionProtocol;
import com.roman.sms_client.model.SmsServerStatusUI;
import com.roman.sms_client.user.User;

public class SCP extends SimpleConnectionProtocol {
	private PrintWriter sender;
	private User user;
	private SmsServerStatusUI smsStatUI;
	
	public SCP(PrintWriter sender, User user, SmsServerStatusUI smsStatUI) {
		this.sender = sender;
		this.user = user;
		this.smsStatUI = smsStatUI;
		
		/**Начальное приветствие*/
		sendGreeting(user);
	}	
	
	
	
	private synchronized void sendData(String data) {
	  if ((data != null || data != "") && this.sender != null) {	
		this.sender.println(data);
		this.sender.flush();
	  }
	}
	
	
	@Override
	public boolean hasCommand(String cmd) {
		if (user == null) return false;
		

		if (cmd.lastIndexOf(PROT_HELLO) != -1) {
			
		    parseCmd(cmd, CmdType.GREETING);
		    if (user.getAuthorized()) {
		    	sendSmsMsg(user);
		    } else {
		    	sendAuth(user);
		    }
			return true;
		
		} else 
		if (cmd.lastIndexOf(PROT_AUTH) != -1) {
			
		  parseCmd(cmd, CmdType.ACCESS);
		  if (!user.getAuthorized()) {
		     return false; //Авторизация на сервере не пройдена
		  } else {
			  sendSmsMsg(user);
		      return true; //Авторизация успешно пройдена и отправлены данные для SMS
		  }			
		} else 
	    if (cmd.lastIndexOf(PROT_SMS) != -1) {			
	    	parseCmd(cmd, CmdType.SMS);
	    	return false;
		} else		
		if (cmd.lastIndexOf(PROT_UNKNOWN) != -1) {
			parseCmd(cmd, CmdType.UNKNOWN_CMD);
			return false;
		} else
		if (cmd.lastIndexOf(PROT_CONNECTION) != -1) {
			parseCmd(cmd, CmdType.CLOSE_SOCK);
			if (user.isCloseSocket()) {
			  return false;
			} else if (!user.isCloseSocket()) {
			  return true;	
			}
		}	
			
		return false;
	}

	
	@Override
	public void parseCmd(String cmd, CmdType stat) {
		// TODO Auto-generated method stub
	 try {	
		 user.setCmdMsg(cmd);
	
		 switch (stat) {
		  case GREETING: 
			this.user = ScpJsonFormat.getJsonGreetingData(cmd, user);
			smsStatUI.onGetNotifictionOfSmsServer(stat, user);			
			break;		 
		  case SMS:
			this.user = ScpJsonFormat.getJsonSmsData(cmd, user);
			smsStatUI.onGetNotifictionOfSmsServer(stat, user);
			break;				
		  case ACCESS:
			this.user = ScpJsonFormat.getJsonAuthData(cmd, user); 
			smsStatUI.onGetNotifictionOfSmsServer(stat, user);
			break;						
		  case UNKNOWN_CMD:
		    this.user = ScpJsonFormat.getJsonErrorData(cmd, user);
		    smsStatUI.onErrorOccuredOnSmsServer(user);
			break;  
		  case CLOSE_SOCK:
			this.user = ScpJsonFormat.getJsonConnectionData(cmd, user);
			smsStatUI.onDisconnectedOfSmsServer(user);
			break;
		
		}			
		
	 } catch (Exception err) {
		 SCP.MsgLog(err.getMessage(), SCP.this, SCP.MsgType.ERR);
	 }
	}
	
	
	private void notifyAboutSending(User user, String cmd) {
		user.setCmdMsg(cmd);
		smsStatUI.onClientSendCmdNotification(user);
	}
		
	
	
	
	@Override
	public void sendAuth(User user) {
		String cmd = ScpJsonFormat.createAuthJsonString(user); 
		sendData(cmd);	
		notifyAboutSending(user, cmd);
	}

	
	@Override
	public void sendSmsMsg(User user) {
		String cmd =ScpJsonFormat.createSmsJsonString(user); 
		sendData(cmd);
		notifyAboutSending(user, cmd);
	}



	@Override
	public void sendGreeting(User user) {
		String cmd = ScpJsonFormat.createGreetingJsonString(user); 
		sendData(cmd);
		notifyAboutSending(user, cmd);
	}

	@Override
	public void sendConnectionStat(User user) {
		String cmd = ScpJsonFormat.createConnectionJsonString(user);
		sendData(cmd);
		notifyAboutSending(user, cmd);
	}



}
