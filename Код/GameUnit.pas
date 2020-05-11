unit GameUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
    FMX.Objects, Mmsystem, FMX.Controls.Presentation, FMX.StdCtrls, MainMenuUnit, Vcl.Dialogs,
    ConfirmUnit;

type
    TTile = record
        Wall: Boolean;
        Eaten: Boolean;
        Dot: TCircle;
    end;

    TMas = array [0..30] of array [0..27] of Byte;
    TTiles = array [0..30] of array [0..27] of TTile;

    TField = class(TForm)
        FieldImg: TImage;
        Pac: TImage;
        PacYAnimation: TFloatAnimation;
        PacAnimation: TBitmapListAnimation;
        Life_1: TImage;
        Life_2: TImage;
        Life_3: TImage;
        LifesLbl: TLabel;
        ScoreLbl: TLabel;
        ScoreValueLbl: TLabel;
        Background: TImage;
        PacXAnimation: TFloatAnimation;
        PinkyImg: TImage;
        GameTimer: TTimer;
        PinkyAnimation: TBitmapListAnimation;
        PinkyXAnimation: TFloatAnimation;
        PinkyYAnimation: TFloatAnimation;
        ClydeImg: TImage;
        ClydeAnimation: TBitmapListAnimation;
        ClydeXAnimation: TFloatAnimation;
        ClydeYAnimation: TFloatAnimation;
        InkyImg: TImage;
        InkyAnimation: TBitmapListAnimation;
        InkyXAnimation: TFloatAnimation;
        InkyYAnimation: TFloatAnimation;
        BlinkyImg: TImage;
        BlinkyAnimation: TBitmapListAnimation;
        BlinkyXAnimation: TFloatAnimation;
        BlinkyYAnimation: TFloatAnimation;
        BlinkyColdown: TTimer;
        HighscoreValueLbl: TLabel;
        HighscoreLbl: TLabel;
        Image3: TImage;
        Image2: TImage;
        NEXT: TImage;
        procedure SetImages;
        procedure GetClydeMove;
        procedure GetInkyMove;
        procedure GetBlinkyMove;
        procedure InitialiseResults;
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
        procedure Move(NewY, NewX: ShortInt);
        procedure CheckMove(NewY, NewX: ShortInt);
        procedure PacYAnimationFinish(Sender: TObject);
        procedure PacXAnimationFinish(Sender: TObject);
        procedure GameTimerTimer(Sender: TObject);
        procedure GetPinkyMove;
        procedure PinkyMove(NewY, NewX: ShortInt);
        procedure CheckPinckyMove(NewY, NewX: ShortInt);
        procedure PinkyXAnimaionFinish(Sender: TObject);
        procedure PinkyYAnmationFinish(Sender: TObject);
        procedure Setup;
        procedure FormCreate(Sender: TObject);
        procedure PinkyXAnimationProcess(Sender: TObject);
        procedure PinkyYAnimationProcess(Sender: TObject);
        procedure CheckClydeMove(NewY, NewX: ShortInt);
        procedure ClydeMove(NewY, NewX: ShortInt);
        procedure ClydeXAnimationFinish(Sender: TObject);
        procedure ClydeXAnimationProcess(Sender: TObject);
        procedure ClydeYAnimationFinish(Sender: TObject);
        procedure ClydeYAnimationProcess(Sender: TObject);
        procedure CheckInkyMove(NewY, NewX: ShortInt);
        procedure InkyMove(NewY, NewX: ShortInt);
        procedure InkyXAnimationFinish(Sender: TObject);
        procedure InkyXAnimationProcess(Sender: TObject);
        procedure InkyYAnimationFinish(Sender: TObject);
        procedure InkyYAnimationProcess(Sender: TObject);
        procedure CheckBlinkyMove(NewY, NewX: ShortInt);
        procedure BlinkyMove(NewY, NewX: ShortInt);
        procedure BlinkyXAnimationFinish(Sender: TObject);
        procedure BlinkyXAnimationProcess(Sender: TObject);
        procedure BlinkyYAnimationFinish(Sender: TObject);
        procedure BlinkyYAnimationProcess(Sender: TObject);
        procedure BlinkyColdownTimer(Sender: TObject);
        procedure ChangeMap(Map: TMas);
    end;

    TPacMan = record
        X: ShortInt;
        Y: ShortInt;
        Lifes: ShortInt;
    end;

    TPinky = record
        X: ShortInt;
        Y: ShortInt;
        LastMove: Byte;
    end;

    TClyde= record
        X: ShortInt;
        Y: ShortInt;
        InGame: Boolean;
    end;

    TInky = record
        X: ShortInt;
        Y: ShortInt;
        InGame: Boolean;
    end;

    TBlinky = record
        X: ShortInt;
        Y: ShortInt;
        InGame: Boolean;
        LastMove: Byte;
    end;

const
    LevelAimValue = 200;
    PinkySpeed = 0.3;
    InkySpeed = 0.25;
    ClydeSpeed = 0.25;
    BlinkySpeed = 0.25;
    FirstGhost = 400;
    SecondGhost = 1000;
    ThirdGhost = 2000;
    FirstLevel: TMas =
        ((1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1),
        (1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1),
        (1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1));
    SecondLevel: TMas =
        ((1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1),
        (1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1));
    ThirdLevel: TMas =
        ((1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1),
        (1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1),
        (1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1),
        (1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1),
        (1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1),
        (1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1),
        (1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1),
        (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
        (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1));

var
    Field: TField;
    Tiles: TTiles;
    PacMan: TPacMan;
    Pinky: TPinky;
    Clyde: TClyde;
    Inky: TInky;
    Blinky: TBlinky;
    LevelNumber: ShortInt = 1;
    LevelAim: Integer;
    CurrentMap: TMas;

implementation

{$R *.fmx}

uses RecordsUnit;

//================================={ Game }================================================

procedure TField.GetPinkyMove;
begin
    if not(PinkyXAnimation.Enabled or PinkyYAnimation.Enabled) then
        case random(4) of
            0: if not(Pinky.LastMove = 1) then
                CheckPinckyMove(Pinky.Y - 1, Pinky.X);
            1: if not(Pinky.LastMove = 0) then
                CheckPinckyMove(Pinky.Y + 1, Pinky.X);
            2: if not(Pinky.LastMove = 3) then
                CheckPinckyMove(Pinky.Y, Pinky.X - 1);
            3: if not(Pinky.LastMove = 2) then
                CheckPinckyMove(Pinky.Y, Pinky.X + 1);
        end;
end;

procedure TField.GetClydeMove;
begin
    if Clyde.InGame and not(ClydeXAnimation.Enabled or ClydeYAnimation.Enabled) then
        begin
            if (Clyde.Y > PacMan.Y) and not(ClydeXAnimation.Enabled or ClydeYAnimation.Enabled) then
                CheckClydeMove(Clyde.Y - 1, Clyde.X)
            else
                if (Clyde.Y < PacMan.Y) and not(ClydeXAnimation.Enabled or ClydeYAnimation.Enabled) then
                    CheckClydeMove(Clyde.Y + 1, Clyde.X);
            if (Clyde.X > PacMan.X) and not(ClydeXAnimation.Enabled or ClydeYAnimation.Enabled) then
                CheckClydeMove(Clyde.Y, Clyde.X - 1)
            else
                if (Clyde.X < PacMan.X) and not(ClydeXAnimation.Enabled or ClydeYAnimation.Enabled) then
                    CheckClydeMove(Clyde.Y, Clyde.X + 1)
        end;
end;

procedure TField.GetInkyMove;
begin
    if Inky.InGame and not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
    begin
        if (Inky.X > PacMan.X) and not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
            CheckInkyMove(Inky.Y, Inky.X - 1)
        else
            if (Inky.X < PacMan.X) and not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                CheckInkyMove(Inky.Y, Inky.X + 1)
            else
            begin
                if not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                    CheckInkyMove(Inky.Y - 1, Inky.X);
                if not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                    CheckInkyMove(Inky.Y + 1, Inky.X);
            end;
        if (Inky.Y > PacMan.Y) and not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
            CheckInkyMove(Inky.Y - 1, Inky.X)
        else
            if (Inky.Y < PacMan.Y) and not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                CheckInkyMove(Inky.Y + 1, Inky.X)
            else
            begin
                if not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                    CheckInkyMove(Inky.Y, Inky.X - 1);
                if not(InkyXAnimation.Enabled or InkyYAnimation.Enabled) then
                    CheckInkyMove(Inky.Y, Inky.X + 1);
            end;
    end;
end;

procedure TField.GetBlinkyMove;
begin
    if Blinky.InGame and not(BlinkyXAnimation.Enabled or BlinkyYAnimation.Enabled) then
        case random(4) of
            0: if not(Blinky.LastMove = 1) then
                CheckBlinkyMove(Blinky.Y - 1, Blinky.X);
            1: if not(Blinky.LastMove = 0) then
                CheckBlinkyMove(Blinky.Y + 1, Blinky.X);
            2: if not(Blinky.LastMove = 3) then
                CheckBlinkyMove(Blinky.Y, Blinky.X - 1);
            3: if not(Blinky.LastMove = 2) then
                CheckBlinkyMove(Blinky.Y, Blinky.X + 1);
        end;
end;

procedure TField.InitialiseResults;
begin
    GameTimer.Enabled := false;
    BlinkyColdown.Enabled := false;
    if StrToInt(ScoreValueLbl.Text) >= StrToInt(HighscoreValueLbl.Text) then
        if LevelNumber = 3 then
        begin
            PlaySound('Audio\Win.wav', 0, SND_ASYNC);
            ConfirmForm.NameEdit.Visible := true;
            ConfirmForm.NameEdit.Text := '';
            ConfirmForm.ConfirmBtn.Enabled := false;
            ConfirmForm.ConfirmBtn.Text := 'Confirm';
            ConfirmForm.ConfirmLbl.Text := 'You have esceped the spaceship! Enter your name:';
        end
        else
        begin
            PlaySound('Audio\Win.wav', 0, SND_ASYNC);
            ConfirmForm.NameEdit.Visible := true;
            ConfirmForm.NameEdit.Text := '';
            ConfirmForm.ConfirmBtn.Enabled := false;
            ConfirmForm.ConfirmBtn.Text := 'Confirm';
            ConfirmForm.ConfirmLbl.Text := 'Thank you for game! Enter your name:';
        end
    else
        if LevelNumber = 3 then
        begin
            PlaySound('Audio\Win.wav', 0, SND_ASYNC);
            ConfirmForm.NameEdit.Visible := false;
            ConfirmForm.ConfirmBtn.Enabled := true;
            ConfirmForm.ConfirmBtn.Text := 'Ok';
            ConfirmForm.ConfirmLbl.Text := 'You have esceped the spaceship! Try to beat the highscore.';
        end
        else
        begin
            PlaySound('Audio\Death.wav', 0, SND_ASYNC);
            ConfirmForm.NameEdit.Visible := false;
            ConfirmForm.ConfirmBtn.Enabled := true;
            ConfirmForm.ConfirmBtn.Text := 'Ok';
            ConfirmForm.ConfirmLbl.Text := 'Thank you for game! Try to beat the highscore.';
        end;
    ConfirmForm.Showmodal;
    Close;
end;

procedure TField.GameTimerTimer(Sender: TObject);
var i,j: Byte;
begin
    Randomize;
    GetPinkyMove;
    GetClydeMove;
    GetInkyMove;
    GetBlinkyMove;
    if ((PacMan.X = Inky.X) and (PacMan.Y = Inky.Y)) or
       ((PacMan.X = Pinky.X) and (PacMan.Y = Pinky.Y)) or
       ((PacMan.X = Clyde.X) and (PacMan.Y = Clyde.Y)) or
       ((PacMan.X = Blinky.X) and (PacMan.Y = Blinky.Y)) then
    begin
        Dec(PacMan.Lifes);
        case PacMan.Lifes of
            2:
            begin
                Life_3.Visible := false;
                Setup;
            end;
            1:
            begin
                Life_2.Visible := false;
                Setup;
            end;
            0: InitialiseResults;
        end;
    end;
    if (NEXT.Visible and (Pac.Position.X = NEXT.Position.X) and (Pac.Position.Y = NEXT.Position.Y)) then
        if LevelNumber = 1 then
        begin
            for i := 0 to 30 do
                for j := 0 to 27 do
                    if CurrentMap[i][j] = 0 then
                        Tiles[i][j].Dot.Destroy;
            LevelNumber := 2;
            ChangeMap(SecondLevel);
            Setup;
        end
        else
            if LevelNumber = 2 then
            begin
                for i := 0 to 30 do
                    for j := 0 to 27 do
                        if CurrentMap[i][j] = 0 then
                            Tiles[i][j].Dot.Destroy;
                LevelNumber := 3;
                ChangeMap(ThirdLevel);
                Setup;
            end
            else
                InitialiseResults;
end;

procedure TField.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
    if not(PacXAnimation.Enabled or PacYAnimation.Enabled) then
    case key of
        VkUp: CheckMove(PacMan.Y - 1, PacMan.X);
        VkDown: CheckMove(PacMan.Y + 1, PacMan.X);
        VkLeft: CheckMove(PacMan.Y, PacMan.X - 1);
        VkRight: CheckMove(PacMan.Y, PacMan.X + 1);
    end;
    if not(GameTimer.Enabled) then
        GameTimer.Enabled := true;
    if not(Clyde.InGame) and (StrToInt(ScoreValueLbl.Text) >  FirstGhost) then
    begin
        Clyde.InGame := true;
        Clyde.Y := 11;
        Clyde.X := 14;
        ClydeImg.Position.Y := 11 * 20 + 50;
        ClydeImg.Position.X := 14 * 20;
    end;
    if not(Inky.InGame) and (StrToInt(ScoreValueLbl.Text) >  SecondGhost) then
    begin
        Inky.InGame := true;
        Inky.Y := 11;
        Inky.X := 12;
        InkyImg.Position.Y := 11 * 20 + 50;
        InkyImg.Position.X := 12 * 20;
    end;
    if not(Blinky.InGame) and (StrToInt(ScoreValueLbl.Text) >  ThirdGhost) then
    begin
        BlinkyColdown.Enabled := true;
        Blinky.InGame := true;
        Blinky.Y := 11;
        Blinky.X := 15;
        BlinkyImg.Position.Y := 11 * 20 + 50;
        BlinkyImg.Position.X := 15 * 20;
    end;
    if ((not(NEXT.Visible)) and (StrToInt(ScoreValueLbl.Text) >  FirstGhost) and (LevelNumber = 1))  then
        Next.Visible := true;
    if ((not(NEXT.Visible)) and (StrToInt(ScoreValueLbl.Text) >  LevelAim) and (LevelNumber = 2))  then
        Next.Visible := true;
    if ((not(NEXT.Visible)) and (StrToInt(ScoreValueLbl.Text) >  LevelAim) and (LevelNumber = 3))  then
        Next.Visible := true;
end;

procedure TField.FormCreate(Sender: TObject);
var
    i, j: ShortInt;
    TempC: TCircle;
begin
    ChangeMap(FirstLevel);
end;

procedure TField.ChangeMap(Map: TMas);
var
    i, j: ShortInt;
    TempC: TCircle;
begin
    CurrentMap := Map;
    LevelAim := StrToInt(ScoreValueLbl.Text) + LevelAimValue;
    if LevelNumber = 1 then
    begin
        Image3.Visible := false;
        Image2.Visible := false;
        FieldImg.Visible := true;
    end
    else
        if LevelNumber = 2 then
        begin
            Image3.Visible := false;
            Image2.Visible := true;
            FieldImg.Visible := false;
        end
        else
        begin
            Image3.Visible := true;
            Image2.Visible := false;
            FieldImg.Visible := false;
        end;
    for i := 0 to 30 do
        for j := 0 to 27 do
            case CurrentMap[i][j] of
                0:  With Tiles[i][j] do
                begin
                    Wall := false;
                    Eaten := false;
                    Dot := TCircle.Create(Self);
                    Dot.Parent := Self;
                    Dot.Fill.color := $FFFFFF00;
                    Dot.Position.X := j * 20 + 8;
                    Dot.Position.Y := i * 20 + 58;
                    Dot.Width := 5;
                    Dot.Height := 5;
                end;
                1:
                begin
                    Tiles[i][j].Wall := true;
                end;
            end;
end;

procedure TField.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    PlaySound(NIL, 0, SND_PURGE);
    StartMenu.Show;
    PlaySound('Audio\Menu.wav', 0, SND_ASYNC or SND_LOOP);
end;

procedure TField.SetImages;
begin
    GameTimer.Enabled := false;
    PinkyXAnimation.Enabled := false;
    PinkyYAnimation.Enabled := false;
    PacXAnimation.Enabled := false;
    PacYAnimation.Enabled := false;
    ClydeXAnimation.Enabled := false;
    ClydeYAnimation.Enabled := false;
    InkyXAnimation.Enabled := false;
    InkyYAnimation.Enabled := false;
    BlinkyXAnimation.Enabled := false;
    BlinkyYAnimation.Enabled := false;
    PacMan.Y := 23;
    PacMan.X := 13;
    Pac.Position.X := 260;
    Pac.Position.Y := 510;
    Pinky.Y := 11;
    Pinky.X := 13;
    PinkyImg.Position.X := 260;
    PinkyImg.Position.Y := 270;
    NEXT.Visible := false;
end;

procedure TField.Setup;
var
    i, j: ShortInt;
    TempC: TCircle;
begin
    SetImages;
    if StrToInt(ScoreValueLbl.Text) > 195 then
    begin
        Clyde.InGame := true;
        Clyde.Y := 11;
        Clyde.X := 14;
        ClydeImg.Position.X := 14 * 20;
        ClydeImg.Position.Y := 11 * 20 + 50;
    end
    else
    begin
        Clyde.InGame := false;
        Clyde.Y := 0;
        Clyde.X := 0;
        ClydeImg.Position.X := 232;
        ClydeImg.Position.Y := 332;
    end;
    if StrToInt(ScoreValueLbl.Text) > 395 then
    begin
        Inky.InGame := true;
        Inky.Y := 11;
        Inky.X := 12;
        InkyImg.Position.X := 12 * 20;
        InkyImg.Position.Y := 11 * 20 + 50;
    end
    else
    begin
        Inky.InGame := false;
        Inky.Y := 0;
        Inky.X := 0;
        InkyImg.Position.X := 270;
        InkyImg.Position.Y := 332;
    end;
    if StrToInt(ScoreValueLbl.Text) > 595 then
    begin
        Blinky.InGame := true;
        Blinky.Y := 11;
        Blinky.X := 15;
        BlinkyImg.Position.X := 15 * 20;
        BlinkyImg.Position.Y := 11 * 20 + 50;
        BlinkyColdown.Enabled := true;
    end
    else
    begin
        Blinky.InGame := false;
        Blinky.Y := 0;
        Blinky.X := 0;
        BlinkyImg.Position.X := 308;
        BlinkyImg.Position.Y := 332;
        BlinkyColdown.Enabled := false;
    end;
end;

//================================={ PacMan }===============================================

procedure TField.Move(NewY, NewX: ShortInt);
begin
    if (NewY <> PacMan.Y) then
    begin
        PacYAnimation.StartValue := PacMan.Y * 20 + 50;
        PacYAnimation.StopValue := NewY * 20 + 50;
        PacYAnimation.Enabled := true;
    end
    else
    begin
        PacXAnimation.StartValue := PacMan.X * 20;
        PacXAnimation.StopValue := NewX * 20;
        PacXAnimation.Enabled := true;
    end;
end;

procedure TField.PacXAnimationFinish(Sender: TObject);
begin
    PacXAnimation.Enabled := false;
    Pac.Position.X := PacXAnimation.StopValue;
    PacMan.X := Trunc(PacXAnimation.StopValue / 20);
end;

procedure TField.PacYAnimationFinish(Sender: TObject);
begin
    PacYAnimation.Enabled := false;
    Pac.Position.Y := PacYAnimation.StopValue;
    PacMan.Y := Trunc((PacYAnimation.StopValue - 50) / 20);
end;

procedure TField.CheckMove(NewY, NewX: ShortInt);
begin
    if (NewY > PacMan.Y) then
        Pac.RotationAngle := 90;
    if (NewY < PacMan.Y) then
        Pac.RotationAngle := -90;
    if (NewX > PacMan.X) then
        Pac.RotationAngle := 0;
    if (NewX < PacMan.X) then
        Pac.RotationAngle := 180;
    if (NewX = -1) or (NewX = 28) then
        if (NewX = -1) then
        begin
            PacMan.X := 28;
            Pac.Position.X := 28 * 20;
            Move(NewY, 27);
            if not(Tiles[NewY, 27].Eaten) then
            begin
                PlaySound('Audio\Eating.wav', 0, SND_ASYNC or SND_NOSTOP);
                ScoreValueLbl.Text := IntToStr(StrToInt(ScoreValueLbl.Text) + 5);
                Tiles[NewY][27].Dot.Visible := false;
                Tiles[NewY, 27].Eaten := true;
            end;
        end
        else
        begin
            PacMan.X := -1;
            Pac.Position.X := -1 * 20;
            Move(NewY, 0);
            if not(Tiles[NewY, 0].Eaten) then
            begin
                PlaySound('Audio\Eating.wav', 0, SND_ASYNC or SND_NOSTOP);
                ScoreValueLbl.Text := IntToStr(StrToInt(ScoreValueLbl.Text) + 5);
                Tiles[NewY][0].Dot.Visible := false;
                Tiles[NewY, 0].Eaten := true;
            end;
        end
    else
        if not(Tiles[NewY, NewX].Wall) then
            if not(Tiles[NewY, NewX].Eaten) then
            begin
                Move(NewY, NewX);
                PlaySound('Audio\Eating.wav', 0, SND_ASYNC or SND_NOSTOP);
                ScoreValueLbl.Text := IntToStr(StrToInt(ScoreValueLbl.Text) + 5);
                Tiles[NewY][NewX].Dot.Visible := false;
                Tiles[NewY, NewX].Eaten := true;
            end
            else
                Move(NewY, NewX);
end;

//================================={ Pinky }================================================

procedure TField.CheckPinckyMove(NewY, NewX: ShortInt);
begin
    if ((NewX = 5) or (NewX = 22)) and (NewY = 14) then
        if (NewX = 5) then
        begin
            PinkyXAnimation.Duration := PinkySpeed * 6;
            PinkyXAnimation.StartValue := Pinky.X * 20;
            PinkyXAnimation.StopValue := 0;
            PinkyXAnimation.Enabled := true;
        end
        else
        begin
            PinkyXAnimation.Duration := PinkySpeed * 6;
            PinkyXAnimation.StartValue := Pinky.X * 20;
            PinkyXAnimation.StopValue := 27 * 20;
            PinkyXAnimation.Enabled := true;
        end
    else
        if not(Tiles[NewY, NewX].Wall) then
            PinkyMove(NewY, NewX);
end;

procedure TField.PinkyMove(NewY, NewX: ShortInt);
begin
    if (NewY <> Pinky.Y) then
    begin
        if (NewY > Pinky.Y) then
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Inc(NewY);
                PinkyYAnimation.Duration := PinkyYAnimation.Duration + PinkySpeed
            end
        else
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Dec(NewY);
                PinkyYAnimation.Duration := PinkyYAnimation.Duration + PinkySpeed
            end;
        PinkyYAnimation.StartValue := Pinky.Y * 20 + 50;
        PinkyYAnimation.StopValue := NewY * 20 + 50;
        PinkyYAnimation.Enabled := true;
    end
    else
    begin
        if (NewX > Pinky.X) then
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Inc(NewX);
                PinkyXAnimation.Duration := PinkyXAnimation.Duration + PinkySpeed;
            end
        else
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Dec(NewX);
                PinkyXAnimation.Duration := PinkyXAnimation.Duration + PinkySpeed;
            end;
        PinkyXAnimation.StartValue := Pinky.X * 20;
        PinkyXAnimation.StopValue := NewX * 20;
        PinkyXAnimation.Enabled := true;
    end;
end;

procedure TField.PinkyXAnimaionFinish(Sender: TObject);
begin
    PinkyXAnimation.Enabled := false;
    PinkyXAnimation.Duration := PinkySpeed;
    if PinkyXAnimation.StopValue = 0 then
    begin
        Pinky.X := 27;
        PinkyImg.Position.X := 27 * 20;
        PinkyMove(14, 26);
    end;
    if PinkyXAnimation.StopValue = 27 * 20 then
    begin
        Pinky.X := 0;
        PinkyImg.Position.X := 0;
        PinkyMove(14, 1);
    end;
    if PinkyXAnimation.StopValue > PinkyXAnimation.StartValue then
        Pinky.LastMove := 3
    else
        Pinky.LastMove := 2;
    PinkyImg.Position.X := PinkyXAnimation.StopValue;
    Pinky.X := Trunc(PinkyXAnimation.StopValue / 20);
end;

procedure TField.PinkyXAnimationProcess(Sender: TObject);
begin
    Pinky.X := Trunc(PinkyImg.Position.X / 20);
end;

procedure TField.PinkyYAnmationFinish(Sender: TObject);
begin
    PinkyYAnimation.Enabled := false;
    if PinkyYAnimation.StopValue > PinkyYAnimation.StartValue then
        Pinky.LastMove := 1
    else
        Pinky.LastMove := 0;
    PinkyImg.Position.Y := PinkyYAnimation.StopValue;
    Pinky.Y := Trunc((PinkyYAnimation.StopValue - 50) / 20);
    PinkyYAnimation.Duration := PinkySpeed;
end;

procedure TField.PinkyYAnimationProcess(Sender: TObject);
begin
    Pinky.Y := Trunc((PinkyImg.Position.Y - 50) / 20);
end;

//================================={ Clyde }================================================

procedure TField.CheckClydeMove(NewY, NewX: ShortInt);
begin
    if not(Tiles[NewY, NewX].Wall) then
        ClydeMove(NewY, NewX);
end;

procedure TField.ClydeMove(NewY, NewX: ShortInt);
begin
    if (NewY <> Clyde.Y) then
    begin
        if (NewY > Clyde.Y) then
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Inc(NewY);
                ClydeYAnimation.Duration := ClydeYAnimation.Duration + ClydeSpeed;
            end
        else
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Dec(NewY);
                ClydeYAnimation.Duration := ClydeYAnimation.Duration + ClydeSpeed
            end;
        ClydeYAnimation.StartValue := Clyde.Y * 20 + 50;
        ClydeYAnimation.StopValue := NewY * 20 + 50;
        ClydeYAnimation.Enabled := true;
    end
    else
    begin
        if (NewX > Clyde.X) then
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Inc(NewX);
                ClydeXAnimation.Duration := ClydeXAnimation.Duration + ClydeSpeed;
            end
        else
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Dec(NewX);
                ClydeXAnimation.Duration := ClydeXAnimation.Duration + ClydeSpeed;
            end;
        ClydeXAnimation.StartValue := Clyde.X * 20;
        ClydeXAnimation.StopValue := NewX * 20;
        ClydeXAnimation.Enabled := true;
    end;
end;

procedure TField.ClydeXAnimationFinish(Sender: TObject);
begin
    ClydeXAnimation.Enabled := false;
    ClydeXAnimation.Duration := ClydeSpeed;
    ClydeImg.Position.X := ClydeXAnimation.StopValue;
    Clyde.X := Trunc(ClydeXAnimation.StopValue / 20);
end;

procedure TField.ClydeXAnimationProcess(Sender: TObject);
begin
    Clyde.X :=  Trunc(ClydeImg.Position.X / 20);
end;

procedure TField.ClydeYAnimationFinish(Sender: TObject);
begin
    ClydeYAnimation.Enabled := false;
    ClydeYAnimation.Duration := ClydeSpeed;
    ClydeImg.Position.Y := ClydeYAnimation.StopValue;
    Clyde.Y := Trunc((ClydeYAnimation.StopValue - 50) / 20);
end;

procedure TField.ClydeYAnimationProcess(Sender: TObject);
begin
    Clyde.Y :=  Trunc((ClydeImg.Position.Y - 50) / 20);
end;

//================================={ Inky }================================================

procedure TField.CheckInkyMove(NewY, NewX: ShortInt);
begin
    if not(Tiles[NewY, NewX].Wall) then
        InkyMove(NewY, NewX);
end;

procedure TField.InkyMove(NewY, NewX: ShortInt);
begin
    if (NewY <> Inky.Y) then
    begin
        if (NewY > Inky.Y) then
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Inc(NewY);
                InkyYAnimation.Duration := InkyYAnimation.Duration + InkySpeed
            end
        else
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Dec(NewY);
                InkyYAnimation.Duration := InkyYAnimation.Duration + InkySpeed
            end;
        InkyYAnimation.StartValue := Inky.Y * 20 + 50;
        InkyYAnimation.StopValue := NewY * 20 + 50;
        InkyYAnimation.Enabled := true;
    end
    else
    begin
        if (NewX > Inky.X) then
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Inc(NewX);
                InkyXAnimation.Duration := InkyXAnimation.Duration + InkySpeed;
            end
        else
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Dec(NewX);
                InkyXAnimation.Duration := InkyXAnimation.Duration + InkySpeed;
            end;
        InkyXAnimation.StartValue := Inky.X * 20;
        InkyXAnimation.StopValue := NewX * 20;
        InkyXAnimation.Enabled := true;
    end;
end;

procedure TField.InkyXAnimationFinish(Sender: TObject);
begin
    InkyXAnimation.Enabled := false;
    InkyXAnimation.Duration := InkySpeed;
    InkyImg.Position.X := InkyXAnimation.StopValue;
    Inky.X := Trunc(InkyXAnimation.StopValue / 20);
end;

procedure TField.InkyXAnimationProcess(Sender: TObject);
begin
    Inky.X :=  Trunc(InkyImg.Position.X / 20);
end;

procedure TField.InkyYAnimationFinish(Sender: TObject);
begin
    InkyYAnimation.Enabled := false;
    InkyYAnimation.Duration := InkySpeed;
    InkyImg.Position.Y := InkyYAnimation.StopValue;
    Inky.Y := Trunc((InkyYAnimation.StopValue - 50) / 20);
end;

procedure TField.InkyYAnimationProcess(Sender: TObject);
begin
    Inky.Y :=  Trunc((InkyImg.Position.Y - 50) / 20);
end;

//================================={ Blinky }==============================================

procedure TField.CheckBlinkyMove(NewY, NewX: ShortInt);
begin
    if ((NewX = 5) or (NewX = 22)) and (NewY = 14) then
        if (NewX = 5) then
        begin
            BlinkyXAnimation.Duration := BlinkySpeed * 6;
            BlinkyXAnimation.StartValue := Blinky.X * 20;
            BlinkyXAnimation.StopValue := 0;
            BlinkyXAnimation.Enabled := true;
        end
        else
        begin
            BlinkyXAnimation.Duration := BlinkySpeed * 6;
            BlinkyXAnimation.StartValue := Blinky.X * 20;
            BlinkyXAnimation.StopValue := 27 * 20;
            BlinkyXAnimation.Enabled := true;
        end
    else
        if not(Tiles[NewY, NewX].Wall) then
            BlinkyMove(NewY, NewX);
end;

procedure TField.BlinkyColdownTimer(Sender: TObject);
var
    NewX, NewY: ShortInt;
begin
    BlinkyXAnimation.StopAtCurrent;
    BlinkyYAnimation.StopAtCurrent;
    case random(4) of
        0:
        begin
            NewY := PacMan.Y - 3;
            NewX := PacMan.X;
        end;
        1:
        begin
            NewY := PacMan.Y + 3;
            NewX := PacMan.X;
        end;
        2:
        begin
            NewY := PacMan.Y;
            NewX := PacMan.X - 3;
        end;
        3:
        begin
            NewY := PacMan.Y;
            NewX := PacMan.X + 3;
        end;
    end;
    if (NewX < 27) and (NewX > 0) and (NewY < 30) and (NewY > 0) and not(Tiles[NewY][NewX].Wall) then
    begin
        Blinky.X := NewX;
        Blinky.Y := NewY;
        BlinkyImg.Position.Y := NewY * 20 + 50;
        BlinkyImg.Position.X := NewX * 20;
    end;
end;

procedure TField.BlinkyMove(NewY, NewX: ShortInt);
begin
    if (NewY <> Blinky.Y) then
    begin
        if (NewY > Blinky.Y) then
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Inc(NewY);
                BlinkyYAnimation.Duration := BlinkyYAnimation.Duration + BlinkySpeed
            end
        else
            while (Tiles[NewY][NewX + 1].Wall and Tiles[NewY][NewX - 1].Wall) do
            begin
                Dec(NewY);
                BlinkyYAnimation.Duration := BlinkyYAnimation.Duration + BlinkySpeed
            end;
        BlinkyYAnimation.StartValue := Blinky.Y * 20 + 50;
        BlinkyYAnimation.StopValue := NewY * 20 + 50;
        BlinkyYAnimation.Enabled := true;
    end
    else
    begin
        if (NewX > Blinky.X) then
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Inc(NewX);
                BlinkyXAnimation.Duration := BlinkyXAnimation.Duration + BlinkySpeed;
            end
        else
            while (Tiles[NewY + 1][NewX].Wall and Tiles[NewY - 1][NewX].Wall) do
            begin
                Dec(NewX);
                BlinkyXAnimation.Duration := BlinkyXAnimation.Duration + BlinkySpeed;
            end;
        BlinkyXAnimation.StartValue := Blinky.X * 20;
        BlinkyXAnimation.StopValue := NewX * 20;
        BlinkyXAnimation.Enabled := true;
    end;
end;

procedure TField.BlinkyXAnimationFinish(Sender: TObject);
begin
    BlinkyXAnimation.Enabled := false;
    BlinkyXAnimation.Duration := BlinkySpeed;
    if BlinkyXAnimation.StopValue = 0 then
    begin
        Blinky.X := 27;
        BlinkyImg.Position.X := 27 * 20;
        BlinkyMove(14, 26);
    end;
    if BlinkyXAnimation.StopValue = 27 * 20 then
    begin
        Blinky.X := 0;
        BlinkyImg.Position.X := 0;
        BlinkyMove(14, 1);
    end;
    if BlinkyXAnimation.StopValue > BlinkyXAnimation.StartValue then
        Blinky.LastMove := 3
    else
        Blinky.LastMove := 2;
    BlinkyImg.Position.X := BlinkyXAnimation.StopValue;
    Blinky.X := Trunc(BlinkyXAnimation.StopValue / 20);
end;

procedure TField.BlinkyXAnimationProcess(Sender: TObject);
begin
    Blinky.X := Trunc(BlinkyImg.Position.X / 20);
end;

procedure TField.BlinkyYAnimationFinish(Sender: TObject);
begin
    BlinkyYAnimation.Enabled := false;
    if BlinkyYAnimation.StopValue > BlinkyYAnimation.StartValue then
        Blinky.LastMove := 1
    else
        Blinky.LastMove := 0;
    BlinkyImg.Position.Y := BlinkyYAnimation.StopValue;
    Blinky.Y := Trunc((BlinkyYAnimation.StopValue - 50) / 20);
    BlinkyYAnimation.Duration := BlinkySpeed;
end;

procedure TField.BlinkyYAnimationProcess(Sender: TObject);
begin
    Blinky.Y := Trunc((BlinkyImg.Position.Y - 50) / 20);
end;

end.
