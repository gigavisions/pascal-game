unit SpaceShip;

interface

uses
  ExtCtrls, Graphics, LCLType, Forms;

type
  TSpaceShip = class
  Ship : TShape;
  BulletsArray: array of TShape;
  PForm : TForm;

  private

  public
    constructor Create(ParentForm: TForm; TopPos : Integer; LeftPos : Integer );
    procedure MoveShip(Direction: Char ; speed: Integer);
    procedure Shoot;
  end;

implementation

{ TMyClass }

constructor TSpaceShip.Create(ParentForm: TForm ; TopPos : Integer; LeftPos : Integer) ;
begin
     PForm := ParentForm;
     Ship := TShape.Create(PForm);
     Ship.Parent := PForm;
     Ship.Top := TopPos;
     Ship.Left := LeftPos;
     Ship.Width := 50;
     Ship.Height := 50;
     Ship.Visible := True;

     SetLength(BulletsArray, 0);


end;

procedure TSpaceShip.MoveShip(Direction: Char ; speed: Integer);
begin
    if(Direction = 'L') and (Ship.Left >= 15) then
                 Ship.Left := Ship.Left - Speed;
    if(Direction = 'R') and (Ship.Left + Ship.Width <= PForm.Width - 15) then
                 Ship.Left := Ship.Left + Speed;
end;

procedure TSpaceShip.Shoot;
var
  Bullet: TShape;
begin
  SetLength(BulletsArray, Length(BulletsArray) + 1);
  Bullet := TShape.Create(PForm);

  Bullet.Parent := PForm;
  Bullet.Width := 10;
  Bullet.Height := 50;
  Bullet.Top := Ship.Top;
  Bullet.Left := Ship.Left + Round(ship.Width/2);
  Bullet.Brush.Color := clYellow;

  BulletsArray[High(BulletsArray)] := Bullet;
end;

end.


