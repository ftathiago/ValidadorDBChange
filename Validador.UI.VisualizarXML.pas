unit Validador.UI.VisualizarXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Xml.Win.msxmldom, Xml.omnixmldom,
  Xml.adomxmldom;

type
  TVisualizarXML = class(TFrame)
    memoXML: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionList: TActionList;
    actAbrirArquivo: TAction;
    ToolButton2: TToolButton;
    actSalvarArquivo: TAction;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    actSelecionarTudo: TAction;
    actCopiarXML: TAction;
    ToolButton3: TToolButton;
    procedure actAbrirArquivoExecute(Sender: TObject);
    procedure actSalvarArquivoExecute(Sender: TObject);
    procedure actSelecionarTudoExecute(Sender: TObject);
    procedure actCopiarXMLExecute(Sender: TObject);
  private
    function GetXML: WideString;
    procedure ConfigurarXML(const AXMLDocument: IXMLDocument);
  public
    procedure AfterConstruction; override;
    procedure SetDiretorioBase(const ADiretorioBase: string);
    procedure SetXML(const AXML: TStrings);
    function GetXMLDocument: IXMLDocument;
    property Xml: WideString read GetXML;
  end;

implementation

{$R *.dfm}

uses Validador.Data.dbChangeXML;

procedure TVisualizarXML.AfterConstruction;
begin
  inherited;
  memoXML.Lines.DefaultEncoding := TUTF8Encoding.UTF8;
end;

procedure TVisualizarXML.actAbrirArquivoExecute(Sender: TObject);
begin
  if Not OpenDialog.Execute then
    Exit;
  memoXML.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TVisualizarXML.actCopiarXMLExecute(Sender: TObject);
begin
  actSelecionarTudo.Execute;
  memoXML.CopyToClipboard;
end;

procedure TVisualizarXML.actSalvarArquivoExecute(Sender: TObject);
var
  _xmlDocument: IXMLDocument;
  _stream: TMemoryStream;
begin
  if not SaveDialog.Execute then
    Exit;
  _xmlDocument := GetXMLDocument;
  _xmlDocument.SaveToFile(SaveDialog.FileName);

  _stream := TMemoryStream.Create;
  try
    _xmlDocument.SaveToStream(_stream);
    _stream.Position := 0;
    _stream.SaveToFile(SaveDialog.FileName);
  finally
    FreeAndNil(_stream);
  end;
end;

procedure TVisualizarXML.actSelecionarTudoExecute(Sender: TObject);
begin
  memoXML.SelectAll;
end;

function TVisualizarXML.GetXML: WideString;
var
  _xmlDocument: IXMLDocument;
begin
  _xmlDocument := GetXMLDocument;
  Result := _xmlDocument.Xml.Text;
end;

function TVisualizarXML.GetXMLDocument: IXMLDocument;
var
  _xmlDocument: IXMLDocument;
begin
  _xmlDocument := LoadXMLData(memoXML.Text);
  ConfigurarXML(_xmlDocument);
  Result := _xmlDocument;
end;

procedure TVisualizarXML.ConfigurarXML(const AXMLDocument: IXMLDocument);
begin
  AXMLDocument.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix,
    doNamespaceDecl, doAutoSave];
  AXMLDocument.Active := True;
end;

procedure TVisualizarXML.SetDiretorioBase(const ADiretorioBase: string);
begin
  OpenDialog.InitialDir := ADiretorioBase;
  SaveDialog.InitialDir := ADiretorioBase;
end;

procedure TVisualizarXML.SetXML(const AXML: TStrings);
var
  _stream: TMemoryStream;
begin
  _stream := TMemoryStream.Create;
  try
    AXML.SaveToStream(_stream);
    _stream.Position := 0;
    memoXML.Lines.Clear;
    memoXML.Lines.LoadFromStream(_stream);
  finally
    FreeAndNil(_stream);
  end;
end;

end.
