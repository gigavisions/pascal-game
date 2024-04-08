unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TSettingsForm }

    TSettingsForm = class(TForm)
    ToggleBox1: TToggleBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ToggleBox1Click(Sender: TObject);
  private

  public

  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.lfm}

{ TSettingsForm }

procedure TSettingsForm.ToggleBox1Click(Sender: TObject);
begin
   if ToggleBox1.Checked then
     ToggleBox1.Caption:='Dark Mode'
   else
    ToggleBox1.Caption:='Light Mode';
end;

procedure TSettingsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction:=caHide;
end;


end.

