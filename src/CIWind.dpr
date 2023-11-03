program CIWind;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Nuevo in 'Nuevo.pas' {NuevoForm},
  Datos in 'Datos.pas',
  CalculoSP in 'CalculoSP.pas' {CalcSPForm},
  selprof in 'selprof.pas' {SProfForm},
  SplashScreen in 'SplashScreen.pas' {Splash},
  Calculo in 'Calculo.pas',
  PrntComp in 'Prntcomp.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'C. I. Wind';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TNuevoForm, NuevoForm);
  Application.CreateForm(TCalcSPForm, CalcSPForm);
  Application.CreateForm(TSProfForm, SProfForm);
  Application.CreateForm(TSplash, Splash);
  Application.Run;
end.
