unit Records;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TRecordsForm = class(TForm)
    BackBtn: TButton;
    procedure BackBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecordsForm: TRecordsForm;

implementation

{$R *.fmx}

uses MainMenu;

procedure TRecordsForm.BackBtnClick(Sender: TObject);
begin
    Close;
end;

end.
