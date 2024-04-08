unit CreditsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type

  { TCreditsForm }

  TCreditsForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  CreditsForm: TCreditsForm;

implementation

{$R *.lfm}

{ TCreditsForm }

procedure TCreditsForm.FormCreate(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

end.

