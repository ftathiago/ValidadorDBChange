unit frmDBChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, dbChange, Vcl.ComCtrls, Validador.UI.FormBase,
  Validador.Data.FDDbChange;

type
  TTipoFiltro = (tfTodos, tfRepetidos, tfImportar);

  TfrmValidadorDBChange = class(TFormBase)
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
  private
    { Private declarations }
    FNomeArquivoXML: TFileName;
    procedure AbrirDBChange(const AFileName: TFileName);
    procedure MarcarRepetidos(const ANome: string);
    procedure AplicarFiltro(const AFiltro: TTipoFiltro);
    procedure MostrarXMLNoMemo(const AXMLDocument: IXMLDocument);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils, uLocalizadorScript, uAnalizadorScript, Validador.DI,
  Validador.Core.ConversorXMLDataSet;

procedure TfrmValidadorDBChange.AbrirDBChange(const AFileName: TFileName);
var
  _xmlDoc: IXMLDocument;
  _conversor: IConversorXMLDataSet;
  _dbChangeDataSet: TFDDbChange;
begin
  _xmlDoc := TXMLDocument.Create(AFileName);
  _dbChangeDataSet := TFDDbChange.Create(nil);
  try
    _dbChangeDataSet.CreateDataSet;
    _xmlDoc.Encoding := 'UTF-8';
    _conversor := Validador.DI.ContainerDI.Resolve<IConversorXMLDataSet>;
    _conversor.SetXML(_xmlDoc);
    _conversor.SetDataSet(_dbChangeDataSet);
    _conversor.ConverterParaDataSet;
  finally
    cdsDBChange.Close;
    cdsDBChange.Data := _dbChangeDataSet.Data;
    _dbChangeDataSet.Close;
    FreeAndNil(_dbChangeDataSet);
  end;
end;

procedure TfrmValidadorDBChange.AnalisarClick(Sender: TObject);
begin
  Validador.DI.ContainerDI.Resolve<IAnalisadorScript>.SetAnalise(cdsAnalise)
    .SetDBChange(cdsDBChange).SetArquivos(cdsArquivos).Analisar;
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

procedure TfrmValidadorDBChange.MostrarXMLNoMemo(const AXMLDocument: IXMLDocument);
var
  _stream: TMemoryStream;
begin
  _stream := TMemoryStream.Create;
  try
    AXMLDocument.SaveToStream(_stream);
    _stream.position := 0;
    memXML.Lines.Clear;
    memXML.Lines.LoadFromStream(_stream);
  finally
    FreeAndNil(_stream);
  end;
end;

procedure TfrmValidadorDBChange.DBGrid1TitleClick(Column: TColumn);
begin
  cdsDBChange.IndexFieldNames := Column.Field.FieldName;
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
end;

procedure TfrmValidadorDBChange.MarcarRepetidos(const ANome: string);
begin
  cdsDBChange.Next;

  if cdsDBChange.Eof then
    exit;

  cdsDBChange.Edit;
  cdsDBChangeRepetido.AsBoolean := cdsDBChangeNome.AsString.Equals(ANome) or
    cdsDBChangeValue.AsString.Equals(ANome);
  cdsDBChange.Post;
  if cdsDBChangeRepetido.AsBoolean then
  begin
    cdsDBChange.Prior;
    cdsDBChange.Edit;
    cdsDBChangeRepetido.AsBoolean := cdsDBChangeNome.AsString.Equals(ANome);
    cdsDBChangeImportar.AsBoolean := not cdsDBChangeRepetido.AsBoolean;
    cdsDBChange.Post;
    cdsDBChange.Next;
  end;

  MarcarRepetidos(cdsDBChangeNome.AsString);
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
  _conversor: IConversorXMLDataSet;
  _dbChangeDS: TFDDbChange;
begin
  _xmlDoc := NewXMLDocument;
  _dbChangeDS := TFDDbChange.Create(Nil);
  _conversor := ContainerDI.Resolve<IConversorXMLDataSet>;
  try
    _dbChangeDS.Data := cdsDBChange.Data;
    _xmlDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix,
      doNamespaceDecl, doAutoSave];

    _conversor.SetXML(_xmlDoc);
    _conversor.SetDataSet(_dbChangeDS);
    _conversor.DataSetParaImportacao;

    _xmlDoc.Version := '1.0';
    _xmlDoc.Encoding := 'UTF-8';
    _xmlDoc.StandAlone := 'no';
    MostrarXMLNoMemo(_xmlDoc);
  finally
    _dbChangeDS.Close;
    FreeAndNil(_dbChangeDS);
  end;
end;

procedure TfrmValidadorDBChange.SpeedButton4Click(Sender: TObject);
begin
  if not SaveDialog.Execute then
    exit;
  memXML.Lines.SaveToFile(SaveDialog.FileName);
end;

end.
