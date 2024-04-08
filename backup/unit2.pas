unit PlayUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, SpaceShip, LCLType,
  ExtCtrls;

type

  { TPlayForm }

  TPlayForm = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SelectLevel;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure MoveBullets(ship :Integer; velocity : Integer);

  private

  public
  end;

var
  PlayForm: TPlayForm;
  ShipArray : array of TSpaceShip;
  level : Integer;
  NumOfEnemy: Integer;
  Speed: Integer;
  IsKeyPressed: Boolean;    //this is used to shoot only one bullet on a key down
  MoveDirection: Char;
  Size : Integer;
  DistroyedShip : Integer;

implementation

{$R *.lfm}

{ TPlayForm }

procedure TPlayForm.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  WindowState := wsMaximized;
  Level :=1;
  Timer2.Enabled := True;
  Timer1.Enabled := True;
  SelectLevel;
end;

procedure TPlayForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i,j : Integer;
begin
  Timer2.Enabled := False;
  Timer1.Enabled := False;
  for i:=0 to High(ShipArray) do
  begin
    ShipArray[i].Ship.Free;
    for j:=0 to High(ShipArray[i].BulletsArray) do
        ShipArray[i].BulletsArray[j].Free;
    ShipArray[i].Free;
  end;

  SetLength(ShipArray,0);
end;

procedure TPlayForm.SelectLevel;
var
  i,j: Integer;
begin
  MoveDirection := 'R';
  case level of
  1:
    begin
      NumOfEnemy := 1;
      speed := 25;
      size:=150;
    end;
  2:
    begin
      NumOfEnemy := 2;
      speed := 30;
      size:=100;
    end;
  3:
    begin
      NumOfEnemy := 3;
      speed := 35;
      size:=50;
    end;
  -1:
    begin
      Timer2.Enabled := False;
      Timer1.Enabled := False;
      showmessage('you Loose');
      PlayForm.Close;
    end;
  else
    begin
      Timer2.Enabled := False;
      Timer1.Enabled := False;
      showmessage('you won');
      PlayForm.Close;
    end;
  end;

  for i:=0 to High(ShipArray) do
  begin
    ShipArray[i].Ship.Free;
    for j:=0 to High(ShipArray[i].BulletsArray) do
        ShipArray[i].BulletsArray[j].Free;
    ShipArray[i].Free;
  end;

  SetLength(ShipArray,0);

  SetLength(ShipArray, Length(ShipArray) + 1);
  ShipArray[High(ShipArray)]:= TSpaceShip.Create(PlayForm,PlayForm.Height - 100, 0 );
  ShipArray[0].Ship.Brush.Color:= clBlue;  //index 0 is always the user. others are enemy
  ShipArray[0].Ship.Left := PlayForm.Width-70;

  for i:=1 to NumOfEnemy do
  begin
    SetLength(ShipArray, Length(ShipArray)+1);
    ShipArray[i] := TSpaceShip.Create(PlayForm, 100, (i-1)*200);
    ShipArray[i].Ship.Brush.Color:= clRed;
    ShipArray[i].Ship.Height:=Size;
    ShipArray[i].Ship.Width:=Size;
  end;
end;

procedure TPlayForm.Timer1Timer(Sender: TObject);
var
  i,k: Integer;
begin
  ///////////////////////////////////////////////////////////////
  DistroyedShip:=-1;

  MoveBullets(0,-5);
  for k := 1 to High(ShipArray) do
      MoveBullets(k,+5);

  if DistroyedShip>0 then
      begin
         ShipArray[DistroyedShip].Ship.Free;
         for i:= 0 to High(ShipArray[DistroyedShip].BulletsArray) do
             ShipArray[DistroyedShip].BulletsArray[i].Free;
         SetLength(ShipArray[DistroyedShip].BulletsArray, 0);
         ShipArray[DistroyedShip].Free;
         for k:= DistroyedShip to High(ShipArray) - 1 do
         begin
           ShipArray[k] := ShipArray[k+1];
         end;
         SetLength(ShipArray , Length(ShipArray) - 1);
         if Length(ShipArray) = 1 then
         begin
            Inc(Level);
            SelectLevel;
         end;

      end;
  if DistroyedShip = 0 then
     begin
        Level := -1;
        SelectLevel;
     end;

end;

procedure TPlayForm.Timer2Timer(Sender: TObject);
var
  s : Integer;
begin
  for s:= 1 to High(ShipArray) do
  begin
       if (ShipArray[s].Ship.Left + ShipArray[s].Ship.Width) >= PlayForm.Width then
       begin
          MoveDirection := 'L';
       end
       else if ShipArray[s].Ship.Left <= 0 then
       begin
          MoveDirection := 'R';
       end;
  end;

  for s:= 1 to High(ShipArray) do
  begin
       ShipArray[s].MoveShip(MoveDirection,speed);

       if Abs(ShipArray[0].Ship.Left - ShipArray[s].Ship.Left) < 100 then
          ShipArray[s].Shoot;
  end;

end;

procedure TPlayForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Left) then
     ShipArray[0].MoveShip('L',15);

  if (Key = VK_Right) then
     ShipArray[0].MoveShip('R',15);

  if (Key = VK_SPACE) and (IsKeyPressed = False) then
  begin
         IsKeyPressed := True;
         ShipArray[0].Shoot;
  end;
end;

procedure TPlayForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_SPACE) and (IsKeyPressed = True) then
  begin
         IsKeyPressed := False;
  end;
end;

procedure TPlayForm.MoveBullets(ship :Integer; velocity : Integer);
var
  bullet,j,m,k : Integer;
begin

  for bullet := 0 to High(ShipArray[ship].BulletsArray) do
    begin
      ShipArray[ship].BulletsArray[bullet].Top := ShipArray[ship].BulletsArray[bullet].Top + velocity;
      if ship = 0 then
      begin
         for k:=1 to High(ShipArray) do
           begin
             m := ShipArray[0].BulletsArray[bullet].Left - ShipArray[k].Ship.Left;
             if ((m > 0) and (m < Size) and (ShipArray[0].BulletsArray[bullet].Top < 30+Size))  then
             begin
                  DistroyedShip:= k;
             end;
           end;
      end
      else
      begin
          m := ShipArray[ship].BulletsArray[bullet].Left - ShipArray[0].Ship.Left;
          if ((m > 0) and (m < 50) and (ShipArray[ship].BulletsArray[bullet].Top > ShipArray[0].Ship.Top - 30))  then
             DistroyedShip := 0;
      end;

    end;

  bullet:=0;
  while bullet <= High(ShipArray[ship].BulletsArray) do
    begin
      if (ShipArray[ship].BulletsArray[bullet].Top < 30) or (ShipArray[ship].BulletsArray[bullet].Top > PlayForm.Height-100) then
      begin
        ShipArray[ship].BulletsArray[bullet].Free;

        for j := bullet to High(ShipArray[ship].BulletsArray) - 1 do
          ShipArray[ship].BulletsArray[j] := ShipArray[ship].BulletsArray[j + 1];

        SetLength(ShipArray[ship].BulletsArray, Length(ShipArray[ship].BulletsArray) - 1);
      end
      else
        Inc(bullet);
    end;

end;

end.

