unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, PlayUnit, HelpUnit, SettingsUnit, CreditsUnit;

type

  { TMainForm }

    TMainForm = class(TForm)
    PlayBtn: TButton;
    CreditsBtn: TButton;
    HelpBtn: TButton;
    SettingsBtn: TButton;
    procedure CreditsBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;
  Mode: Boolean;

implementation

{$R *.lfm}

{ TMainForm }
procedure TMainForm.FormCreate(Sender: TObject);
begin
     WindowState := wsMaximized;
  Mode:=True;
end;

procedure TMainForm.PlayBtnClick(Sender: TObject);
begin
     try
        Application.CreateForm(TPlayForm, PlayForm);
        if Mode then
        PlayForm.Color:=clBlack;
        PlayForm.Show;
     finally
     end;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
   Application.CreateForm(THelpForm, HelpForm);
   if Mode then
   begin
   HelpForm.StaticText1.Font.Color:=clWhite;
   HelpForm.StaticText2.Font.Color:=clWhite;
   HelpForm.Color:=clBlack;
   end;
   HelpForm.Show;
end;

procedure TMainForm.CreditsBtnClick(Sender: TObject);
begin
   Application.CreateForm(TCreditsForm, CreditsForm);
   if Mode then
   CreditsForm.Color:= clBlack;
   CreditsForm.Show;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
     Mode := SettingsForm.ToggleBox1.Checked;
     if Mode then
     begin
     MainForm.Color := clBlack;
     end
     else
     MainForm.Color := clWhite;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
    Application.CreateForm(TSettingsForm, SettingsForm);
    settingsForm.ToggleBox1.Checked:= Mode;
    if Mode then
    SettingsForm.Color:=clBlack;
    SettingsForm.Show;
end;

end.

