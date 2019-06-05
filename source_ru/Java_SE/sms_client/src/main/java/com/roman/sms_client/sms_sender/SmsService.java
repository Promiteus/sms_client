package com.roman.sms_client.sms_sender;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.nio.charset.StandardCharsets;

import com.roman.sms_client.App;
import com.roman.sms_client.model.SimpleConnectionProtocol;
import com.roman.sms_client.model.SmsServerStatusUI;
import com.roman.sms_client.model.scp.SCP;
import com.roman.sms_client.user.User;


public class SmsService
{ 
	private Socket clientSocket = null;	
	private SmsServerStatusUI smsStatUI = null;
	private User user;
    private boolean clientRun = false;
	private PrintWriter bufferWriter;
	private BufferedReader bufferReader;
	private int port;
	private String address;

	
	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}


	private String serverMsg;
	private SimpleConnectionProtocol scp;
	
	public SmsService(String address, int port, User user, SmsServerStatusUI smsStatUI) {		
		this.smsStatUI = smsStatUI;
		this.address = address;
		this.port = port;	
		this.user = user;
	}
	
	public SmsService(User user, SmsServerStatusUI smsStatUI) {		
		this.smsStatUI = smsStatUI;
		this.user = user;
	
	}	
	
	public void stopClient() {
	  if (scp != null && clientSocket != null && bufferWriter != null) {	
		scp.sendConnectionStat(user);
		
		clientRun = false;
		
		bufferWriter.flush();
		bufferWriter.close();
		
		smsStatUI = null;
		bufferWriter = null;
		bufferReader = null;
	  }
	}



	public boolean isConnected() {		
		return clientSocket != null && clientSocket.isConnected();
	}
	
	
	
	public boolean isRunniing() {
		return clientRun;
	}
	
	private void initBuffers() throws IOException {
		bufferWriter = new PrintWriter(new OutputStreamWriter(clientSocket.getOutputStream(),
				StandardCharsets.UTF_8));
		bufferReader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream(),
				StandardCharsets.UTF_8));				
	}

	
	public void sendSMS() {	
		if (user == null) return;
		
		Thread sms = new Thread(new Runnable() {

			@Override
			public void run() {
				try {
				  	InetAddress serverAddr = InetAddress.getByName(address);
					try {
						clientSocket = new Socket(serverAddr, port);
						user.setPort(port);
						user.setIpAddress(address);                        
						clientRun = true;
						initBuffers();						
						smsStatUI.onConnectedToSmsServer();						
						
						SimpleConnectionProtocol scp = new SCP(bufferWriter, user, smsStatUI);
						
						while (clientRun) {
							clientRun = !bufferWriter.checkError();							
							serverMsg = bufferReader.readLine();		
							
							if (scp.hasCommand(serverMsg)) {
								Thread.yield();
								continue;								
							}					
						}
						
					} finally {
						if (clientSocket != null && clientSocket.isConnected()) {
							clientSocket.close();
							SCP.MsgLog(SCP.MSG_INFO_CLOSE_SOCKET, SmsService.this, SCP.MsgType.INFO);
							//app.lockInput_();
							smsStatUI.onEndSendsmsThread();
							//app.appExit_();
						}
					}
					
				} catch (Exception err) {
			    	if (err.getMessage() != null) {	
				    	SCP.MsgLog(err.getMessage(), SmsService.this, SCP.MsgType.ERR);
				    	//app.lockInput_();
				    	smsStatUI.onEndSendsmsThread();
				    	//app.appExit_();
				    }
				}				
			}
			
		});
		
		sms.start();
	}


}
