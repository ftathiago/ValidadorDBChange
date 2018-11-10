unit Validador.Core.UnificadorXML;

interface

uses
  Validador.Data.dbChangeXML, Validador.DI, Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type
  IUnificadorXML = interface(IInterface)
    ['{739AA013-AFEA-422B-BFF1-351B2980B117}']
    procedure SetXMLAnterior(const Xml: IXMLDocument);
    procedure SetXMLNovo(const Xml: IXMLDocument);
    procedure PegarXMLMesclado(const AXMLDocument: IXMLDocument);
  end;

implementation


end.
