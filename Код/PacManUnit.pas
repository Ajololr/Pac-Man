unit PacManUnit;

interface

type
    TPos = record
        X: Byte;
        Y: Byte;
    end;

    TPacMan = class
    public
        Pos: TPos;
        Lifes: Byte;
        procedure Move(NewY, NewX: Byte);
        //procedure Stop();
    end;

implementation

uses GameUnit;

procedure TPacMan.Move(NewY, NewX);
begin
    if NewY <> PacMan.Pos.Y then
    begin
        TField.PacMoveAnimation.PropertyName := 'Position.Y';
        TField.PacMoveAnimation.StopValue := NewY * 20;
    end
    else
    begin
        TField.PacMoveAnimation.PropertyName := 'Position.X';
        TField.PacMoveAnimation.StopValue := NewX * 20;
    end;
    TField.PacMoveAnimation.Enabled := true;
end;

{procedure Stop();
begin
    //
end;}

end.
