unit MainMenu;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
    FMX.Controls.Presentation, FMX.Objects, FMX.Ani, Vcl.Dialogs, Mmsystem;

type
    TStartMenu = class(TForm)
        RecordsBtn: TButton;
        AboutBtn: TButton;
        ExitBtn: TButton;
        PacMoveAnimation: TFloatAnimation;
        Background: TImage;
        BackgroundAnimation: TBitmapListAnimation;
        Logo: TImage;
        Pac: TImage;
        Gost: TImage;
        NewGameBtn: TButton;
        StyleBook1: TStyleBook;
        GostAnimation: TBitmapListAnimation;
        GostMoveAnimation: TFloatAnimation;
        PacAnimation: TBitmapListAnimation;
        procedure ExitBtnClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure AboutBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
        procedure RecordsBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
        procedure ExitBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
        procedure NewGameBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
        procedure FormCreate(Sender: TObject);
    procedure NewGameBtnClick(Sender: TObject);
    private

    public

    end;

var
    StartMenu: TStartMenu;

implementation

{$R *.fmx}

uses Records, Game;

procedure TStartMenu.NewGameBtnClick(Sender: TObject);
begin
    PlaySound(0, 0, SND_PURGE);
    PlaySound('Audio\Intro.wav', 0, SND_ASYNC);
    StartMenu.Hide;
    Game.Field.Showmodal;
end;

procedure TStartMenu.NewGameBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
    PacMoveAnimation.StopAtCurrent;
    PacMoveAnimation.Enabled := false;
    PacMoveAnimation.StartValue := Pac.Position.Y;
    PacMoveAnimation.StopValue := 112;
    PacMoveAnimation.Enabled := true;
    GostMoveAnimation.StopAtCurrent;
    GostMoveAnimation.Enabled := false;
    GostMoveAnimation.StartValue := Pac.Position.Y;
    GostMoveAnimation.StopValue := 112;
    GostMoveAnimation.Enabled := true;
end;

procedure TStartMenu.RecordsBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
    PacMoveAnimation.StopAtCurrent;
    PacMoveAnimation.Enabled := false;
    PacMoveAnimation.StartValue := Pac.Position.Y;
    PacMoveAnimation.StopValue := 192;
    PacMoveAnimation.Enabled := true;
    GostMoveAnimation.StopAtCurrent;
    GostMoveAnimation.Enabled := false;
    GostMoveAnimation.StartValue := Pac.Position.Y;
    GostMoveAnimation.StopValue := 192;
    GostMoveAnimation.Enabled := true;
end;

procedure TStartMenu.AboutBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
    PacMoveAnimation.StopAtCurrent;
    PacMoveAnimation.Enabled := false;
    PacMoveAnimation.StartValue := Pac.Position.Y;
    PacMoveAnimation.StopValue := 272;
    PacMoveAnimation.Enabled := true;
    GostMoveAnimation.StopAtCurrent;
    GostMoveAnimation.Enabled := false;
    GostMoveAnimation.StartValue := Pac.Position.Y;
    GostMoveAnimation.StopValue := 272;
    GostMoveAnimation.Enabled := true;
end;

procedure TStartMenu.ExitBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
    PacMoveAnimation.StopAtCurrent;
    PacMoveAnimation.Enabled := false;
    PacMoveAnimation.StartValue := Pac.Position.Y;
    PacMoveAnimation.StopValue := 352;
    PacMoveAnimation.Enabled := true;
    GostMoveAnimation.StopAtCurrent;
    GostMoveAnimation.Enabled := false;
    GostMoveAnimation.StartValue := Pac.Position.Y;
    GostMoveAnimation.StopValue := 352;
    GostMoveAnimation.Enabled := true;
end;

procedure TStartMenu.ExitBtnClick(Sender: TObject);
begin
    Close;
end;

procedure TStartMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TStartMenu.FormCreate(Sender: TObject);
begin
    PlaySound('Audio\Menu.wav', 0, SND_ASYNC or SND_LOOP);
end;

end.
