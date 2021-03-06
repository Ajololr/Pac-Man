unit LinkedList;

interface

type
    PNode = ^TNode;
    TNode = record
        Name: String[11];
        Value: SmallInt;
        Next: PNode;
    end;

    TMyList = class
        Head: PNode;
        constructor Create;
        procedure Add(Name: String; Value: SmallInt);
        procedure Delete;
    end;

implementation

constructor TMyList.create;
begin
    Head := nil;
end;

procedure TMyList.Add(Name: String; Value: SmallInt);
var
    Temp: PNode;
begin
    New(Temp);
    Temp^.Name := Name;
    Temp^.Value := Value;
    Temp^.Next := Head;
    Head := Temp;
end;

procedure TMyList.Delete;
begin
    Head^.Next^.Next^.Next^.Next^.Next := nil;
end;

end.