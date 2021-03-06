unit RecordsUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
    FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, Mmsystem,
    FMX.Grid, LinkedList;

type

    TPlayer = record
        Name: String[11];
        Score: String[4];
    end;

    TRecordsForm = class(TForm)
        BackBtn: TButton;
        Label6: TLabel;
        PaceLbl: TLabel;
        ScoreValueLbl: TLabel;
        PlayerNameLbl: TLabel;
        procedure BackBtnClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
    public
        RecordsFile: File of TPlayer;
        RecordsDataBase: array [0..4] of TPlayer;
    end;

var
    RecordsForm: TRecordsForm;

implementation

{$R *.fmx}

uses MainMenuUnit;

procedure TRecordsForm.BackBtnClick(Sender: TObject);
begin
    RecordsForm.Close;
end;

procedure TRecordsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    StartMenu.Show;
end;

procedure TRecordsForm.FormCreate(Sender: TObject);
var
    i: Byte;
    Temp: TPlayer;
begin
    AssignFile(RecordsFile, 'DontTouch.pcm');
    try
        Reset(RecordsFile);
    except
        Rewrite(RecordsFile);
    end;
    Temp.Name := '...........';
    Temp.Score := '0000';
    i := 0;
    for i := 0 to 4 do
        if not(Eof(RecordsFile)) then
            Read(RecordsFile, RecordsDataBase[i])
        else
            RecordsDataBase[i] := Temp;
    CloseFile(RecordsFile);
end;

procedure TRecordsForm.FormShow(Sender: TObject);
var
    i: ShortInt;
    Temp: TPlayer;
begin
    PlayerNameLbl.Text := '';
    ScoreValueLbl.Text := '';
    for i := 0 to 4 do
    begin
        PlayerNameLbl.Text := PlayerNameLbl.Text + RecordsDataBase[i].Name + #13#10;
        ScoreValueLbl.Text := ScoreValueLbl.Text + RecordsDataBase[i].Score + #13#10;
    end;
end;

end.
