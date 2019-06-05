package com.roman.sms_client;

import java.io.Console;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.roman.sms_client.model.SimpleConnectionProtocol.CmdType;
import com.roman.sms_client.model.SmsServerStatusUI;
import com.roman.sms_client.model.scp.SCP;
import com.roman.sms_client.sms_sender.SmsService;
import com.roman.sms_client.user.User;

/**
 * Hello world!
 *
 */
public class App 
{
	 private static final Pattern PATTERN = Pattern.compile("\\s*(\\S+)\\s*=\\s*(\\S+)");
	 private static String login = null;
	 private static String pass = null;
	 private static String ipAddress = null;
	 private static int port = 0;
	 

	

	
    private static void appExit() {
	  	SCP.MsgLog("Вышел из программы...\n", null, SCP.MsgType.INFO);	  	
    	System.exit(0);
    }
    
    
    public static boolean isItDigitTelsList(String tels) {
    	
    	for (int i = 0; i < tels.length(); i++) {
    		if ((Character.isDigit(tels.charAt(i))) || 
    				(tels.charAt(i) == ";".charAt(0)) || (tels.charAt(i) == "+".charAt(0))) {
    			continue;
    		} else {
    		    return false;
    		}
    	}
    	return true;
    }
    
    private static List<String> getServerParamFile(String fileName) {
        List<String> lines;
		try {
			lines = Files.readAllLines(Paths.get(fileName), StandardCharsets.UTF_8);
            return lines;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
    }
    
    private static void lockInput(Scanner keyboard) {
    	SCP.MsgLog("Нажмите Enter для завершения работы программы...", null, SCP.MsgType.INFO);
    	keyboard.nextLine();
    }
	
    private static boolean checkInputParam(String fileName, Scanner keyboard) {
		if (!fileName.isEmpty()) {
			
			List<String> params = new ArrayList<String>();
			if ((fileName.length() > 0) && (fileName.lastIndexOf(".txt") != 0)) {
			   params = getServerParamFile(fileName);
			   if (params.size() == 4) {
				   for (String par: params) { 
					   Matcher m = PATTERN.matcher(par);
					   while (m.find()) {
						  try {
							 if (m.group(1).trim().equals("ip")) { 
							      ipAddress = m.group(2).trim();
							 } else if (m.group(1).trim().equals("port")) {
								  port = Integer.valueOf(m.group(2).trim());
							 } else if (m.group(1).trim().equals("login")) {
								  login = m.group(2).trim();
							 } else if (m.group(1).trim().equals("pass")) {
								  pass = m.group(2).trim();
							 }
						  } catch (Exception e) {
							  SCP.MsgLog(e.getMessage(), null, SCP.MsgType.ERR); 
							  lockInput(keyboard);
						  }
					   }
				   }
				   SCP.MsgLog(String.format("Введены параметры сервервера: %s", fileName), null, SCP.MsgType.INFO);
				   return true;
			   } else {
				   SCP.MsgLog("Не все параметры SMS-сервера внесены!", null, SCP.MsgType.INFO);  
				   lockInput(keyboard);
				   return false;
			   }
		    } else {
		    	SCP.MsgLog("Неверный формат файла конфигурации SMS-сервера!", null, SCP.MsgType.INFO); 
		    	lockInput(keyboard);
		    	return false;
		    }
		} else {
			SCP.MsgLog("Не найден файл конфигурации SMS-сервера!.", null, SCP.MsgType.INFO);
			lockInput(keyboard);
			return false;
		}    	
    	
    }
   
    
	public static void main( String[] args )
    {
		
    	/**Инициализировать ввод с клавиатуры*/
    	Scanner keyboard = new Scanner(System.in);		
		
    	//Проверить, введены ли параметры сервера в виде txt файла через командную строку
    	//Если не введены, то выполнить с параметрами по умолчанию
		if ((args.length == 0) || (!checkInputParam(args[0], keyboard))) {		
			ipAddress = "192.168.1.100";
			port = 11330;
			login = "user";
			pass = "123";
		}
		
		SCP.MsgLog(ipAddress+":"+port, null, SCP.MsgType.INFO); 
		
    	String consoleCmd = null;
    	
        /*Создаем объект пользователя*/
    	User user = new User();     	
    	
    	

    	 
    	while (true) { 
    	   SCP.MsgLog("Запустить сервис отправки SMS (yes/no)?", null, SCP.MsgType.INFO);
    	   
    		/**Ожидать ввода нужной команды.*/
    	   consoleCmd = keyboard.nextLine().trim();
    	  
    	   if (consoleCmd.equals("no")) {
    		   appExit();
          
    	   } else  if (consoleCmd.equals("quit")) {
    		   appExit(); 	   
    	  
           } else if (!consoleCmd.equals("yes") && !consoleCmd.equals("no")) {
    	    	SCP.MsgLog("Неизвестная команда!\n", null, SCP.MsgType.INFO);
    		    continue;
           
    	   } else if (consoleCmd.equals("yes")) {
        	  // break;
        	   
        	   SCP.MsgLog("Введите номера телефонов для отправки SMS через \';\' и нажмите Enter!", null, SCP.MsgType.INFO);
       	    	
        	   consoleCmd = keyboard.nextLine().trim();
        	   if (consoleCmd.equals("quit")) {
        		   appExit(); 
        	   } else if (isItDigitTelsList(consoleCmd)) {
        		   
        		   String[] item = new String[consoleCmd.split(";").length];
        		   item = consoleCmd.split(";");        	
        		   Set<String> tels = new HashSet<String>();
                   for (int i = 0; i < item.length; i++) {
                    	tels.add(item[i]);
                   }                	
                   user.setTels(tels);
                	
                	if (!tels.isEmpty()) {
                		SCP.MsgLog("Введите текст SMS-сообщения и нажмите Enter!", null, SCP.MsgType.INFO);
                		consoleCmd = keyboard.nextLine();
                		
                		if (!consoleCmd.isEmpty()) {
                			user.setSmsMessage(consoleCmd);
                			break;
                		} else {
                			SCP.MsgLog("Тело сообщение пустое!", null, SCP.MsgType.INFO);
                			continue;
                		}               	
                	}              
        	   } else  if (consoleCmd.equals("quit")) {
        		   appExit();         	   
               } else {
        		   SCP.MsgLog(String.format("Неверный формат данных: %s\n", consoleCmd), null, SCP.MsgType.INFO);
        		   continue;
        	   }   
    	   } else {
    		   continue;
    	   }
    	  }
    	
    	//System.in.readline
        SCP.MsgLog("Инициализация клиента...", null, SCP.MsgType.INFO);
        
        
  
    	/*Инициализируем севрвис передачи SMS сообщений*/
        SmsService smsService = new SmsService(user, new SmsServerStatusUI() {

        	/**Событие, возникающее при подключении к SMS-серверу.*/
			@Override
			public void onConnectedToSmsServer() {
				// TODO Auto-generated method stub
				SCP.MsgLog("Соединился с сервером...", null, SCP.MsgType.INFO);
			}

			/**Событие, возникающее при отсоединении от SMS-сервера*/
			@Override
			public void onDisconnectedOfSmsServer(User user) {
				// TODO Auto-generated method stub
				if (user != null)
		        	SCP.MsgLog(user.getCmdMsg(), user, SCP.MsgType.INFO_IP);
				SCP.MsgLog("Связь с сервером завершена...", null, SCP.MsgType.INFO);
			}

			/**Обработчик событий прихода ответных сообщений от SMS-сервера.*/
			@Override
			public void onGetNotifictionOfSmsServer(CmdType cmd, User user) {
				// TODO Auto-generated method stub
				if (user != null)
		        	SCP.MsgLog(user.getCmdMsg(), user, SCP.MsgType.INFO_IP);
				
			}

			/**Ошибки, которые возникают на SMS-сервере*/
			@Override
			public void onErrorOccuredOnSmsServer(User user) {
				// TODO Auto-generated method stub
				SCP.serverErrLog(user);
				
			}

			/**Обработчик событий, уведомляющий о факте и характере передаваемых 
			 * данных на SMS-сервер*/
			@Override
			public void onClientSendCmdNotification(User user) {
				// TODO Auto-generated method stub
				if (user != null)
		        	SCP.MsgLog(user.getCmdMsg(), user, SCP.MsgType.INFO_IP_SEND);	
			}

			@Override
			public void onEndSendsmsThread() {
				// TODO Auto-generated method stub
				SCP.MsgLog("ok!", null, SCP.MsgType.INFO);
				appExit();
			}
        	
        });
        
        if (smsService != null) {
        	smsService.setAddress(ipAddress);
        	smsService.setPort(port);       	
        	
        	/**Введите пароль и логин, который установлен на SMS-сервере.*/
        	user.setLogin(login);
        	user.setPassword(pass);
        	/**Приветственный комментарий серверу!*/
        	user.setComments("Hello, Server! How are you???");
        	
        	/**Отправка SMS-сообщения.*/
        	smsService.sendSMS();
        	

        	lockInput(keyboard);
        	
        	keyboard.close();       	
        	
        }
        
    }
}
