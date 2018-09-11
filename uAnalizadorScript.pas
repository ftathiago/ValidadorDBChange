unit uAnalizadorScript;

interface

uses
  Data.DB, FireDAC.Comp.Client;

type
  IAnalisadorScript = interface(IInterface)
    ['{2BA5DC51-9989-4DFC-9AEA-A0074BCFBC8C}']
    procedure Analisar;
  end;

  TAnalisadorScript = class(TInterfacedObject, IAnalisadorScript)
  private
    FAnalise: TFDMemTable;
    FDBChange: TFDMemTable;
    FArquivos: TFDMemTable;
    FAnaliseNOME_SCRIPT: TField;
    FDBChangeNome: TField;
    FArquivosNOME_ARQUIVO: TField;
    FAnaliseNOME_ARQUIVO: TField;
    procedure CarregarScriptsNaAnalise;
    procedure CarregarListaDeArquivo;
    procedure SetAnalise(const AAnalise: TFDMemTable);
    procedure SetDBChange(const ADBChange: TFDMemTable);
    procedure SetArquivos(const AArquivos: TFDMemTable);
    procedure CarregarArquivosNaAnalise;
  public
    constructor Create(const AAnalise, ADBChange, AArquivos: TFDMemTable);
    class function New(const AAnalise, ADBChange, AArquivos: TFDMemTable): IAnalisadorScript;
    procedure Analisar;
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs, uLocalizadorScript;

class function TAnalisadorScript.New(const AAnalise, ADBChange, AArquivos: TFDMemTable)
  : IAnalisadorScript;
begin
  result := Create(AAnalise, ADBChange, AArquivos);
end;

constructor TAnalisadorScript.Create(const AAnalise, ADBChange, AArquivos: TFDMemTable);
begin
  SetAnalise(AAnalise);
  SetDBChange(ADBChange);
  SetArquivos(AArquivos);
end;

procedure TAnalisadorScript.SetAnalise(const AAnalise: TFDMemTable);
begin
  if FAnalise = AAnalise then
    exit;
  FAnalise := AAnalise;
  FAnaliseNOME_SCRIPT := FAnalise.FindField('NOME_SCRIPT');
  FAnaliseNOME_ARQUIVO := FAnalise.FindField('NOME_ARQUIVO');
end;

procedure TAnalisadorScript.SetDBChange(const ADBChange: TFDMemTable);
begin
  if FDBChange = ADBChange then
    exit;
  FDBChange := ADBChange;
  FDBChangeNome := FDBChange.FindField('NOME');
end;

procedure TAnalisadorScript.SetArquivos(const AArquivos: TFDMemTable);
begin
  if FArquivos = AArquivos then
    exit;
  FArquivos := AArquivos;
  FArquivosNOME_ARQUIVO := FArquivos.FindField('NOME_ARQUIVO');
end;

procedure TAnalisadorScript.Analisar;
begin
  if FDBChange.IsEmpty then
    exit;

  FAnalise.EmptyDataSet;

  CarregarScriptsNaAnalise;
  CarregarListaDeArquivo;

  CarregarArquivosNaAnalise;
end;

procedure TAnalisadorScript.CarregarScriptsNaAnalise;
begin
  FDBChange.First;
  FAnalise.DisableControls;
  try
    while not FDBChange.Eof do
    begin
      FAnalise.Insert;
      FAnaliseNOME_SCRIPT.AsString := FDBChangeNome.AsString;
      FAnalise.Post;
      FDBChange.Next;
    end;
  finally
    FAnalise.EnableControls;
  end;
end;

procedure TAnalisadorScript.CarregarListaDeArquivo;
begin
  FArquivos.EmptyDataSet;
  with TFileOpenDialog.Create(nil) do
    try
      Title := 'Escolha o diretório raíz do dbChange';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; //YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := EmptyStr;
      FileName := EmptyStr;
      if not Execute then
        Abort;

      TLocalizadorDeScript.New(FArquivos).Localizar(FileName);
    finally
      Free;
    end
end;

procedure TAnalisadorScript.CarregarArquivosNaAnalise;
begin
  FArquivos.First;
  FAnalise.DisableControls;
  try
    while not FArquivos.Eof do
    begin
      if FAnalise.FindKey([FArquivosNOME_ARQUIVO.AsString]) then
        FAnalise.Edit
      else
        FAnalise.Insert;
      FAnaliseNOME_ARQUIVO.AsString := FArquivosNOME_ARQUIVO.AsString;
      FAnalise.Post;
      FArquivos.Next;
    end;
  finally
    FAnalise.EnableControls;
  end;
end;

end.
