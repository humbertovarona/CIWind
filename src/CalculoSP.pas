unit CalculoSP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, ExtCtrls;

type
  TCalcSPForm = class(TForm)
    Proxima: TBitBtn;
    Anterior: TBitBtn;
    CalculoCerrar: TBitBtn;
    StaticText1: TStaticText;
    EditProfundidad: TStaticText;
    ScrollBox1: TScrollBox;
    StringGridCalc: TStringGrid;
    InfoText: TStaticText;
    procedure ProximaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AnteriorClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CalculoCerrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    i, NProf    : byte;
  end;

var
  CalcSPForm  : TCalcSPForm;

implementation

uses selprof, Main, Nuevo, Datos, Calculo;

{$R *.DFM}

var
  NoCalc        : Boolean;

procedure TCalcSPForm.ProximaClick(Sender: TObject);

var
  j             : byte;
  code          : Integer;
  vel, vel2,
  deflex,
  cfricc,
  pfricc, z,
  Paramet_a     : Real;
  sdeflex, svel,
  scfricc,
  spfricc       : String[8];

begin
  vel := 0;
  If i < NProf Then
    Inc(i);
  If i = 1 Then
    Anterior.Enabled := True;
  If i = NProf Then
    Proxima.Enabled := False;
  EditProfundidad.Caption := SProfForm.ListBoxProf.Items[i];
  Val(EditProfundidad.Caption, z, code);
  For j := 1 To 16 Do
    begin
      If (NuevoForm.StringGridDatos.Cells[2,j] <> '999.0') And
         (NuevoForm.StringGridDatos.Cells[2,j] <> '0.0') Then
        begin
          NoCalc := False;
          If MainForm.Velocidades.Checked Then
             Val(NuevoForm.StringGridDatos.Cells[2,j], vel, code)
          Else
            Val(NuevoForm.StringGridDatos.Cells[1,j], vel, code);
        end
      Else
        NoCalc := True;
      If Not NoCalc Then
        begin
          Paramet_a := a(MainForm.Densidad.Value, fi);
          vel2 := VelCorrPFin(vel, CU, fi, Paramet_a, z);
          Str(vel2:3:1,svel);
          StringGridCalc.Cells[1,j]:= svel;

          deflex := DeflexionPFin(Paramet_a, z);
          deflex := GRumbos[j] + deflex + 180;
          If deflex >= 360 Then
            deflex := deflex - 360;
          Str(deflex:2:1,sdeflex);
          StringGridCalc.Cells[2,j]:= sdeflex;

          cfricc := CFriccionPFin(vel);
          Str(cfricc:2:3,scfricc);
          StringGridCalc.Cells[3,j]:= scfricc;

          pfricc := PFriccionPFin(Paramet_a);
          Str(pfricc:2:3,spfricc);
          StringGridCalc.Cells[4,j]:= spfricc;
        end;
    end;
end;

procedure TCalcSPForm.AnteriorClick(Sender: TObject);

var
  j             : byte;
  code          : Integer;
  vel, vel2,
  deflex,
  cfricc,
  pfricc, z,
  Paramet_a     : Real;
  sdeflex, svel,
  scfricc,
  spfricc       : String[8];

begin
  vel := 0;
  Dec(i);
  If i = 0 Then
    Anterior.Enabled := False;
  If i < NProf Then
    Proxima.Enabled := True;
  EditProfundidad.Caption := SProfForm.ListBoxProf.Items[i];
  Val(EditProfundidad.Caption, z, code);
  For j := 1 To 16 Do
    begin
      If (NuevoForm.StringGridDatos.Cells[2,j] <> '999.0') And
         (NuevoForm.StringGridDatos.Cells[2,j] <> '0.0') Then
        begin
          NoCalc := False;
          If MainForm.Velocidades.Checked Then
             Val(NuevoForm.StringGridDatos.Cells[2,j], vel, code)
          Else
            Val(NuevoForm.StringGridDatos.Cells[1,j], vel, code);
        end
      Else
        NoCalc := True;
      If Not NoCalc Then
        begin
          Paramet_a := a(MainForm.Densidad.Value, fi);
          vel2 := VelCorrPFin(vel, CU, fi, Paramet_a, z);
          Str(vel2:3:1,svel);
          StringGridCalc.Cells[1,j]:= svel;

          deflex := DeflexionPFin(Paramet_a, z);
          deflex := GRumbos[j] + deflex + 180;
          If deflex >= 360 Then
            deflex := deflex - 360;
          Str(deflex:2:1,sdeflex);
          StringGridCalc.Cells[2,j]:= sdeflex;

          cfricc := CFriccionPFin(vel);
          Str(cfricc:2:3,scfricc);
          StringGridCalc.Cells[3,j]:= scfricc;

          pfricc := PFriccionPFin(Paramet_a);
          Str(pfricc:2:3,spfricc);
          StringGridCalc.Cells[4,j]:= spfricc;
        end;
    end;
end;

procedure TCalcSPForm.FormActivate(Sender: TObject);

var
  j             : byte;
  code          : Integer;
  vel, vel2,
  deflex,
  cfricc,
  pfricc, z,
  Paramet_a     : Real;
  sdeflex, svel,
  scfricc,
  spfricc       : String[8];

begin
  InfoText.Caption := 'Resultados del C?lculo, Latitud: ' + MainForm.Latitud.Text;
  vel := 0;
  If MainForm.Profundidad.Checked Then
    begin
      For j := 1 To 16 Do
        begin
          If (NuevoForm.StringGridDatos.Cells[2,j] <> '999.0') And
             (NuevoForm.StringGridDatos.Cells[2,j] <> '0.0') Then
            begin
              NoCalc := False;
              If MainForm.Velocidades.Checked Then
                 Val(NuevoForm.StringGridDatos.Cells[2,j], vel, code)
              Else
                Val(NuevoForm.StringGridDatos.Cells[1,j], vel, code);
            end
          Else
            NoCalc := True;
          If Not NoCalc Then
            begin
              vel2 := VelCorr(vel, CU, fi);
              Str(vel2:3:1,svel);
              StringGridCalc.Cells[1,j]:= svel;

              deflex := Deflexion(vel);
              deflex := GRumbos[j] + deflex + 180;
              If deflex >= 360 Then
                deflex := deflex - 360;
              Str(deflex:2:1,sdeflex);
              StringGridCalc.Cells[2,j]:= sdeflex;

              cfricc := CFriccion(vel);
              Str(cfricc:2:3,scfricc);
              StringGridCalc.Cells[3,j]:= scfricc;

              pfricc := PFriccion(vel, fi);
              Str(pfricc:2:3,spfricc);
              StringGridCalc.Cells[4,j]:= spfricc;
            end;
        end;
    end
  Else
    begin
      If SProfForm.Modificado Then
        Anterior.Enabled := False;

      i := 0;
      If SProfForm.ListBoxProf.Items.Count <> 0 Then
        begin
          NProf := SProfForm.ListBoxProf.Items.Count - 1;
          EditProfundidad.Caption := SProfForm.ListBoxProf.Items[i];
          Val(EditProfundidad.Caption, z, code);
          For j := 1 To 16 Do
            begin
              If (NuevoForm.StringGridDatos.Cells[2,j] <> '999.0') And
                 (NuevoForm.StringGridDatos.Cells[2,j] <> '0.0') Then
                begin
                  NoCalc := False;
                  If MainForm.Velocidades.Checked Then
                     Val(NuevoForm.StringGridDatos.Cells[2,j], vel, code)
                  Else
                    Val(NuevoForm.StringGridDatos.Cells[1,j], vel, code);
                end
              Else
                NoCalc := True;
              If Not NoCalc Then
                begin
                  Paramet_a := a(MainForm.Densidad.Value, fi);
                  vel := VelCorrPFin(vel, CU, fi, Paramet_a, z);
                  Str(vel:3:1,svel);
                  StringGridCalc.Cells[1,j]:= svel;

                  deflex := DeflexionPFin(Paramet_a, z);
                  deflex := GRumbos[j] + deflex + 180;
                  If deflex >= 360 Then
                    deflex := deflex - 360;
                  Str(deflex:2:1,sdeflex);
                  StringGridCalc.Cells[2,j]:= sdeflex;

                  cfricc := CFriccionPFin(vel);
                  Str(cfricc:2:3,scfricc);
                  StringGridCalc.Cells[3,j]:= scfricc;

                  pfricc := PFriccionPFin(Paramet_a);
                  Str(pfricc:2:3,spfricc);
                  StringGridCalc.Cells[4,j]:= spfricc;
                end;
            end;
        end
      Else
        NProf := 0;
      If NProf = 0 Then
        begin
          Proxima.Enabled := False;
          StaticText1.Enabled := False;
          EditProfundidad.Enabled := False;
        end
      Else
        begin
          Proxima.Enabled := True;
          StaticText1.Enabled := True;
          EditProfundidad.Enabled := True;
        end;
      SProfForm.Modificado := False;
    end
end;

procedure TCalcSPForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If Not MainForm.Profundidad.Checked Then
    SProfForm.Close;
end;

procedure TCalcSPForm.CalculoCerrarClick(Sender: TObject);
begin
  Proxima.Enabled := False;
  Anterior.Enabled := False;
  Proxima.Visible := False;
  Anterior.Visible := False;
  StaticText1.Visible := False;
  EditProfundidad.Visible := False;
  MainForm.Profundidad.Enabled := True;
  MainForm.Latitud.Enabled := True;
  MainForm.Imprimir.Enabled := False;
  MainForm.ToolbarButtonImprimir.Enabled := False;
  Close;
end;

procedure TCalcSPForm.FormShow(Sender: TObject);

var
  i    : byte;

begin
  for i:=1 to 16 do
    StringGridCalc.Cells[0,i] := Rumbos[i];
  StringGridCalc.Cells[1,0] := Magnitudes[2];
  StringGridCalc.Cells[2,0] := Magnitudes[3];
  StringGridCalc.Cells[3,0] := Magnitudes[4];
  StringGridCalc.Cells[4,0] := Magnitudes[5];
end;


end.
