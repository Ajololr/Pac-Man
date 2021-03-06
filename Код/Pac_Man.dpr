program Pac_Man;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  MainMenuUnit in 'MainMenuUnit.pas' {StartMenu},
  RecordsUnit in 'RecordsUnit.pas' {RecordsForm},
  ConfirmUnit in 'ConfirmUnit.pas' {ConfirmForm},
  GameUnit in 'GameUnit.pas' {Field},
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TStartMenu, StartMenu);
  Application.CreateForm(TRecordsForm, RecordsForm);
  Application.CreateForm(TConfirmForm, ConfirmForm);
  Application.CreateForm(TField, Field);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
