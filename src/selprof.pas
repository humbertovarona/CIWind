unit selprof;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, RZNEdit;

type
  TSProfForm = class(TForm)
    Eliminar: TBitBtn;
    Adicionar: TBitBtn;
    ListBoxProf: TListBox;
    LabelCant: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    PopupMenuSP: TPopupMenu;
    GuardarProf: TMenuItem;
    AbrirProf: TMenuItem;
    EditProf: TRealEdit;    
    procedure AdicionarClick(Sender: TObject);
    procedure EliminarClick(Sender: TObject);
    procedure EditProfChange(Sender: TObject);
    procedure ListBoxProfClick(Sender: TObject);
    procedure GuardarProfClick(Sender: TObject);
    procedure AbrirProfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Modificado : Boolean;
  end;

var
  SProfForm: TSProfForm;

implementation

{$R *.DFM}

procedure TSProfForm.AdicionarClick(Sender: TObject);
begin
  If EditProf.Value <> 0 Then
    begin
      ListBoxProf.Items.Add(EditProf.Text);
      Modificado := True;
      EditProf.Value := 0;
      LabelCant.Caption := IntToStr(ListBoxProf.Items.Count);
      GuardarProf.Enabled := True;
      Adicionar.Enabled := False;
    end;
end;

procedure TSProfForm.EliminarClick(Sender: TObject);
begin
  If ListBoxProf.ItemIndex > -1 Then
    begin
      ListBoxProf.Items.Delete(ListBoxProf.ItemIndex);
      Modificado := True;
      LabelCant.Caption := IntToStr(ListBoxProf.Items.Count);
      GuardarProf.Enabled := True;
      Adicionar.Enabled := False;
      If ListBoxProf.Items.Count = 0 Then
        begin
          Eliminar.Enabled := False;
          GuardarProf.Enabled := False;
        end;
//      If Not ListBoxProf.Focused Then
//        Eliminar.Enabled := False;
    end;
end;

procedure TSProfForm.EditProfChange(Sender: TObject);
begin
  Adicionar.Enabled := True;
end;

procedure TSProfForm.ListBoxProfClick(Sender: TObject);
begin
  If ListBoxProf.Focused Then
    Eliminar.Enabled := True
end;

procedure TSProfForm.GuardarProfClick(Sender: TObject);
begin
  ListBoxProf.Items.SaveToFile('profundidades.zh');
end;

procedure TSProfForm.AbrirProfClick(Sender: TObject);
begin
  ListBoxProf.Items.LoadFromFile('profundidades.zh');
  LabelCant.Caption := IntToStr(ListBoxProf.Items.Count);
  Modificado := True;
end;

end.
