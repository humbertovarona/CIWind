unit SplashScreen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Rzlabel;

type
  TSplash = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    procedure FormActivate(Sender: TObject);
    procedure CloseSplash(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Splash: TSplash;

implementation

{$R *.DFM}

procedure TSplash.FormActivate(Sender: TObject);
begin
  Splash.Show;
end;

procedure TSplash.CloseSplash(Sender: TObject);
begin
  Close;
end;

end.
