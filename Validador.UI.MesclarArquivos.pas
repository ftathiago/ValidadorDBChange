unit Validador.UI.MesclarArquivos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Validador.UI.FormBase, Vcl.ExtCtrls,
  Validador.UI.VisualizarXML, Vcl.StdCtrls, Validador.Data.FDdbChange, Xml.XMLIntf, Vcl.ComCtrls;

type
  TMesclarArquivos = class(TFormBase)
    GridPanel1: TGridPanel;
    Label1: TLabel;
    Label3: TLabel;
    VisualizarXML1: TVisualizarXML;
    Splitter1: TSplitter;
    VisualizarXML2: TVisualizarXML;
    pnlProximo: TPanel;
    btnProximo: TButton;
    pgcEtapas: TPageControl;
    tbsArquivos: TTabSheet;
    tbsFinal: TTabSheet;
    VisualizarXML3: TVisualizarXML;
    procedure btnProximoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UnificarXML(const AXMLUnificado: IXMLDocument; const AdbChangeDS: TFDDbChange);
    procedure ConverterParaDataSet(_xmlUnificado: IXMLDocument; _dbChangeDataSet: TFDDbChange);
    procedure GerarXMLSemRepetidos(const ADbChangeDataSet: TFDDbChange;
      const _novoXML: IXMLDocument);
    procedure MostrarXML(_novoXML: IXMLDocument);
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

var
  MesclarArquivos: TMesclarArquivos;

implementation

{$R *.dfm}

uses
  Validador.DI, Validador.Core.ConversorXMLDataSet, Validador.Core.UnificadorXML, dbChange,
  Xml.XMLDoc, FireDAC.Stan.StorageXML;

procedure TMesclarArquivos.FormCreate(Sender: TObject);
begin
  inherited;
  pgcEtapas.ActivePageIndex := 0;
end;

procedure TMesclarArquivos.AfterConstruction;
begin
  inherited;
  VisualizarXML1.SetDiretorioBase(DiretorioBase);
  VisualizarXML2.SetDiretorioBase(DiretorioBase);
end;

procedure TMesclarArquivos.btnProximoClick(Sender: TObject);
var
  _xmlUnificado: IXMLDocument;
  _dbChangeDataSet: TFDDbChange;
  _novoXML: IXMLDocument;
begin
  inherited;
  _dbChangeDataSet := TFDDbChange.Create(nil);
  _novoXML := NewXMLDocument;
  _xmlUnificado := NewXMLDocument;
  try
    _novoXML.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix,
      doNamespaceDecl, doAutoSave];
    _novoXML.NodeIndentStr := '  ';

    _xmlUnificado.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix,
      doNamespaceDecl, doAutoSave];
    _xmlUnificado.NodeIndentStr := '  ';

    _dbChangeDataSet.CreateDataSet;

    UnificarXML(_xmlUnificado, _dbChangeDataSet);
    ConverterParaDataSet(_xmlUnificado, _dbChangeDataSet);
    GerarXMLSemRepetidos(_dbChangeDataSet, _novoXML);
    MostrarXML(_novoXML);
  finally
    _dbChangeDataSet.Close;
    FreeAndNil(_dbChangeDataSet);
  end;
end;

procedure TMesclarArquivos.UnificarXML(const AXMLUnificado: IXMLDocument;
  const AdbChangeDS: TFDDbChange);
var
  _unificador: IUnificadorXML;
begin
  _unificador := Validador.DI.ContainerDI.Resolve<IUnificadorXML>;
  _unificador.SetXMLAnterior(VisualizarXML2.GetXMLDocument);
  _unificador.SetXMLNovo(VisualizarXML1.GetXMLDocument);
  _unificador.PegarXMLMesclado(AXMLUnificado);
end;

procedure TMesclarArquivos.ConverterParaDataSet(_xmlUnificado: IXMLDocument;
  _dbChangeDataSet: TFDDbChange);
var
  _conversor: IConversorXMLDataSet;
begin
  _conversor := ContainerDI.Resolve<IConversorXMLDataSet>;
  _conversor.SetXML(_xmlUnificado);
  _conversor.SetDataSet(_dbChangeDataSet);
  _conversor.ConverterParaDataSet;
end;

procedure TMesclarArquivos.GerarXMLSemRepetidos(const ADbChangeDataSet: TFDDbChange;
  const _novoXML: IXMLDocument);
var
  _conversor: IConversorXMLDataSet;
begin
  ADbChangeDataSet.MarcarRepetidos;
  _conversor := ContainerDI.Resolve<IConversorXMLDataSet>;
  _conversor.SetXML(_novoXML);
  _conversor.SetDataSet(ADbChangeDataSet);
  _conversor.DataSetParaImportacao;
end;

procedure TMesclarArquivos.MostrarXML(_novoXML: IXMLDocument);
begin
  VisualizarXML3.SetXML(_novoXML.Xml);
  pgcEtapas.ActivePage := tbsFinal;
end;

end.
