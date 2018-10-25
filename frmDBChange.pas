unit frmDBChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, dbChange, Vcl.ComCtrls;

type
  TTipoFiltro = (tfTodos, tfRepetidos, tfImportar);
  TTipoFiltroAnalise = (tfaTodos, tfaScriptSemArquivo, tfaArquivoSemScript);

  TfrmValidadorDBChange = class(TForm)
    pnlAbrirDbChange: TPanel;
    edtFileName: TEdit;
    btnAbrirDbChange: TSpeedButton;
    FileOpenDialog: TFileOpenDialog;
    DBGrid1: TDBGrid;
    dtsDBChange: TDataSource;
    cdsDBChange: TFDMemTable;
    cdsDBChangeVersao: TStringField;
    cdsDBChangeDescricao: TStringField;
    cdsDBChangeZDescricao: TStringField;
    cdsDBChangeTemPos: TBooleanField;
    cdsDBChangeNome: TStringField;
    cdsDBChangeValue: TStringField;
    cdsDBChangeRepetido: TBooleanField;
    SpeedButton1: TSpeedButton;
    PageControl1: TPageControl;
    tbsScript: TTabSheet;
    TabSheet1: TTabSheet;
    memXML: TMemo;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    rgpFiltro: TRadioGroup;
    edtLocalizarSCRIPT: TEdit;
    Label1: TLabel;
    cdsDBChangeImportar: TBooleanField;
    cdsDBChangeOrdemOriginal: TIntegerField;
    SaveDialog: TSaveDialog;
    cdsArquivos: TFDMemTable;
    cdsArquivosPATH: TStringField;
    Analisar: TSpeedButton;
    tbsRelacaoScriptArquivo: TTabSheet;
    DBGrid2: TDBGrid;
    dtsArquivos: TDataSource;
    DirOpen: TOpenDialog;
    cdsDBChangeExisteNaPasta: TBooleanField;
    cdsAnalise: TFDMemTable;
    cdsAnaliseNOME_SCRIPT: TStringField;
    cdsAnaliseNOME_ARQUIVO: TStringField;
    cdsArquivosNOME_ARQUIVO: TStringField;
    dtsAnalise: TDataSource;
    Panel3: TPanel;
    rgpFiltroAnalise: TRadioGroup;
    edtLocalizarScriptAnalise: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnAbrirDbChangeClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure cdsDBChangeNewRecord(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure rgpFiltroClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edtLocalizarSCRIPTChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure AnalisarClick(Sender: TObject);
    procedure edtLocalizarScriptAnaliseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rgpFiltroAnaliseClick(Sender: TObject);
  private
    { Private declarations }
    FNomeArquivoXML: TFileName;
    procedure AbrirDBChange(const AFileName: TFileName);
    procedure MarcarRepetidos(const ANome: string);
    procedure AplicarFiltro(const AFiltro: TTipoFiltro);
    procedure AplicarFiltroAnalise(const AFiltro: TTipoFiltroAnalise);
    procedure DataSetToXML(const AXMLDoc: IXMLDocument);
    procedure AtribuirNomeScriptAoXML(_script: IXMLScriptType);
    procedure DefinirTemPos(_script: IXMLScriptType);
  public
    { Public declarations }
  end;

var
  frmValidadorDBChange: TfrmValidadorDBChange;

implementation

{$R *.dfm}

uses
  System.StrUtils, uLocalizadorScript, uAnalizadorScript;

procedure TfrmValidadorDBChange.AbrirDBChange(const AFileName: TFileName);
var
  _havillan: IXMLHavillanType;
  _script: IXMLScriptType;
  _xmlDoc: IXMLDocument;
  i: integer;
begin
  _xmlDoc := TXMLDocument.Create(AFileName);
  _xmlDoc.Encoding := 'UTF-8';
  _havillan := _xmlDoc.GetDocBinding('havillan', TXMLHavillanType) as IXMLHavillanType;
  cdsDBChange.DisableControls;
  for i := 0 to Pred(_havillan.Count) do
  begin
    _script := _havillan.Script[i];
    if _script.A_name.Trim.IsEmpty and _script.Text.Trim.IsEmpty then
      Continue;
    cdsDBChange.Insert;
    cdsDBChangeOrdemOriginal.AsInteger := i;
    cdsDBChangeVersao.AsString := _script.Version;
    cdsDBChangeDescricao.AsString := _script.Description;
    cdsDBChangeZDescricao.AsString := _script.Z_description;
    cdsDBChangeNome.AsString := _script.A_name;
    if not _script.X_has_pos.Trim.IsEmpty then
      cdsDBChangeTemPos.AsBoolean := _script.X_has_pos.Trim.ToUpper.Equals('TRUE');

    if not _script.Text.Trim.IsEmpty then
    begin
      cdsDBChangeValue.AsString := _script.Text;
      cdsDBChangeNome.AsString := _script.Text;
    end;
    cdsDBChange.Post;
  end;
  cdsDBChange.EnableControls;
end;

procedure TfrmValidadorDBChange.AnalisarClick(Sender: TObject);
begin
  TAnalisadorScript.New(cdsAnalise, cdsDBChange, cdsArquivos).Analisar;
end;

procedure TfrmValidadorDBChange.AplicarFiltro(const AFiltro: TTipoFiltro);
begin
  rgpFiltro.ItemIndex := Ord(AFiltro);
  case AFiltro of
    tfTodos:
      begin
        cdsDBChange.Filter := EmptyStr;
      end;
    tfRepetidos:
      begin
        cdsDBChange.Filter := 'REPETIDO = TRUE';
      end;
    tfImportar:
      begin
        cdsDBChange.Filter := 'IMPORTAR = TRUE';
      end;
  end;
  cdsDBChange.Filtered := AFiltro <> tfTodos;
end;

procedure TfrmValidadorDBChange.AplicarFiltroAnalise(const AFiltro: TTipoFiltroAnalise);
const
  FILTRAR_N_REGISTROS = ' Filtrar (%d registros) ';
begin
  case AFiltro of
    tfaTodos:
      begin
        cdsAnalise.Filter := EmptyStr;
      end;
    tfaScriptSemArquivo:
      begin
        cdsAnalise.Filter := '(NOME_SCRIPT IS NOT NULL) AND (NOME_ARQUIVO IS NULL)';
      end;
    tfaArquivoSemScript:
      begin
        cdsAnalise.Filter := '(NOME_SCRIPT IS NULL) AND (NOME_ARQUIVO IS NOT NULL)';
      end;
  end;
  cdsAnalise.Filtered := AFiltro <> tfaTodos;
  rgpFiltroAnalise.ItemIndex := Ord(AFiltro);
  rgpFiltroAnalise.Caption := Format(FILTRAR_N_REGISTROS, [cdsAnalise.RecordCount]);
end;

procedure TfrmValidadorDBChange.btnAbrirDbChangeClick(Sender: TObject);
begin
  if not FileOpenDialog.Execute then
    exit;

  cdsDBChange.EmptyDataSet;
  FNomeArquivoXML := FileOpenDialog.FileName;
  edtFileName.Text := FNomeArquivoXML;
  memXML.Lines.DefaultEncoding := TUTF8Encoding.Create;
  memXML.Lines.LoadFromFile(FNomeArquivoXML);
  AbrirDBChange(FNomeArquivoXML);
end;

procedure TfrmValidadorDBChange.cdsDBChangeNewRecord(DataSet: TDataSet);
begin
  cdsDBChangeRepetido.AsBoolean := False;
  cdsDBChangeImportar.AsBoolean := True;
  cdsDBChangeExisteNaPasta.AsBoolean := True;
end;

procedure TfrmValidadorDBChange.DataSetToXML(const AXMLDoc: IXMLDocument);
var
  _havillan: IXMLHavillanType;
  _script: IXMLScriptType;
  _tempFiltro: TTipoFiltro;
  _tempOrdem: string;
begin
  _tempFiltro := TTipoFiltro(rgpFiltro.ItemIndex);
  _tempOrdem := cdsDBChange.IndexFieldNames;
  try
    AplicarFiltro(tfImportar);
    cdsDBChange.IndexFieldNames := 'OrdemOriginal';

    _havillan := AXMLDoc.GetDocBinding('havillan', TXMLHavillanType, TargetNamespace)
      as IXMLHavillanType;
    cdsDBChange.First;
    while not cdsDBChange.Eof do
    begin
      _script := _havillan.Add;

      AtribuirNomeScriptAoXML(_script);

      if not cdsDBChangeVersao.AsString.Trim.IsEmpty then
        _script.Version := cdsDBChangeVersao.AsString;

      DefinirTemPos(_script);

      if not cdsDBChangeDescricao.AsString.Trim.IsEmpty then
        _script.Description := cdsDBChangeDescricao.AsString;

      if not cdsDBChangeZDescricao.AsString.Trim.IsEmpty then
        _script.Z_description := cdsDBChangeZDescricao.AsString;

      if not cdsDBChangeValue.AsString.Trim.IsEmpty then
        _script.Text := cdsDBChangeValue.AsString;

      cdsDBChange.Next;
    end;
  finally
    AplicarFiltro(_tempFiltro);
    cdsDBChange.IndexFieldNames := _tempOrdem;
  end;
end;

procedure TfrmValidadorDBChange.AtribuirNomeScriptAoXML(_script: IXMLScriptType);
begin
  if not cdsDBChangeValue.IsNull then
    exit;

  if not cdsDBChangeNome.AsString.Trim.IsEmpty then
    _script.A_name := cdsDBChangeNome.AsString;
end;

procedure TfrmValidadorDBChange.DefinirTemPos(_script: IXMLScriptType);
begin
  if cdsDBChangeTemPos.IsNull then
    exit;

  _script.X_has_pos := 'False';
  if cdsDBChangeTemPos.AsBoolean then
    _script.X_has_pos := 'True';
end;

procedure TfrmValidadorDBChange.DBGrid1TitleClick(Column: TColumn);
begin
  cdsDBChange.IndexFieldNames := Column.Field.FieldName;
end;

procedure TfrmValidadorDBChange.edtLocalizarScriptAnaliseKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  _script: string;
begin
  _script := edtLocalizarScriptAnalise.Text;

  if cdsAnalise.IsEmpty then
    exit;
  if _script.Trim.IsEmpty then
    exit;
  if cdsAnalise.Locate('NOME_SCRIPT', _script, [loPartialKey, loCaseInsensitive]) then
    exit;
  cdsAnalise.Locate('NOME_ARQUIVO', _script, [loPartialKey, loCaseInsensitive]);
end;

procedure TfrmValidadorDBChange.edtLocalizarSCRIPTChange(Sender: TObject);
begin
  if not cdsDBChange.Active then
    exit;

  cdsDBChange.First;
  cdsDBChange.Locate('Nome', edtLocalizarSCRIPT.Text, [loPartialKey, loCaseInsensitive]);
end;

procedure TfrmValidadorDBChange.FormCreate(Sender: TObject);
begin
  cdsDBChange.CreateDataSet;
  cdsArquivos.CreateDataSet;
  cdsAnalise.CreateDataSet;
end;

procedure TfrmValidadorDBChange.MarcarRepetidos(const ANome: string);
begin
  cdsDBChange.Next;

  if cdsDBChange.Eof then
    exit;

  cdsDBChange.Edit;
  cdsDBChangeRepetido.AsBoolean := cdsDBChangeNome.AsString.Equals(ANome) or
    cdsDBChangeValue.AsString.Equals(ANome);
  cdsDBChangeImportar.AsBoolean := not cdsDBChangeRepetido.AsBoolean;
  cdsDBChange.Post;
  if cdsDBChangeRepetido.AsBoolean then
  begin
    cdsDBChange.Prior;
    cdsDBChange.Edit;
    cdsDBChangeRepetido.AsBoolean := cdsDBChangeNome.AsString.Equals(ANome);
    //cdsDBChangeImportar.AsBoolean := not cdsDBChangeRepetido.AsBoolean;
    cdsDBChange.Post;
    cdsDBChange.Next;
  end;

  MarcarRepetidos(cdsDBChangeNome.AsString);
end;

procedure TfrmValidadorDBChange.rgpFiltroAnaliseClick(Sender: TObject);
begin
  AplicarFiltroAnalise(TTipoFiltroAnalise(rgpFiltroAnalise.ItemIndex));
end;

procedure TfrmValidadorDBChange.rgpFiltroClick(Sender: TObject);
begin
  AplicarFiltro(TTipoFiltro(rgpFiltro.ItemIndex));
end;

procedure TfrmValidadorDBChange.SpeedButton1Click(Sender: TObject);
begin
  cdsDBChange.IndexFieldNames := 'Nome';
  cdsDBChange.First;
  cdsDBChange.DisableControls;
  MarcarRepetidos(cdsDBChangeNome.AsString);
  cdsDBChange.EnableControls;
end;

procedure TfrmValidadorDBChange.SpeedButton2Click(Sender: TObject);
var
  _xmlDoc: IXMLDocument;
  _stream: TMemoryStream;
begin
  _xmlDoc := TXMLDocument.Create(nil);
  _xmlDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl,
    doAutoSave];

  DataSetToXML(_xmlDoc);

  _xmlDoc.Version := '1.0';
  _xmlDoc.Encoding := 'UTF-8';
  _xmlDoc.StandAlone := 'no';

  _stream := TMemoryStream.Create;
  try
    _xmlDoc.SaveToStream(_stream);
    _stream.position := 0;
    memXML.Lines.Clear;
    memXML.Lines.LoadFromStream(_stream);
  finally
    FreeAndNil(_stream);
  end;
end;

procedure TfrmValidadorDBChange.SpeedButton4Click(Sender: TObject);
begin
  if not SaveDialog.Execute then
    exit;
  memXML.Lines.SaveToFile(SaveDialog.FileName);
end;

end.
