program SmsClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  uSmsClient in 'uSmsClient.pas' {frmSmsClient},
  uDM in 'uDM.pas' {DM: TDataModule},
  uSimpleConnectionProtocol in 'Model\uSimpleConnectionProtocol.pas',
  uUser in 'User\uUser.pas',
  uScpJsonFormatter in 'Model\ScpJsonFormatter\uScpJsonFormatter.pas',
  uSCP in 'Model\uSCP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSmsClient, frmSmsClient);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
