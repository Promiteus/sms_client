unit uScpJsonFormatter;

interface
 uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, uUser, System.Json, uSimpleConnectionProtocol;

  Type
   TSCPJsonFormatter = class (TObject)
    private

    public
      class function createAuthJsonString(aUser: TUser): String;
      class function createSmsJsonString(aUser: TUser): String;
      class function createGreetingJsonString(aUser: TUSer): String;
      class function createConnectionJsonString(aUser: TUser): String;
      class function getJsonGreetingData(aJson: String; aUser: TUser): TUser;
      class function getJsonSmsData(aJson: String; aUser: TUser): TUser;
      class function getJsonAuthData(aJson: String; aUser: TUser): TUser;
      class function getJsonErrorData(aJson: String; aUser: TUser): TUser;
      class function getJsonConnectionData(aJson: String; aUser: TUser): TUser;
   end;

implementation

{ TSCPJsonFormatter }

uses uSmsClient;

class function TSCPJsonFormatter.createAuthJsonString(aUser: TUser): String;
var
 lJObject, lInnserJson: TJsonObject;
begin
   result:=string.Empty;
   if aUser = nil then Exit;
   try
      lJObject:=TJSONObject.Create;
      lInnserJson:=TJSONObject.Create;

      lInnserJson.AddPair(KEY_LOGIN, aUser.Login);
      lInnserJson.AddPair(KEY_PASS, aUser.Password);
      lInnserJson.AddPair(KEY_COMMENTS, aUser.Comments);
      lJObject.AddPair(KEY_AUTH, lInnserJson);

      result:=lJObject.ToString;
       //TSimpleConnectionProtocol.MsgLog(result, aUser, mtINFO, frmSmsClient);
   finally
      lJObject.Free;
      lJObject:=nil;
   end;
end;

class function TSCPJsonFormatter.createConnectionJsonString(
  aUser: TUser): String;
var
 lJObject, lInnserJson: TJsonObject;
begin
   result:=string.Empty;
   if aUser = nil then Exit;
   try
      lJObject:=TJSONObject.Create;
      lInnserJson:=TJSONObject.Create;

      lInnserJson.AddPair(KEY_COMMENTS, aUser.Comments);
      lInnserJson.AddPair(KEY_SOCK_CLOSE, aUser.ClosedSocket.ToString());
      lJObject.AddPair(PROT_CONNECTION, lInnserJson);

      result:=lJObject.ToString;
   finally
      lJObject.Free;
      lJObject:=nil;
   end;
end;

class function TSCPJsonFormatter.createGreetingJsonString(aUser: TUSer): String;
var
 lJObject, lInnserJson: TJsonObject;

 function BooleanToString(aFlag: Boolean): String;
 begin
   if aFlag then
    result:='true'
   else
    result:='false';
 end;

begin
   result:=string.Empty;
   if aUser = nil then Exit;
   try
      lJObject:=TJSONObject.Create;
      lInnserJson:=TJSONObject.Create;

      lInnserJson.AddPair(KEY_CRYPT, BooleanToString(aUser.isEncrypted));
      lInnserJson.AddPair(KEY_COMMENTS, aUser.Comments);
         lJObject.AddPair(PROT_HELLO, lInnserJson);

      result:=lJObject.ToString;


   finally
      lJObject.Free;
      lJObject:=nil;
   end;
end;

class function TSCPJsonFormatter.createSmsJsonString(aUser: TUser): String;
var
 lJObject, lInnserJson: TJsonObject;
 lJsonArray: TJsonArray;
 I: Integer;
begin
   result:=string.Empty;
   if aUser = nil then Exit;
   try
      lJObject:=TJSONObject.Create;
      lInnserJson:=TJSONObject.Create;
      lJsonArray:=TJsonArray.Create;

      lInnserJson.AddPair(KEY_SMS_MSG, aUser.SmsMsg);
      lInnserJson.AddPair(KEY_COMMENTS, aUser.Comments);

   //   TSimpleConnectionProtocol.MsgDlg(aUser.Tels.Strings[0]);

      for I := 0 to aUser.Tels.Count-1 do
         lJsonArray.Add(aUser.Tels.Strings[I]);

      lInnserJson.AddPair(KEY_TEL_LIST, lJsonArray);

      lJObject.AddPair(PROT_SMS, lInnserJson);

      result:=lJObject.ToString;
   finally
      lJObject.Free;
    //  lInnserJson.Free;
     // lJObject:=nil;

     // lJsonArray.Free;
    //  lJsonArray:=nil;
   end;
end;

class function TSCPJsonFormatter.getJsonAuthData(aJson: String;
  aUser: TUser): TUser;
var
 lJsonObject: TJsonObject;
 linnerJObject: TJsonObject;
begin
//TSimpleConnectionProtocol.MsgDlg('Ok!');
   result:=nil;
    if (aJson.IsEmpty) or (aUser = nil) then Exit;
    try
      lJsonObject:=TJsonObject.ParseJSONValue(aJson) as TJsonObject;
      if lJsonObject <> nil then
      begin
       linnerJObject:=lJsonObject.GetValue(PROT_AUTH) as TJsonObject;
       if linnerJObject <> nil then
       begin
         aUser.isAuthorized:=linnerJObject.GetValue(KEY_AUTHORIZED).Value.ToBoolean;
         aUser.Comments:=linnerJObject.GetValue(KEY_COMMENTS).Value;
         aUser.ClosedSocket:=linnerJObject.GetValue(KEY_SOCK_CLOSE).Value.ToBoolean;
       end;
      end
      else
        TSimpleConnectionProtocol.MsgLog(Format(ERR_NOT_JSON, [aJson]),
         aUser, TMsgType.mtERR, frmSmsClient);


      result:=aUser;
    except
      on E: Exception do
      begin
       TSimpleConnectionProtocol.MsgLog(E.Message, aUser, mtERR, frmSmsClient);
       Exit;
      end;
    end;
end;

class function TSCPJsonFormatter.getJsonConnectionData(aJson: String;
  aUser: TUser): TUser;
var
 lJsonObject: TJsonObject;
 linnerJObject: TJsonObject;
begin
   result:=nil;
    if (aJson.IsEmpty) or (aUser = nil) then Exit;
    try
      lJsonObject:=TJsonObject.ParseJSONValue(aJson) as TJsonObject;
      if lJsonObject <> nil then
      begin
       linnerJObject:=lJsonObject.GetValue('PROT_CONNECTION') as TJsonObject;
       if linnerJObject <> nil then
       begin
         aUser.Comments:=linnerJObject.GetValue('KEY_COMMENTS').Value;
         aUser.ClosedSocket:=linnerJObject.GetValue('KEY_SOCK_CLOSE').Value.ToBoolean;
       end;
      end
      else
        TSimpleConnectionProtocol.MsgLog(Format(ERR_NOT_JSON, [aJson]),
         aUser, TMsgType.mtERR, frmSmsClient);

      result:=aUser;
    except
      on E: Exception do
      begin
       TSimpleConnectionProtocol.MsgLog(E.Message, aUser, mtERR, frmSmsClient);
       Exit;
      end;
    end;
end;

class function TSCPJsonFormatter.getJsonErrorData(aJson: String;
  aUser: TUser): TUser;
var
 lJsonObject: TJsonObject;
 linnerJObject: TJsonObject;
begin
   result:=nil;
    if (aJson.IsEmpty) or (aUser = nil) then Exit;
    try
      lJsonObject:=TJsonObject.ParseJSONValue(aJson) as TJsonObject;
      if lJsonObject <> nil then
      begin
       linnerJObject:=lJsonObject.GetValue('PROT_UNKNOWN') as TJsonObject;
       if linnerJObject <> nil then
       begin
         aUser.ErrMsg:=linnerJObject.GetValue('KEY_ERR_MSG').Value;
         aUser.ErrType:=linnerJObject.GetValue('KEY_ERR_TYPE').Value;
       end;
      end
      else
        TSimpleConnectionProtocol.MsgLog(Format(ERR_NOT_JSON, [aJson]),
         aUser, TMsgType.mtERR, frmSmsClient);

      result:=aUser;
    except
      on E: Exception do
      begin
       TSimpleConnectionProtocol.MsgLog(E.Message, aUser, mtERR, frmSmsClient);
       Exit;
      end;
    end;
end;

class function TSCPJsonFormatter.getJsonGreetingData(aJson: String;
  aUser: TUser): TUser;
var
 lJsonObject: TJsonObject;
 linnerJObject: TJsonObject;
begin
   result:=nil;
    if (aJson.IsEmpty) or (aUser = nil) then Exit;
    try
      lJsonObject:=TJsonObject.ParseJSONValue(aJson) as TJsonObject;
      if lJsonObject <> nil then
      begin
       linnerJObject:=lJsonObject.GetValue('PROT_HELLO') as TJsonObject;
       if linnerJObject <> nil then
       begin
         aUser.isAuthorized:=linnerJObject.GetValue('KEY_AUTHORIZED').Value.ToBoolean;
         aUser.Comments:=linnerJObject.GetValue('KEY_COMMENTS').Value;
         aUser.isEncrypted:=linnerJObject.GetValue('KEY_CRYPT').Value.ToBoolean;
       end;
      end
      else
        TSimpleConnectionProtocol.MsgLog(Format(ERR_NOT_JSON, [aJson]),
         aUser, TMsgType.mtERR, frmSmsClient);

      result:=aUser;
    except
      on E: Exception do
      begin
       TSimpleConnectionProtocol.MsgLog(E.Message, aUser, mtERR, frmSmsClient);
       Exit;
      end;
    end;
end;

class function TSCPJsonFormatter.getJsonSmsData(aJson: String;
  aUser: TUser): TUser;
var
 lJsonObject: TJsonObject;
 linnerJObject: TJsonObject;
 lJsonArray: TJsonArray;
begin
   result:=nil;
    if (aJson.IsEmpty) or (aUser = nil) then Exit;
    try
      lJsonObject:=TJsonObject.ParseJSONValue(aJson) as TJsonObject;
      if lJsonObject <> nil then
      begin
       linnerJObject:=lJsonObject.GetValue('PROT_SMS') as TJsonObject;
       if linnerJObject <> nil then
       begin
         aUser.Status:=linnerJObject.GetValue('KEY_STATUS').Value;
         aUser.Comments:=linnerJObject.GetValue('KEY_COMMENTS').Value;
         aUser.SmsMsg:=linnerJObject.GetValue('KEY_SMS_MSG').Value;
       end;
      end
      else
        TSimpleConnectionProtocol.MsgLog(Format(ERR_NOT_JSON, [aJson]),
         aUser, TMsgType.mtERR, frmSmsClient);

      result:=aUser;
    except
      on E: Exception do
      begin
       TSimpleConnectionProtocol.MsgLog(E.Message, aUser, mtERR, frmSmsClient);
       Exit;
      end;
    end;
end;

end.
