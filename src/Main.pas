unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, TB97, Mask, ExtCtrls, Nuevo, CalculoSP, selprof,
  SplashScreen, Datos, RZNEdit;

type
  TMainForm = class(TForm)
    MMenu: TMainMenu;
    Archivo: TMenuItem;
    Calculo: TMenuItem;
    Nuevo: TMenuItem;
    Abrir: TMenuItem;
    Guardar: TMenuItem;
    ToolbarMain: TToolbar97;
    DockMain: TDock97;
    TBAbrir: TToolbarButton97;
    TBGuardar: TToolbarButton97;
    TBCalculos: TToolbarButton97;
    ToolbarSep971: TToolbarSep97;
    TBTerminar: TToolbarButton97;
    ToolbarSep972: TToolbarSep97;
    N1: TMenuItem;
    Imprimir: TMenuItem;
    ToolbarSep973: TToolbarSep97;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolbarButtonImprimir: TToolbarButton97;
    PrintDialog: TPrintDialog;
    N2: TMenuItem;
    Terminar: TMenuItem;
    ToolbarSep974: TToolbarSep97;
    ComboBoxCU: TComboBox;
    ToolbarSep975: TToolbarSep97;
    TBNuevo: TToolbarButton97;
    Profundidad: TCheckBox;
    Velocidades: TCheckBox;
    ToolbarSep976: TToolbarSep97;
    Guardarcomo: TMenuItem;
    Latitud: TRealEdit;
    Densidad: TRealEdit;
    ToolbarSep977: TToolbarSep97;
    procedure AbrirClick(Sender: TObject);
    procedure GuardarClick(Sender: TObject);
    procedure TerminarClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure NuevoClick(Sender: TObject);
    procedure CalculoClick(Sender: TObject);
    procedure ComboBoxCUKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxCUChange(Sender: TObject);
    procedure GuardarcomoClick(Sender: TObject);
    procedure ProfundidadClick(Sender: TObject);
    procedure DensidadChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm : TMainForm;

const
  CU       : Real   = 0.0127;
  fi       : Real   = 0;
  VelAng   = 1;

implementation

uses PrntComp;

{$R *.DFM}

procedure TMainForm.TerminarClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.AbrirClick(Sender: TObject);

var
  i          : byte;
  fin        : TextFile;
  vmed, vmax : Real;
  med, max   : string[5];

begin
  If OpenDialog.Execute Then
    begin
      NuevoForm.NuevoClose.Enabled := True;
      Guardar.Enabled := True;
      Calculo.Enabled := True;
      TBGuardar.Enabled := True;
      TBCalculos.Enabled := True;
      If Not Profundidad.Enabled Then
        begin
          Profundidad.Enabled := True;
          Velocidades.Enabled := True;
          Latitud.Enabled := True;
          ComboBoxCU.Enabled := True;
        end;
      AssignFile(fin, OpenDialog.FileName);
      Reset(fin);
      for i := 1 to 16 do
        begin
          Readln(fin, vmed, vmax);
          Str(vmed:3:1, med);
          NuevoForm.StringGridDatos.Cells[1,i] := med;
          Str(vmax:3:1, max);
          NuevoForm.StringGridDatos.Cells[2,i] := max;
        end;
      CloseFile(fin);
      NuevoForm.NuevoClose.Enabled := True;
      NuevoForm.Cargar := True;
      NuevoForm.Caption := OpenDialog.FileName;
      NuevoForm.Show;
      Guardarcomo.Enabled := True;
    end;
end;

procedure TMainForm.GuardarClick(Sender: TObject);

var
  i     : byte;
  fout : TextFile;

begin
  If NuevoForm.Caption = 'Sin nombre' Then
    begin
      SaveDialog.FileName := NuevoForm.Caption;
      If Not SaveDialog.Execute Then
        begin
          MessageDlg('Operación Guardar Cancelada', mtInformation, [mbOK], 0);
          Exit;
        end;
       NuevoForm.Caption := SaveDialog.FileName;
       AssignFile(fout, SaveDialog.FileName);
    end
  Else
    AssignFile(fout, NuevoForm.Caption);
  Rewrite(fout);
  for i := 1 to 16 do
    Writeln(fout,NuevoForm.StringGridDatos.Cells[1,i], '   ',
                 NuevoForm.StringGridDatos.Cells[2,i]);
  CloseFile(fout);
  NuevoForm.Caption := SaveDialog.FileName;
  NuevoForm.NuevoClose.Enabled := True;
end;

procedure TMainForm.ImprimirClick(Sender: TObject);
begin
  If PrintDialog.Execute Then
    PrintPage(CalcSPForm.ScrollBox1, 0)
end;

procedure TMainForm.NuevoClick(Sender: TObject);
begin
  NuevoForm.NuevoClose.Enabled := True;
  Guardar.Enabled := True;
  Calculo.Enabled := True;
  TBGuardar.Enabled := True;
  TBCalculos.Enabled := True;
  If Not Profundidad.Enabled Then
    begin
      Profundidad.Enabled := True;
      Velocidades.Enabled := True;
      Latitud.Enabled := True;
      ComboBoxCU.Enabled := True;
    end;
  NuevoForm.Cargar := False;
  NuevoForm.Caption := 'Sin nombre';
  NuevoForm.Show;
end;

procedure TMainForm.CalculoClick(Sender: TObject);

var
  lat, latmsg   : String;
begin
  fi := Latitud.Value;
  Str(fi:2:2, lat);
  latmsg := 'Latitud = ' + lat + '. Abortar Cálculos?';
  If MessageDlg(latmsg, mtConfirmation,
                [mbYes, mbNo], 0) = mrYes Then
    Exit;
  Profundidad.Enabled := False;
  Latitud.Enabled := False;
  If Profundidad.Checked Then
    begin
      CalcSPForm.Proxima.Visible := False;
      CalcSPForm.Anterior.Visible := False;
      CalcSPForm.StaticText1.Visible := False;
      CalcSPForm.EditProfundidad.Visible := False;
    end
  Else
    begin
      CalcSPForm.Proxima.Visible := True;
      CalcSPForm.Anterior.Visible := True;
      CalcSPForm.StaticText1.Visible := True;
      CalcSPForm.EditProfundidad.Visible := True;
      SProfForm.Show;
    end;
  CalcSPForm.Show;
  Imprimir.Enabled := True;
  ToolbarButtonImprimir.Enabled := True;
end;

procedure TMainForm.ComboBoxCUKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key Of
    'm', 'M' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Mohn';
                 CU := 0.0103;
               end;
    'd', 'D' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Dinklage';
                 CU := 0.0127;
               end;
    'w', 'W' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Witting';
                 CU := 0.0100;
               end;
    't', 'T' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Thorade';
                 CU := 0.0126;
               end;
    'p', 'P' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Palmén';
                 CU := 0.0114;
               end;
    'n', 'N' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Nansen';
                 CU := 0.0190;
               end;
    's', 'S' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Sverdrup';
                 CU := 0.0177;
               end;
    'b', 'B' : begin
                 Key := #0;
                 ComboBoxCU.Text := 'Bennecke';
                 CU := 0.0269;
               end;
  Else
    begin
      Key := #0;
      ComboBoxCU.Text := 'Dinklage';
      CU := 0.0127;
    end
  end;
  CalcSPForm.Anterior.Enabled := False;
  CalcSPForm.i := 0;
  CalcSPForm.EditProfundidad.Caption := SProfForm.ListBoxProf.Items[CalcSPForm.i];
end;

procedure TMainForm.ComboBoxCUChange(Sender: TObject);

begin
  If ComboBoxCU.Text = 'Mohn' Then
    CU := 0.0103;
  If ComboBoxCU.Text = 'Dinklage' Then
    CU := 0.0127;
  If ComboBoxCU.Text = 'Witting' Then
    CU := 0.0100;
  If ComboBoxCU.Text = 'Thorade' Then
    CU := 0.0126;
  If ComboBoxCU.Text = 'Palmén' Then
    CU := 0.0114;
  If ComboBoxCU.Text = 'Nansen' Then
    CU := 0.0190;
  If ComboBoxCU.Text = 'Sverdrup' Then
    CU := 0.0177;
  If ComboBoxCU.Text = 'Bennecke' Then
    CU := 0.01269;
  CalcSPForm.Anterior.Enabled := False;
  CalcSPForm.i := 0;
  CalcSPForm.EditProfundidad.Caption := SProfForm.ListBoxProf.Items[CalcSPForm.i];
end;

procedure TMainForm.GuardarcomoClick(Sender: TObject);

var
  i     : byte;
  fout : TextFile;

begin
  Abrir.Enabled := False;
  If SaveDialog.Execute Then
    begin
      AssignFile(fout, SaveDialog.FileName);
      Rewrite(fout);
      for i := 1 to 16 do
        Writeln(fout,NuevoForm.StringGridDatos.Cells[1,i], '   ',
                     NuevoForm.StringGridDatos.Cells[2,i]);
      CloseFile(fout);
      NuevoForm.Caption := SaveDialog.FileName;
      Abrir.Enabled := True;
      NuevoForm.NuevoClose.Enabled := True;
    end
end;

procedure TMainForm.ProfundidadClick(Sender: TObject);
begin
  If Not Profundidad.Checked Then
    Densidad.Enabled := True
  Else
    Densidad.Enabled := False
end;

procedure TMainForm.DensidadChange(Sender: TObject);
begin
  If Densidad.Value < 1 Then
    begin
      MessageDlg('Densidad incorrecta', mtInformation, [mbOK], 0);
      Densidad.Value := 1;
    end;
  CalcSPForm.Anterior.Enabled := False;
  CalcSPForm.i := 0;
  CalcSPForm.EditProfundidad.Caption := SProfForm.ListBoxProf.Items[CalcSPForm.i];
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Splash.ShowModal
end;

end.
