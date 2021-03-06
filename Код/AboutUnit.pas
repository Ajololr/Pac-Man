unit AboutUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects;

type
    TAboutForm = class(TForm)
        RulesLbl: TLabel;
        BackBtn: TButton;
        PinkyLbl: TLabel;
        InkyLbl: TLabel;
        BlinkyLbl: TLabel;
        ClydeImg: TImage;
        ClydeAnimation: TBitmapListAnimation;
        PinkyImg: TImage;
        PinkyAnimation: TBitmapListAnimation;
        InkyImg: TImage;
        InkyAnimation: TBitmapListAnimation;
        BlinkyImg: TImage;
        BlinkyAnimation: TBitmapListAnimation;
        Pac: TImage;
        PacAnimation: TBitmapListAnimation;
        ClydeLbl: TLabel;
        DeveloperLbl: TLabel;
        RulesLogoLbl: TLabel;
        procedure BackBtnClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  end;

var
    AboutForm: TAboutForm;

implementation

{$R *.fmx}

uses MainMenuUnit;

procedure TAboutForm.BackBtnClick(Sender: TObject);
begin
    Close;
end;

procedure TAboutForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    StartMenu.Show;
end;

end.
