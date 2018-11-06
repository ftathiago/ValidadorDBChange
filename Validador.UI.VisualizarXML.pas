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
    procedure actAbrirArquivoExecute(Sender: TObject);
    procedure actSalvarArquivoExecute(Sender: TObject);
  private
    function GetXML: WideString;
    procedure XMLToMemo(const AXMLDocument: IXMLDocument);
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

uses dbChange;

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

procedure TVisualizarXML.actSalvarArquivoExecute(Sender: TObject);
var
  _xmlDocument: IXMLDocument;
begin
  if not SaveDialog.Execute then
    Exit;
  _xmlDocument := GetXMLDocument;
  _xmlDocument.SaveToFile(SaveDialog.FileName);
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
  AXMLDocument.ParseOptions := [poPreserveWhiteSpace];
  AXMLDocument.NodeIndentStr := '++';
  AXMLDocument.Active := True;
  AXMLDocument.Version := '1.0';
  AXMLDocument.Encoding := 'UTF-8';
  AXMLDocument.StandAlone := 'no';
end;

procedure TVisualizarXML.SetDiretorioBase(const ADiretorioBase: string);
begin
  OpenDialog.InitialDir := ADiretorioBase;
  SaveDialog.InitialDir := ADiretorioBase;
end;

procedure TVisualizarXML.SetXML(const AXML: TStrings);
var
  _xmlDocument: IXMLDocument;
begin
  _xmlDocument := NewXMLDocument;
  _xmlDocument.XML.Text := AXML.Text;
  ConfigurarXML(_xmlDocument);
  XMLToMemo(_xmlDocument);
end;

procedure TVisualizarXML.XMLToMemo(const AXMLDocument: IXMLDocument);
var
  _stream: TMemoryStream;
begin
  AXMLDocument.Version := '1.0';
  AXMLDocument.Encoding := 'UTF-8';
  AXMLDocument.StandAlone := 'no';

  _stream := TMemoryStream.Create;
  try
    AXMLDocument.SaveToStream(_stream);
    _stream.position := 0;
    memoXML.Lines.Clear;
    memoXML.Lines.LoadFromStream(_stream);
  finally
    FreeAndNil(_stream);
  end;
end;

end.
