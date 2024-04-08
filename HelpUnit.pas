unit HelpUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { THelpForm }

  THelpForm = class(TForm)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

{ THelpForm }

procedure THelpForm.FormCreate(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

end.

