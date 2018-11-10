unit Validador.Core.Impl.UnificadorXML;

interface

implementation

uses
  System.SysUtils, Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf, Validador.DI, Validador.Data.dbChangeXML,
  Validador.Core.UnificadorXML;

type
  TUnificadorXML = class(TInterfacedObject, IUnificadorXML)
  private
    FXMLAnterior: IXMLDocument;
    FXMLNovo: IXMLDocument;
    procedure Mesclar(const AXMLUnificado: IXMLHavillanType);
    procedure CopiarScript(_xmlNovoScript, _xmlScript: IXMLScriptType);
    procedure CopiarXMLNovo(const AXMLUnificado: IXMLHavillanType);
    procedure CopiarXMLAnterior(const AXMLUnificado: IXMLHavillanType);
  public
    procedure PegarXMLMesclado(const AXMLDocument: IXMLDocument);
    procedure SetXMLAnterior(const Xml: IXMLDocument);
    procedure SetXMLNovo(const Xml: IXMLDocument);
  end;

procedure TUnificadorXML.SetXMLAnterior(const Xml: IXMLDocument);
begin
  FXMLAnterior := Xml;
end;

procedure TUnificadorXML.SetXMLNovo(const Xml: IXMLDocument);
begin
  FXMLNovo := Xml;
end;

procedure TUnificadorXML.PegarXMLMesclado(const AXMLDocument: IXMLDocument);
var
  _havillan: IXMLHavillanType;
begin
  _havillan := Gethavillan(AXMLDocument);
  Mesclar(_havillan);
end;

procedure TUnificadorXML.Mesclar(const AXMLUnificado: IXMLHavillanType);
begin
  CopiarXMLAnterior(AXMLUnificado);
  CopiarXMLNovo(AXMLUnificado);
end;

procedure TUnificadorXML.CopiarXMLAnterior(const AXMLUnificado: IXMLHavillanType);
var
  i: Integer;
  _xmlScript: IXMLScriptType;
  _xmlNovoScript: IXMLScriptType;
  _xmlHavillanNovo: IXMLHavillanType;
begin
  _xmlHavillanNovo := Gethavillan(FXMLAnterior);
  for i := 0 to Pred(_xmlHavillanNovo.Count) do
  begin
    _xmlScript := _xmlHavillanNovo.Script[i];
    _xmlNovoScript := AXMLUnificado.Add;
    CopiarScript(_xmlNovoScript, _xmlScript);
  end;
end;

procedure TUnificadorXML.CopiarXMLNovo(const AXMLUnificado: IXMLHavillanType);
var
  i: Integer;
  _xmlScript: IXMLScriptType;
  _xmlNovoScript: IXMLScriptType;
  _xmlHavillanNovo: IXMLHavillanType;
begin
  _xmlHavillanNovo := Gethavillan(FXMLNovo);
  for i := 0 to Pred(_xmlHavillanNovo.Count) do
  begin
    _xmlScript := _xmlHavillanNovo.Script[i];
    _xmlNovoScript := AXMLUnificado.Add;
    CopiarScript(_xmlNovoScript, _xmlScript);
  end;
end;

procedure TUnificadorXML.CopiarScript(_xmlNovoScript, _xmlScript: IXMLScriptType);
begin
  Validador.Data.dbChangeXML.AtribuirNome(_xmlNovoScript, _xmlScript.Text, _xmlScript.A_name);
  if not _xmlScript.Version.Trim.IsEmpty then
    _xmlNovoScript.Version := _xmlScript.Version;
  if _xmlScript.X_has_pos.Trim.IsEmpty then
    _xmlNovoScript.X_has_pos := _xmlScript.X_has_pos;
  if not _xmlScript.Description.Trim.IsEmpty then
    _xmlNovoScript.Description := _xmlScript.Description;
  if not _xmlScript.Z_description.Trim.IsEmpty then
    _xmlNovoScript.Z_description := _xmlScript.Z_description;
  if not _xmlScript.Text.Trim.IsEmpty then
    _xmlNovoScript.Text := _xmlScript.Text;
end;

initialization

ContainerDI.RegisterType<TUnificadorXML>.Implements<IUnificadorXML>('UnificadorXML');
ContainerDI.Build;

end.
