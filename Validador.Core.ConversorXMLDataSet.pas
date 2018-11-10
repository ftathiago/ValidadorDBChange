unit Validador.Core.ConversorXMLDataSet;

interface

uses
  Validador.Data.dbChangeXML, FireDac.Comp.Client, Validador.Data.FDDbChange, Xml.xmldom,
  Xml.XMLDoc, Xml.XMLIntf;

type
  IConversorXMLDataSet = interface(IInterface)
    ['{D0CE5ECC-B265-48FC-ACAF-0CEA59F5975C}']
    procedure SetXML(const Xml: IXMLDocument);
    procedure SetDataSet(const ADataSet: TFDDbChange);
    procedure ConverterParaDataSet;
    procedure ConverterParaXML;
    procedure DataSetParaImportacao;
  end;

implementation


end.
