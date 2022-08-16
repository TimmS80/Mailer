unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, XMailer;

type

  { TForm1 }

  TForm1 = class(TForm)
    CmdRemoveAttachment: TButton;
    CmdSendMail: TButton;
    CmdAddAttachment: TButton;
    ChkSSL: TCheckBox;
    ChkTLS: TCheckBox;
    TxtSender: TLabeledEdit;
    TxtReceiver: TLabeledEdit;
    TxtSubject: TLabeledEdit;
    TxtUsername: TLabeledEdit;
    TxtPassword: TLabeledEdit;
    TxtHost: TLabeledEdit;
    TxtPort: TLabeledEdit;
    LstAttachments: TListBox;
    TxtMessage: TMemo;
    DlgSelectAttachment: TOpenDialog;
    procedure CmdRemoveAttachmentClick(Sender: TObject);
    procedure CmdSendMailClick(Sender: TObject);
    procedure CmdAddAttachmentClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CmdSendMailClick(Sender: TObject);
var
    Mail: TSendMail;
    oneAttachment: string;
begin
  Mail := TSendMail.Create;
  try
    // Mail
    Mail.Sender := TxtSender.Text;
    Mail.Receivers.Add(TxtReceiver.Text);
    Mail.Subject := TxtSubject.Text;
    Mail.Message.Add(TxtMessage.Text);
    for oneAttachment in LstAttachments.Items do
      Mail.Attachments.Add(oneAttachment);

    // SMTP
    Mail.Smtp.UserName := TxtUsername.Text;
    Mail.Smtp.Password := TxtPassword.Text;
    Mail.Smtp.Host := TxtHost.Text;
    Mail.Smtp.Port := TxtPort.Text;

    //Mail.Smtp.SSL := True;
    mail.Smtp.FullSSL:= ChkSSL.Checked;
    Mail.Smtp.TLS := ChkTLS.Checked;
    Mail.Send;
    ShowMessage('SUCCESS :) ');
  {except
    on E:Exception do

  end;}
  finally
    Mail.Free;
  end;
end;

procedure TForm1.CmdRemoveAttachmentClick(Sender: TObject);
begin
  LstAttachments.DeleteSelected;
end;

procedure TForm1.CmdAddAttachmentClick(Sender: TObject);
begin
  if DlgSelectAttachment.Execute then
    LstAttachments.AddItem(DlgSelectAttachment.FileName, nil);
end;

end.

