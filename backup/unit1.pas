unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, unit2, unit3, unit5, HelpUnit;

type

  { TMainForm }

    TMainForm = class(TForm)
    PlayBtn: TButton;
    CreditsBtn: TButton;
    HelpBtn: TButton;
    SettingsBtn: TButton;
    procedure CreditsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm : TMainForm;
  settingsClicked: Boolean;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.PlayBtnClick(Sender: TObject);
begin
     try
        Application.CreateForm(TForm2, Form2);
        if settingsClicked then
           Form2.DarkMode := Form3.ToggleBox1.Checked;
        Form2.Show;
     finally
     end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  settingsClicked:= False;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
   Application.CreateForm(THelpForm, HelpForm);
   HelpForm.Show;
end;

procedure TMainForm.CreditsBtnClick(Sender: TObject);
begin
   Application.CreateForm(TForm5, Form5);
   Form5.Show;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
    try
        Application.CreateForm(TForm3, Form3);
        Form3.Show;
        settingsClicked:=True;
     finally
     end;
end;

end.

