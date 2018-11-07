{ ***************************************************** }
{ }
{ XML Data Binding }
{ }
{ Generated on: 22/08/2018 14:27:56 }
{ Generated from: Q:\dbscript\PG\dbChange.xml }
{ Settings stored in: Q:\dbscript\PG\dbChange.xdb }
{ }
{ ***************************************************** }

unit Validador.Data.dbChangeXML;

interface

uses
  Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

  { Forward Decls }

  IXMLHavillanType = interface;
  IXMLScriptType = interface;

  { IXMLHavillanType }

  IXMLHavillanType = interface(IXMLNodeCollection)
    ['{33100F16-3FD3-4EAD-AE85-8AC002FC2122}']
    { Property Accessors }
    function Get_Script(Index: Integer): IXMLScriptType;
    { Methods & Properties }
    function Add: IXMLScriptType;
    function Insert(const Index: Integer): IXMLScriptType;
    property Script[Index: Integer]: IXMLScriptType read Get_Script; default;
  end;

  { IXMLScriptType }

  IXMLScriptType = interface(IXMLNode)
    ['{6C569648-F9BA-409D-ACDB-A329F0269F09}']
    { Property Accessors }
    function Get_A_name: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Z_description: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_X_has_pos: UnicodeString;
    procedure Set_A_name(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Z_description(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_X_has_pos(Value: UnicodeString);
    { Methods & Properties }
    property A_name: UnicodeString read Get_A_name write Set_A_name;
    property Version: UnicodeString read Get_Version write Set_Version;
    property Z_description: UnicodeString read Get_Z_description write Set_Z_description;
    property Description: UnicodeString read Get_Description write Set_Description;
    property X_has_pos: UnicodeString read Get_X_has_pos write Set_X_has_pos;
  end;

  { Forward Decls }

  TXMLHavillanType = class;
  TXMLScriptType = class;

  { TXMLHavillanType }

  TXMLHavillanType = class(TXMLNodeCollection, IXMLHavillanType)
  protected
    { IXMLHavillanType }
    function Get_Script(Index: Integer): IXMLScriptType;
    function Add: IXMLScriptType;
    function Insert(const Index: Integer): IXMLScriptType;
  public
    procedure AfterConstruction; override;
  end;

  { TXMLScriptType }

  TXMLScriptType = class(TXMLNode, IXMLScriptType)
  protected
    { IXMLScriptType }
    function Get_A_name: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Z_description: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_X_has_pos: UnicodeString;
    procedure Set_A_name(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Z_description(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_X_has_pos(Value: UnicodeString);
  end;

  { Global Functions }

function Gethavillan(Doc: IXMLDocument): IXMLHavillanType;
function Loadhavillan(const FileName: string): IXMLHavillanType;
function Newhavillan: IXMLHavillanType;
procedure AtribuirNome(const AXMLScriptType: IXMLScriptType; const AValue, ANome: string);

const
  TargetNamespace = '';

implementation

uses
  System.SysUtils, Xml.xmlutil;

{ Global Functions }

function Gethavillan(Doc: IXMLDocument): IXMLHavillanType;
begin
  Result := Doc.GetDocBinding('havillan', TXMLHavillanType, TargetNamespace) as IXMLHavillanType;
end;

function Loadhavillan(const FileName: string): IXMLHavillanType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('havillan', TXMLHavillanType, TargetNamespace)
    as IXMLHavillanType;
end;

function Newhavillan: IXMLHavillanType;
begin
  Result := NewXMLDocument.GetDocBinding('havillan', TXMLHavillanType, TargetNamespace)
    as IXMLHavillanType;
end;

procedure AtribuirNome(const AXMLScriptType: IXMLScriptType; const AValue, ANome: string);
begin
  if Not AValue.Trim.IsEmpty then
    Exit;
  if not ANome.Trim.IsEmpty then
    AXMLScriptType.A_name := ANome;
end;

{ TXMLHavillanType }

procedure TXMLHavillanType.AfterConstruction;
begin
  RegisterChildNode('script', TXMLScriptType);
  ItemTag := 'script';
  ItemInterface := IXMLScriptType;
  inherited;
end;

function TXMLHavillanType.Get_Script(Index: Integer): IXMLScriptType;
begin
  Result := List[Index] as IXMLScriptType;
end;

function TXMLHavillanType.Add: IXMLScriptType;
begin
  Result := AddItem(-1) as IXMLScriptType;
end;

function TXMLHavillanType.Insert(const Index: Integer): IXMLScriptType;
begin
  Result := AddItem(Index) as IXMLScriptType;
end;

{ TXMLScriptType }

function TXMLScriptType.Get_A_name: UnicodeString;
begin
  Result := AttributeNodes['a_name'].Text;
end;

procedure TXMLScriptType.Set_A_name(Value: UnicodeString);
begin
  SetAttribute('a_name', Value);
end;

function TXMLScriptType.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLScriptType.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLScriptType.Get_Z_description: UnicodeString;
begin
  Result := AttributeNodes['z_description'].Text;
end;

procedure TXMLScriptType.Set_Z_description(Value: UnicodeString);
begin
  SetAttribute('z_description', Value);
end;

function TXMLScriptType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['description'].Text;
end;

procedure TXMLScriptType.Set_Description(Value: UnicodeString);
begin
  SetAttribute('description', Value);
end;

function TXMLScriptType.Get_X_has_pos: UnicodeString;
begin
  Result := AttributeNodes['x_has_pos'].Text;
end;

procedure TXMLScriptType.Set_X_has_pos(Value: UnicodeString);
begin
  SetAttribute('x_has_pos', Value);
end;

end.
