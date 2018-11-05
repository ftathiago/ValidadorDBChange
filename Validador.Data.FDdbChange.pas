unit Validador.Data.FDdbChange;

interface

uses
  Data.DB, FireDac.Comp.Client;

type
  TFDDbChange = class(TFDMemTable)
  private
    FTemPos: TField;
    FVersao: TField;
    FDescricao: TField;
    FExisteNaPasta: TField;
    FValue: TField;
    FZDescricao: TField;
    FOrdemOriginal: TField;
    FImportar: TField;
    FNome: TField;
    FRepetido: TField;
    procedure CarregarCampos;
    procedure CriarCampos;
  protected
    procedure DoAfterOpen; override;
    procedure DoMarcarRepetidos(const ANome: string);
    procedure DoOnNewRecord; override;
  public
    procedure MarcarRepetidos;
    procedure CreateDataSet; override;
    property OrdemOriginal: TField read FOrdemOriginal;
    property Repetido: TField read FRepetido;
    property Importar: TField read FImportar;
    property ExisteNaPasta: TField read FExisteNaPasta;
    property Nome: TField read FNome;
    property Versao: TField read FVersao;
    property ZDescricao: TField read FZDescricao;
    property Descricao: TField read FDescricao;
    property TemPos: TField read FTemPos;
    property Value: TField read FValue;
  end;

implementation

uses
  System.SysUtils;

procedure TFDDbChange.CreateDataSet;
begin
  CriarCampos;
  inherited;
end;

procedure TFDDbChange.CriarCampos;
begin
  FieldDefs.Clear;
  FieldDefs.Add('OrdemOriginal', ftInteger);
  FieldDefs.Add('Repetido', ftBoolean);
  FieldDefs.Add('Importar', ftBoolean);
  FieldDefs.Add('ExisteNaPasta', ftBoolean);
  FieldDefs.Add('Nome', ftString, 50);
  FieldDefs.Add('Versao', ftString, 30);
  FieldDefs.Add('ZDescricao', ftString, 250);
  FieldDefs.Add('Descricao', ftString, 250);
  FieldDefs.Add('TemPos', ftBoolean);
  FieldDefs.Add('Value', ftString, 50);
end;

procedure TFDDbChange.DoAfterOpen;
begin
  CarregarCampos;
  inherited;
end;

procedure TFDDbChange.CarregarCampos;
begin
  FOrdemOriginal := FindField('OrdemOriginal');
  FRepetido := FindField('Repetido');
  FImportar := FindField('Importar');
  FExisteNaPasta := FindField('ExisteNaPasta');
  FNome := FindField('Nome');
  FVersao := FindField('Versao');
  FZDescricao := FindField('ZDescricao');
  FDescricao := FindField('Descricao');
  FTemPos := FindField('TemPos');
  FValue := FindField('Value');
end;

procedure TFDDbChange.DoMarcarRepetidos(const ANome: string);
var
  _registroRepetido: boolean;
begin
  Next;
  if Eof then
    Exit;
  _registroRepetido :=  Nome.AsString.Equals(ANome) or Value.AsString.Equals(ANome);
  Edit;
  Repetido.AsBoolean := _registroRepetido;
  Importar.AsBoolean := not _registroRepetido;
  Post;
  if Repetido.AsBoolean then
  begin
    Prior;
    Edit;
    Repetido.AsBoolean := Nome.AsString.Equals(ANome);
    Post;
    Next;
  end;
  DoMarcarRepetidos(Nome.AsString);
end;

procedure TFDDbChange.DoOnNewRecord;
begin
  Repetido.AsBoolean := False;
  Importar.AsBoolean := True;
  ExisteNaPasta.AsBoolean := True;
  inherited;
end;

procedure TFDDbChange.MarcarRepetidos;
var
  _indexFieldNames: string;
begin
  _indexFieldNames := IndexFieldNames;
  DisableControls;
  try
    IndexFieldNames := 'Nome';
    First;
    DoMarcarRepetidos(Nome.AsString);
  finally
    IndexFieldNames := _indexFieldNames;
    EnableControls;
  end;
end;

end.
