package com.roman.sms_client.model;

import com.roman.sms_client.model.SimpleConnectionProtocol.CmdType;
import com.roman.sms_client.user.User;

public interface SmsServerStatusUI {
     void onConnectedToSmsServer();
     void onDisconnectedOfSmsServer(User user);
     void onGetNotifictionOfSmsServer(CmdType cmd, User user);
     void onErrorOccuredOnSmsServer(User user);
     void onClientSendCmdNotification(User user);
     void onEndSendsmsThread();
}
