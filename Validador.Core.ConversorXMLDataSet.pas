unit Validador.Core.ConversorXMLDataSet;

interface

uses
  dbChange, XML.XMLIntf, FireDac.Comp.Client, Validador.Data.FDDbChange;

type
  IConversorXMLDataSet = interface(IInterface)
    ['{D0CE5ECC-B265-48FC-ACAF-0CEA59F5975C}']
    procedure SetXML(const XML: IXMLDocument);
    procedure SetDataSet(const ADataSet: TFDDbChange);
    procedure ConverterParaDataSet;
    procedure ConverterParaXML;
    procedure DataSetParaImportacao;
  end;

implementation

uses
  System.SysUtils, DB, System.Classes, XML.XMLDoc, Validador.DI;

type
  TConversorXMLDataSet = class(TInterfacedObject, IConversorXMLDataSet)
  private
    FXML: IXMLDocument;
    FDataSet: TFDDbChange;
  public
    procedure ConverterParaDataSet;
    procedure ConverterParaXML;
    procedure DataSetParaImportacao;
    procedure SetDataSet(const ADataSet: TFDDbChange);
    procedure SetXML(const XML: IXMLDocument);
  end;

procedure TConversorXMLDataSet.ConverterParaXML;
var
  _script: IXMLScriptType;
  _havillan: IXMLHavillanType;
begin
  FDataSet.DisableControls;
  try
    FDataSet.First;
    _havillan := FXML.GetDocBinding('havillan', TXMLHavillanType, TargetNamespace)
      as IXMLHavillanType;

    while not FDataSet.Eof do
    begin
      _script := _havillan.Add;

      dbChange.AtribuirNome(_script, FDataSet.Value.AsString, FDataSet.Nome.AsString);

      if not FDataSet.Versao.AsString.Trim.IsEmpty then
        _script.Version := FDataSet.Versao.AsString;

      if FDataSet.TemPos.AsBoolean then
        _script.X_has_pos := 'True';

      if not FDataSet.Descricao.AsString.Trim.IsEmpty then
        _script.Description := FDataSet.Descricao.AsString;

      if not FDataSet.ZDescricao.AsString.Trim.IsEmpty then
        _script.Z_description := FDataSet.ZDescricao.AsString;

      if not FDataSet.Value.AsString.Trim.IsEmpty then
        _script.Text := FDataSet.Value.AsString;

      FDataSet.Next;
    end;
  finally
    FDataSet.EnableControls;
  end;
end;

procedure TConversorXMLDataSet.DataSetParaImportacao;
var
  _filtro: string;
  _filtrado: boolean;
  _indexFieldNames: string;
begin
  _filtro := FDataSet.Filter;
  _filtrado := FDataSet.Filtered;
  _indexFieldNames := FDataSet.IndexFieldNames;
  try
    FDataSet.Filter := 'IMPORTAR = True';
    FDataSet.Filtered := True;
    FDataSet.IndexFieldNames := 'OrdemOriginal';
    ConverterParaXML;
  finally
    FDataSet.IndexFieldNames := _indexFieldNames;
    FDataSet.Filtered := _filtrado;
    FDataSet.Filter := _filtro;
  end;
end;

procedure TConversorXMLDataSet.SetDataSet(const ADataSet: TFDDbChange);
begin
  FDataSet := ADataSet;
end;

procedure TConversorXMLDataSet.SetXML(const XML: IXMLDocument);
begin
  FXML := XML;
end;

procedure TConversorXMLDataSet.ConverterParaDataSet;
var
  _havillan: IXMLHavillanType;
  _script: IXMLScriptType;
  i: integer;
begin
  _havillan := GetHavillan(FXML);
  FDataSet.DisableControls;
  try
    for i := 0 to Pred(_havillan.Count) do
    begin
      _script := _havillan.Script[i];
      if _script.A_name.Trim.IsEmpty and _script.Text.Trim.IsEmpty then
        Continue;
      FDataSet.Insert;
      FDataSet.OrdemOriginal.AsInteger := i;
      FDataSet.Versao.AsString := _script.Version;
      FDataSet.Descricao.AsString := _script.Description;
      FDataSet.ZDescricao.AsString := _script.Z_description;
      FDataSet.Nome.AsString := _script.A_name;
      FDataSet.TemPos.AsBoolean := _script.X_has_pos = 'True';

      if not _script.Text.Trim.IsEmpty then
      begin
        FDataSet.Value.AsString := _script.Text;
        FDataSet.Nome.AsString := _script.Text;
      end;
      FDataSet.Post;
    end;
  finally
    FDataSet.First;
    FDataSet.EnableControls;
  end;
end;

initialization

ContainerDI.RegisterType<TConversorXMLDataSet>.Implements<IConversorXMLDataSet>;
ContainerDI.Build;

end.
