unit uSmsClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,
  FMX.ListBox, FMX.ScrollBox, uUser, FMX.Memo, FMX.Effects, System.ImageList,
  FMX.ImgList, FMX.TabControl, System.Actions, FMX.ActnList, FMX.MultiView,
  FMX.SearchBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Ani;

type
  TfrmSmsClient = class(TForm)
    recContact: TRectangle;
    recToolPanel: TRectangle;
    recSmsMessagePanel: TRectangle;
    mmSmsMessage: TMemo;
    sbSendSms: TSpeedButton;
    Lang1: TLang;
    recMsgLog: TRectangle;
    mmLogger: TMemo;
    lblLogger: TLabel;
    layMain: TLayout;
    tcSmsMessanger: TTabControl;
    tiLoginIn: TTabItem;
    tiChangeUserParams: TTabItem;
    tiMain: TTabItem;
    recMessangerBackground: TRectangle;
    recLogInBackground: TRectangle;
    layProfileLogo: TLayout;
    recUserLogin: TRectangle;
    imgUserLogin: TImage;
    txtSublogoHeader: TText;
    ShadowEffect1: TShadowEffect;
    edUserLogin: TEdit;
    recUserPassword: TRectangle;
    imgUserPassword: TImage;
    edUserPassword: TEdit;
    recServerParams: TRectangle;
    imgServerIP: TImage;
    edServerIP: TEdit;
    txtUserLogin: TText;
    ShadowEffect2: TShadowEffect;
    txtPassword: TText;
    ShadowEffect3: TShadowEffect;
    txtServerIP: TText;
    ShadowEffect4: TShadowEffect;
    cirChangeLogin: TCircle;
    edServerPort_: TEdit;
    cirChangePassword: TCircle;
    recChangeLoginBackground: TRectangle;
    txtLogoFooter: TText;
    ShadowEffect5: TShadowEffect;
    recCurrentLogin: TRectangle;
    edCurrentLogin: TEdit;
    txtOldLogin: TText;
    ShadowEffect6: TShadowEffect;
    recNewLogin: TRectangle;
    edNewLogin: TEdit;
    txtNewLogin: TText;
    ShadowEffect7: TShadowEffect;
    recConformNewLogin: TRectangle;
    edConfirmNewLogin: TEdit;
    txtNewLoginConfirm: TText;
    ShadowEffect8: TShadowEffect;
    txtChangeLoginHeader: TText;
    ShadowEffect9: TShadowEffect;
    ptChangePassword: TPath;
    ptChangeLogin: TPath;
    sbChangeLogin: TSpeedButton;
    imgProfileLogo: TImage;
    sbChangePassword: TSpeedButton;
    sbLoginIn: TSpeedButton;
    recLoginIn: TRectangle;
    Text1: TText;
    sbApplyNewLogin: TSpeedButton;
    recApplyNewLogin: TRectangle;
    txtApplyNewLogin: TText;
    sbBackToLoginIn: TSpeedButton;
    cirBackToLogin: TCircle;
    Path1: TPath;
    ActionList1: TActionList;
    actChangeLogin: TNextTabAction;
    actBackToLogin: TPreviousTabAction;
    actToSmsPanel: TChangeTabAction;
    recAddPhoneContact: TRectangle;
    imgPhoneContactIcon: TImage;
    edPhoneContact: TEdit;
    txtAddPhoneContact: TText;
    sbAddPhoneContact: TSpeedButton;
    cirAddPhoneContact: TCircle;
    ptAddPhoneContact: TPath;
    mvSenderHistory: TMultiView;
    sbContactsHistory: TSpeedButton;
    ReflectionEffect1: TReflectionEffect;
    PasswordEditButton1: TPasswordEditButton;
    aiConnectionProgress: TAniIndicator;
    ReflectionEffect2: TReflectionEffect;
    ReflectionEffect3: TReflectionEffect;
    txtLogoFooter_: TText;
    ShadowEffect10: TShadowEffect;
    recContacsList: TRectangle;
    tiHelp: TTabItem;
    imgHelp: TImage;
    recHelpBackground: TRectangle;
    sbHelpIP: TSpeedButton;
    crHelpIP: TCircle;
    ReflectionEffect4: TReflectionEffect;
    sbLogout: TSpeedButton;
    Circle2: TCircle;
    Path3: TPath;
    sbBackToLogin: TSpeedButton;
    Circle3: TCircle;
    Path4: TPath;
    ReflectionEffect5: TReflectionEffect;
    actBackToLogin_: TChangeTabAction;
    imgContactsHistory: TImage;
    imgSendSms: TImage;
    lbPhoneContactsList: TListBox;
    recContactsListHeader: TRectangle;
    txtPhoneContactsHeader: TText;
    actGoToHelp: TChangeTabAction;
    recHistoryHeader: TRectangle;
    lwHistoryList: TListView;
    lblContactsHistoryHeader: TLabel;
    imgPhnneContactsList: TImage;
    bsSmsSendingHistory: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    GradientAnimation1: TGradientAnimation;
    ShadowEffect11: TShadowEffect;
    recSmsMsgText: TRectangle;
    lblSmsMsgText: TLabel;
    recSmsMessage: TRectangle;
    sbGetPhonesList: TSpeedButton;
    imgGetPhoneList: TImage;
    recSendingName: TRectangle;
    edSendingName: TEdit;
    txtSendingName: TText;
    StyleBook1: TStyleBook;
    chbSaveSmsSending: TCheckBox;
    sbDelHistoryItem: TSpeedButton;
    LinkPropertyToFieldTag: TLinkPropertyToField;
    imgSmsSenderHistory: TImage;
    LinkPropertyToFieldTagString: TLinkPropertyToField;
    sbDeleteContactItem: TSpeedButton;
    procedure sbSendSmsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbChangeLoginClick(Sender: TObject);
    procedure sbChangePasswordClick(Sender: TObject);
    procedure sbLoginInClick(Sender: TObject);
    procedure sbBackToLoginInClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbApplyNewLoginClick(Sender: TObject);
    procedure sbLogoutClick(Sender: TObject);
    procedure sbHelpIPClick(Sender: TObject);
    procedure sbBackToLoginClick(Sender: TObject);
    procedure sbAddPhoneContactClick(Sender: TObject);
    procedure sbGetPhonesListClick(Sender: TObject);
    procedure lwHistoryListClick(Sender: TObject);
    procedure sbDelHistoryItemClick(Sender: TObject);
    procedure lwHistoryListItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure sbDeleteContactItemClick(Sender: TObject);
    procedure lbPhoneContactsListItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure edPhoneContactKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edConfirmNewLoginKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    FUser: TUser;
    procedure SetUser(const Value: TUser);
    { Private declarations }
    property User: TUser read FUser write SetUser;
    procedure InitLoginTab;
    procedure HideTabControl;

    procedure InitChangeAccountParamsHeaders(isLoginChanging: Boolean = true);
    procedure InitUserAccountSetts;
    procedure SetOldAccountParamValue(aValue: String);
    procedure SetNewValueOfSignField(aValue: String; isLogin: Boolean);
    procedure CheckUserForUpdateAccount(aUser: TUSer; isLogin: Boolean = true);
    function CompareUserParams(var aValue: String): Boolean;
    function UpdateUserAccountParam(aUser: TUser): Boolean;

    function GetPhoneListFromTxtFile: TArray<String>;

    function IsSaveSmsSendingToDB: Boolean;

    procedure GetHistorySmsSending(aUser: TUser);
    procedure DeleteHistoryItem();
    procedure ClearContactsList;

    procedure SetLockColorContactMarkerForBtn(isLock: Boolean);
    function IsRepeatingContact(aPhone: String): Boolean;
  public
    { Public declarations }
    procedure GoToChangeUserAccount;
    procedure BackToLogInServer;
    procedure BackToLogInServer_;
    procedure GoToSmsPanel;
    procedure GoToHelp;

    procedure SetEnabledSendSmsButton(aEnabled: Boolean);
    procedure ConnProgressAnim(aiProgress: TAniIndicator; aStart: Boolean);

    function GetTabIndex: Integer;
    procedure SetTabIndex(aTabIndex: Integer);

    function GetContactsPhoneList: TStrings;
    procedure ContactsPhoneListCount(aCnt: Integer);

    procedure AddPhoneContactItem(aPhoneNumber: String);

    procedure FillHistoryContacts;
    procedure ClearHistoryList;
    procedure EndUpdateHistoryList;
    procedure EnabledHistoryListBindSource(aEnabled: Boolean = true);
    procedure AddNewContactsHistory(aName: String);
  end;

  const
    LOGIN_HEADER = '������ ������';
    LOGIN_CURRENT = '������� �����';
    LOGIN_NEW = '����� �����';
    LOGIN_NEW_CONFIRM = '����������� �����';

    PASS_HEADER = '������ ������';
    PASS_CURRENT = '������� ������';
    PASS_NEW = '����� ������';
    PASS_NEW_CONFIRM = '����������� ������';


var
  frmSmsClient: TfrmSmsClient;

implementation

{$R *.fmx}

uses uDM, uSimpleConnectionProtocol;



procedure TfrmSmsClient.AddNewContactsHistory(aName: String);
var
 _contacts: String;
begin
  if (FUser.UserId <= 0) or (aName.IsEmpty) then Exit;
  

  _contacts:=DM.GetJsonContactHistory(GetContactsPhoneList);
 // DM.AddNewContactsHistory(aName, _contacts, FUser.UserId);
  DM.AddOrUpdateContactsHistory(aName, _contacts, FUser.UserId);
end;

procedure TfrmSmsClient.AddPhoneContactItem(aPhoneNumber: String);
var
 lItem: TListboxItem;
begin
  if (aPhoneNumber.Trim.IsEmpty) or (aPhoneNumber.Trim.Length < 6) then Exit;

  lbPhoneContactsList.MultiSelect:=false;

  lbPhoneContactsList.BeginUpdate;
  try
   lItem:=TListboxItem.Create(lbPhoneContactsList);
   lItem.Parent:=lbPhoneContactsList;
   lItem.StyleLookup:='listboxitemrightdetail';
   lItem.Height:=31;
   lItem.Text:=aPhoneNumber;

       if TStyledSetting.Style in lItem.StyledSettings then
       begin
         lItem.StyledSettings := lItem.StyledSettings - [TStyledSetting.FontColor];
         lItem.StyledSettings := lItem.StyledSettings - [TStyledSetting.Size];
       end;
       lItem.TextSettings.Font.Size:=16;
       lItem.TextSettings.FontColor:=TAlphaColorRec.White;
       lItem.TextSettings.Font.Style:=[TFontStyle.fsBold];

   lbPhoneContactsList.AddObject(lItem);

   ContactsPhoneListCount(GetContactsPhoneList.Count);
  finally
   lbPhoneContactsList.EndUpdate;
  end;
end;

procedure TfrmSmsClient.BackToLogInServer;
begin
  actBackToLogin.Execute;
end;



function TfrmSmsClient.CompareUserParams(var aValue: String): Boolean;
begin
  result:=false;
  if edNewLogin.Text.IsEmpty or edConfirmNewLogin.Text.IsEmpty then Exit;

  aValue:=edNewLogin.Text;
  result:=edNewLogin.Text.Equals(edConfirmNewLogin.Text);
end;



procedure TfrmSmsClient.BackToLogInServer_;
begin
  actBackToLogin_.Execute;
end;

procedure TfrmSmsClient.CheckUserForUpdateAccount(aUser: TUser; isLogin: Boolean);
begin
 if aUser = nil then Exit;

 InitUserAccountSetts;
 aUser.UserId:=DM.CheckUserId(aUser);
 if aUser.UserId > 0 then
 begin
   InitChangeAccountParamsHeaders(isLogin);
   if not isLogin then
     SetOldAccountParamValue(aUser.Password)
   else
     SetOldAccountParamValue(aUser.Login);

   sbLoginIn.Tag:=byte(isLogin); //������� ������ ������
   GoToChangeUserAccount;
 end
 else
   TSimpleConnectionProtocol.MsgLog(WARN_UNCKNOWN_USER, nil, mtErr_, nil);
end;




procedure TfrmSmsClient.ClearContactsList;
begin
  lbPhoneContactsList.Clear;
end;

procedure TfrmSmsClient.ClearHistoryList;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    lwHistoryList.BeginUpdate;
    lwHistoryList.Items.Clear;
  end);
end;



procedure TfrmSmsClient.ConnProgressAnim(aiProgress: TAniIndicator;
  aStart: Boolean);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    aiProgress.Enabled:=aStart;
    aiProgress.Visible:=aStart;
  end);
end;



procedure TfrmSmsClient.ContactsPhoneListCount(aCnt: Integer);
begin
 txtPhoneContactsHeader.Text:=Format(HEADER_CONTACTS_LIST, [aCnt]);
end;

procedure TfrmSmsClient.DeleteHistoryItem;
begin
   if (lwHistoryList.Selected = nil)  then Exit;

   if DM.DeleteHistoryItem(sbDelHistoryItem.Tag) then
     DM.fdQGetHistorySmsSending.Refresh
   else
     TSimpleConnectionProtocol.MsgDlg(ERR_CANT_DELETE_HISTORY_ITEM);
end;

procedure TfrmSmsClient.edConfirmNewLoginKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 {$IFDEF MSWINDOWS}
   if Key = 13 then
     sbApplyNewLoginClick(Sender);
 {$endif}
end;

procedure TfrmSmsClient.edPhoneContactKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  {$IFDEF MSWINDOWS}
   if Key = 13 then
     sbAddPhoneContactClick(Sender);
  {$ENDIF}
end;

procedure TfrmSmsClient.EnabledHistoryListBindSource(aEnabled: Boolean);
begin
  TThread.Queue(nil,
  procedure
  begin
     bsSmsSendingHistory.DataSource.Enabled:=aEnabled;
  end);
end;

procedure TfrmSmsClient.EndUpdateHistoryList;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
   lwHistoryList.EndUpdate;
  end);
end;

procedure TfrmSmsClient.FillHistoryContacts;
begin

end;

procedure TfrmSmsClient.FormCreate(Sender: TObject);
begin
  FUser:=TUser.Create;
  HideTabControl;
  InitLoginTab;
end;



procedure TfrmSmsClient.FormDestroy(Sender: TObject);
begin
  FUser.free;
  FUser:=nil;
end;

procedure TfrmSmsClient.FormShow(Sender: TObject);
begin
  InitUserAccountSetts;
end;


function TfrmSmsClient.GetContactsPhoneList: TStrings;
begin

  result:=lbPhoneContactsList.Items;
end;



procedure TfrmSmsClient.GetHistorySmsSending(aUser: TUser);
begin
  if aUser = nil then Exit;

  EnabledHistoryListBindSource(false);
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
     aUser.UserId:=DM.CheckUserId(aUser);
     DM.GetHistorySmsSending(aUser.UserId);
    finally
      EnabledHistoryListBindSource;
      EndUpdateHistoryList
    end;
  end).Start;
end;

function TfrmSmsClient.GetTabIndex: Integer;
begin
  result:=tcSmsMessanger.TabIndex;
end;

procedure TfrmSmsClient.GoToChangeUserAccount;
begin
  actChangeLogin.Execute;
end;

procedure TfrmSmsClient.GoToHelp;
begin
  actGoToHelp.Execute;
end;

procedure TfrmSmsClient.GoToSmsPanel;
begin
  actToSmsPanel.Execute;
end;

procedure TfrmSmsClient.HideTabControl;
begin
  tcSmsMessanger.TabPosition:=TTabPosition.None;
end;

procedure TfrmSmsClient.InitChangeAccountParamsHeaders(
  isLoginChanging: Boolean);
begin
 if isLoginChanging then
 begin
   txtChangeLoginHeader.Text:=LOGIN_HEADER;
   txtOldLogin.Text:=LOGIN_CURRENT;
   txtNewLogin.Text:=LOGIN_NEW;
   txtNewLoginConfirm.Text:=LOGIN_NEW_CONFIRM;
 end
 else
 begin
   txtChangeLoginHeader.Text:=PASS_HEADER;
   txtOldLogin.Text:=PASS_CURRENT;
   txtNewLogin.Text:=PASS_NEW;
   txtNewLoginConfirm.Text:=PASS_NEW_CONFIRM;
 end;
end;

procedure TfrmSmsClient.InitUserAccountSetts;
begin
     //FUser.Tels.Clear;
     FUser.isAuthorized:=false;
     FUser.SmsMsg:=String.Empty;
     FUser.ErrMsg:=String.Empty;
     FUser.ErrType:=String.Empty;

     FUser.Login:=edUserLogin.Text;
     FUser.Password:=edUserPassword.Text;

     FUser.ipAddress:=edServerIP.Text;
     FUser.Port:=edServerPort_.Text.ToInteger;
end;

function TfrmSmsClient.IsRepeatingContact(aPhone: String): Boolean;
var
 isOk: Boolean;
begin
 isOk:=(GetContactsPhoneList.IndexOf(aPhone.Trim) >=0) or (aPhone.IsEmpty);
 SetLockColorContactMarkerForBtn(isOk);
 result:=isOk;
end;

function TfrmSmsClient.IsSaveSmsSendingToDB: Boolean;
begin
  result:=chbSaveSmsSending.IsChecked;
end;

procedure TfrmSmsClient.lbPhoneContactsListItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
   sbDeleteContactItem.Enabled:=(lbPhoneContactsList.Selected <> nil);
end;

procedure TfrmSmsClient.lwHistoryListClick(Sender: TObject);
begin
  sbDelHistoryItem.Enabled:=(lwHistoryList.Selected <> nil);
end;

procedure TfrmSmsClient.lwHistoryListItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
 if lwHistoryList.Selected <> nil then
   if not sbDelHistoryItem.TagString.IsEmpty then
   begin
     ClearContactsList;
     DM.GetContactHistoryFromJson(sbDelHistoryItem.TagString);
     mvSenderHistory.HideMaster;
   end;
end;

function TfrmSmsClient.GetPhoneListFromTxtFile: TArray<String>;
var
 lStr: TStrings;
begin
  result:=nil;
  {$IFDEF MSWINDOWS}
    if DM.odTelList.Execute then
    begin
     lStr:=DM.GetPhonesListFromTxtFile(DM.odTelList.FileName);
     if lStr <> nil then
     begin
      if pos(';', lStr.Text) <> 0 then
          result:=lStr.Text.Split([';']);
     end;
    end;
  {$ENDIF}
end;

procedure TfrmSmsClient.InitLoginTab;
begin
  SetTabIndex(0);
end;



procedure TfrmSmsClient.sbAddPhoneContactClick(Sender: TObject);
begin
 if not IsRepeatingContact(edPhoneContact.Text.Trim) then
  AddPhoneContactItem(edPhoneContact.Text.Trim);
end;

procedure TfrmSmsClient.sbApplyNewLoginClick(Sender: TObject);
var
 lchParam: String;
begin
  if CompareUserParams(lchParam) then
  begin
    if DM.UpdateUserParam(lchParam, FUser.UserId, boolean(sbLoginIn.Tag)) then
    begin
       SetNewValueOfSignField(lchParam, boolean(sbLoginIn.Tag));
       BackToLogInServer;
       TSimpleConnectionProtocol.MsgDlg(INFO_ACCOUNT_PARAMS_WERE_CHANGED);
    end;
  end
  else
    TSimpleConnectionProtocol.MsgDlg(WARN_NOT_EQUALS_OF_FIELDS);
end;



procedure TfrmSmsClient.sbBackToLoginInClick(Sender: TObject);
begin
   BackToLogInServer;
end;



procedure TfrmSmsClient.sbChangeLoginClick(Sender: TObject);
begin
   CheckUserForUpdateAccount(FUser);
end;



procedure TfrmSmsClient.sbChangePasswordClick(Sender: TObject);
begin
   CheckUserForUpdateAccount(FUser, false);
end;




procedure TfrmSmsClient.sbDeleteContactItemClick(Sender: TObject);
begin
  if lbPhoneContactsList.Selected <> nil then
    lbPhoneContactsList.Items.Delete(lbPhoneContactsList.Selected.Index);

  sbDeleteContactItem.Enabled:=(lbPhoneContactsList.Selected <> nil);
  ContactsPhoneListCount(GetContactsPhoneList.Count);
end;

procedure TfrmSmsClient.sbDelHistoryItemClick(Sender: TObject);
begin
   DeleteHistoryItem;
end;

procedure TfrmSmsClient.sbGetPhonesListClick(Sender: TObject);
var
 _PhoneList: TArray<String>;
 _Phone: String;

 function IsNumberStr(s: string) : boolean;
 var hasNum: boolean;
    i: integer;
 begin
  hasNum := true;

  for i := 1 to length(s) do
    if not (s[i] in ['0'..'9','+']) then
    begin
      result:=false;
      break;
    end;

 end;
begin
  _PhoneList:=GetPhoneListFromTxtFile;

  if (_PhoneList = nil) or (Length(_PhoneList) = 0) then
  begin
   TSimpleConnectionProtocol.MsgDlg(WARN_EMPTY_PHONE_LIST_IN_FILE);
   Exit;
  end;

  for _Phone in _PhoneList do
  begin
     if IsNumberStr(_Phone) then
       AddPhoneContactItem(_Phone.Trim);
  end;
end;

procedure TfrmSmsClient.sbHelpIPClick(Sender: TObject);
begin
  GoToHelp;
end;

procedure TfrmSmsClient.sbLoginInClick(Sender: TObject);
begin
     FUser.Comments:=MSG_COMMENT_GREATING_SERVER_TEST;
     InitUserAccountSetts;

     GetHistorySmsSending(FUser);

     DM.SendSMS(frmSmsClient, FUser, true);
end;


procedure TfrmSmsClient.sbSendSmsClick(Sender: TObject);
begin

  if (mmSmsMessage.Text.IsEmpty) then
  begin
    TSimpleConnectionProtocol.MsgDlg(WARN_EMPTY_SMS_MESSAGE);
    Exit;
  end;

  if lbPhoneContactsList.Items.Count <= 0 then
  begin
    TSimpleConnectionProtocol.MsgDlg(WARN_EMPTY_CONTACTS_LIST);
    Exit;
  end;

     InitUserAccountSetts;
     FUser.Tels:=GetContactsPhoneList;
     FUser.Comments:=MSG_COMMENT_GREATING_SERVER;
     FUser.SmsMsg:=mmSmsMessage.Text;
     DM.SendSMS(frmSmsClient, FUser);

   if IsSaveSmsSendingToDB then
   begin
    AddNewContactsHistory(edSendingName.Text);
    GetHistorySmsSending(FUser);
   end;
end;




procedure TfrmSmsClient.SetEnabledSendSmsButton(aEnabled: Boolean);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
     sbSendSms.Enabled:=aEnabled;
  end);
end;



procedure TfrmSmsClient.SetLockColorContactMarkerForBtn(isLock: Boolean);
begin
 if isLock then
  cirAddPhoneContact.Fill.Color:=TAlphaColorRec.Red
 else
  cirAddPhoneContact.Fill.Color:=TAlphaColorRec.Royalblue;
end;

procedure TfrmSmsClient.SetNewValueOfSignField(aValue: String;
  isLogin: Boolean);
begin
  if isLogin then
    edUserLogin.Text:=aValue
  else
    edUserPassword.Text:=aValue;
end;

procedure TfrmSmsClient.SetOldAccountParamValue(aValue: String);
begin
  edCurrentLogin.Text:=aValue;
end;



procedure TfrmSmsClient.SetTabIndex(aTabIndex: Integer);
begin
  tcSmsMessanger.TabIndex:=aTabIndex;
end;



procedure TfrmSmsClient.SetUser(const Value: TUser);
begin
  FUser := Value;
end;

procedure TfrmSmsClient.sbBackToLoginClick(Sender: TObject);
begin
  BackToLogInServer_;
end;

procedure TfrmSmsClient.sbLogoutClick(Sender: TObject);
begin
   BackToLogInServer_;
end;

function TfrmSmsClient.UpdateUserAccountParam(aUser: TUser): Boolean;
begin

end;

end.
