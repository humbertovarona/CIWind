unit Nuevo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Menus;

type
  TNuevoForm = class(TForm)
    StringGridDatos: TStringGrid;
    NuevoClose: TBitBtn;
    PopupMenuNuevo: TPopupMenu;
    Nulo: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure NuloClick(Sender: TObject);
    procedure StringGridDatosSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure NuevoCloseClick(Sender: TObject);
    procedure StringGridDatosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    Cargar: Boolean;
  end;

var
  NuevoForm   : TNuevoForm;

implementation

uses Datos;

{$R *.DFM}

procedure TNuevoForm.FormShow(Sender: TObject);

var
  i, j    : byte;

begin
  for i:=1 to 16 do
    StringGridDatos.Cells[0,i] := Rumbos[i];
  StringGridDatos.Cells[1,0] := Magnitudes[1];
  StringGridDatos.Cells[2,0] := Magnitudes[6];
  If Not Cargar Then
    For j:=1 To 2 Do
      For i:=1 To 16 Do
        StringGridDatos.Cells[j,i]:='0.0';
end;

procedure TNuevoForm.NuloClick(Sender: TObject);
begin
  StringGridDatos.Cells[StringGridDatos.Col,StringGridDatos.Row] := '999.0';
  NuevoClose.Enabled := False;
end;

procedure TNuevoForm.StringGridDatosSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  NuevoClose.Enabled := False;
end;

procedure TNuevoForm.NuevoCloseClick(Sender: TObject);
begin
  Close
end;

procedure TNuevoForm.StringGridDatosKeyPress(Sender: TObject;
  var Key: Char);
begin
  If ((Key < '0') Or (Key > '9')) And (Key <> #8) And (Key <> #13) And
     (Key <> '.') And (Key <> #9) Then
    Key := #0;
end;

end.
