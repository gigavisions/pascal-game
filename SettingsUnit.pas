unit SettingsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TSettingsForm }

    TSettingsForm = class(TForm)
    ToggleBox1: TToggleBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
   begin
     ToggleBox1.Caption:='Dark Mode';
     SettingsForm.Color:=clBlack;
   end
   else
   begin
    ToggleBox1.Caption:='Light Mode';
    SettingsForm.Color:=clWhite;
   end;
end;

procedure TSettingsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction:=caHide;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  WindowState := wsMaximized;
end;


end.
