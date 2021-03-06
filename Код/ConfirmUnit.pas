unit ConfirmUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.StdCtrls,
    FMX.Controls.Presentation, FMX.Edit, RecordsUnit;

type
    TConfirmForm = class(TForm)
        NameEdit: TEdit;
        ConfirmLbl: TLabel;
        ConfirmBtn: TButton;
        procedure ConfirmBtnClick(Sender: TObject);
        procedure NameEditKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
        procedure NameEditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    end;

var
    ConfirmForm: TConfirmForm;

implementation

{$R *.fmx}

uses GameUnit;

procedure TConfirmForm.ConfirmBtnClick(Sender: TObject);
var
    i: Byte;
begin
    if ConfirmBtn.Text = 'Confirm' then
        With RecordsForm do
        begin
            for i := 3 Downto 0 do
                RecordsDataBase[i + 1] := RecordsDataBase[i];
            RecordsDataBase[0].Name := NameEdit.Text;
            RecordsDataBase[0].Score := Field.ScoreValueLbl.Text;
            Rewrite(RecordsFile);
            for i := 0 to 4 do
                if not(RecordsDataBase[i].Name = '...........') then
                    Write(RecordsFile, RecordsDataBase[i]);
            CloseFile(RecordsFile);
        end;
    Close;
end;

procedure TConfirmForm.NameEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    if Length(NameEdit.Text) > 11 then
        KeyChar := #0;
end;

procedure TConfirmForm.NameEditKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    if Length(NameEdit.Text) > 0 then
        ConfirmBtn.Enabled := true
    else
        ConfirmBtn.Enabled := false;
end;

end.
