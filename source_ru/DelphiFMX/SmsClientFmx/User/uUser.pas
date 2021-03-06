unit uUser;

interface
 uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types;

  Type
    TUser = class
  private
    FipAddress: String;
    fPort: WORD;
    FErrMsg: String;
    FErrType: String;
    FSmsMsg: String;
    FPassword: String;
    FLogin: String;
    FComments: String;
    FisAuthorized: Boolean;
    FTels: TStrings;
    FisEncrypted: Boolean;
    FCmdMsg: String;
    FClosedSocket: Boolean;
    FStatus: String;
    FUserId: Integer;
    procedure SetipAddress(const Value: String);
    procedure setPort(const Value: WORD);
    procedure SetErrMsg(const Value: String);
    procedure SetErrType(const Value: String);
    procedure SetComments(const Value: String);
    procedure SetLogin(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetSmsMsg(const Value: String);
    procedure SetAuthorized(const Value: Boolean);
    procedure SetTels(const Value: TStrings);
    procedure SetEncrypted(const Value: Boolean);
    procedure SetClosedSocket(const Value: Boolean);
    procedure SetCmdMsg(const Value: String);
    procedure SetStatus(const Value: String);
    procedure SetUserId(const Value: Integer);

     public
       Constructor Create;
       Destructor Destroy;

       property ipAddress: String read FipAddress write SetipAddress;
       property Port: WORD read fPort write setPort;

       property SmsMsg: String read FSmsMsg write SetSmsMsg;
       property Comments: String read FComments write SetComments;
       property Status: String read FStatus write SetStatus;

       property isAuthorized: Boolean read FisAuthorized write SetAuthorized;
       property isEncrypted: Boolean read FisEncrypted write SetEncrypted;
       property ClosedSocket: Boolean read FClosedSocket write SetClosedSocket;

       property Login: String read FLogin write SetLogin;
       property Password: String read FPassword write SetPassword;

       property Tels: TStrings read FTels write SetTels;

       property ErrType: String read FErrType write SetErrType;
       property ErrMsg: String read FErrMsg write SetErrMsg;
       property CmdMsg: String read FCmdMsg write SetCmdMsg;
       property UserId: Integer read FUserId write SetUserId;
    end;

implementation

{ TUser }

constructor TUser.Create;
begin
   FTels:=TStringList.Create;
end;

destructor TUser.Destroy;
begin
   FTels.Free;
   FTels:=nil;
end;

procedure TUser.SetAuthorized(const Value: Boolean);
begin
  FisAuthorized := Value;
end;

procedure TUser.SetClosedSocket(const Value: Boolean);
begin
  FClosedSocket := Value;
end;

procedure TUser.SetCmdMsg(const Value: String);
begin
  FCmdMsg := Value;
end;

procedure TUser.SetComments(const Value: String);
begin
  FComments := Value;
end;

procedure TUser.SetEncrypted(const Value: Boolean);
begin
  FisEncrypted := Value;
end;

procedure TUser.SetErrMsg(const Value: String);
begin
  FErrMsg := Value;
end;

procedure TUser.SetErrType(const Value: String);
begin
  FErrType := Value;
end;

procedure TUser.SetipAddress(const Value: String);
begin
  FipAddress := Value;
end;

procedure TUser.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TUser.SetPassword(const Value: String);
begin
  FPassword := Value;
end;

procedure TUser.setPort(const Value: WORD);
begin
  fPort := Value;
end;

procedure TUser.SetSmsMsg(const Value: String);
begin
  FSmsMsg := Value;
end;

procedure TUser.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TUser.SetTels(const Value: TStrings);
begin
  FTels := Value;
end;

procedure TUser.SetUserId(const Value: Integer);
begin
  FUserId := Value;
end;

end.
