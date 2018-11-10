unit Validador.Core.Impl.AnalisadorScript;

interface

implementation

uses
  System.SysUtils, Data.DB, Vcl.Dialogs, FireDAC.Comp.Client, Validador.DI,
  Validador.Core.LocalizadorScript, Validador.Core.AnalisadorScript;

type
  TAnalisadorScript = class(TInterfacedObject, IAnalisadorScript)
  private
    FAnalise: TFDMemTable;
    FDBChange: TFDMemTable;
    FArquivos: TFDMemTable;
    FAnaliseNOME_SCRIPT: TField;
    FDBChangeNome: TField;
    FArquivosNOME_ARQUIVO: TField;
    FAnaliseNOME_ARQUIVO: TField;
    FDiretorioPadrao: TFileName;
    procedure CarregarScriptsNaAnalise;
    procedure CarregarListaDeArquivo;
    procedure CarregarArquivosNaAnalise;
  public
    constructor Create(const AAnalise, ADBChange, AArquivos: TFDMemTable);
    class function New(const AAnalise, ADBChange, AArquivos: TFDMemTable): IAnalisadorScript;
    function SetAnalise(const AAnalise: TFDMemTable): IAnalisadorScript;
    function SetDBChange(const ADBChange: TFDMemTable): IAnalisadorScript;
    function SetArquivos(const AArquivos: TFDMemTable): IAnalisadorScript;
    function SetDiretorioPadrao(const ADiretorioPadrao: TFileName): IAnalisadorScript;
    procedure Analisar;
  end;

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

function TAnalisadorScript.SetAnalise(const AAnalise: TFDMemTable): IAnalisadorScript;
begin
  if FAnalise = AAnalise then
    exit;
  FAnalise := AAnalise;
  FAnaliseNOME_SCRIPT := FAnalise.FindField('NOME_SCRIPT');
  FAnaliseNOME_ARQUIVO := FAnalise.FindField('NOME_ARQUIVO');
  Result := Self;
end;

function TAnalisadorScript.SetDBChange(const ADBChange: TFDMemTable): IAnalisadorScript;
begin
  if FDBChange = ADBChange then
    exit;
  FDBChange := ADBChange;
  FDBChangeNome := FDBChange.FindField('NOME');
  Result := Self;
end;

function TAnalisadorScript.SetDiretorioPadrao(const ADiretorioPadrao: TFileName): IAnalisadorScript;
begin
  FDiretorioPadrao := ADiretorioPadrao;
  result := Self;
end;

function TAnalisadorScript.SetArquivos(const AArquivos: TFDMemTable): IAnalisadorScript;
begin
  if FArquivos = AArquivos then
    exit;
  FArquivos := AArquivos;
  FArquivosNOME_ARQUIVO := FArquivos.FindField('NOME_ARQUIVO');
  Result := Self;
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
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDiretorioPadrao;
      FileName := EmptyStr;
      if not Execute then
        Abort;

        ContainerDI.Resolve<ILocalizadorDeScript>.SetDataSet(FArquivos).Localizar(FileName);
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

initialization

ContainerDI.RegisterType<TAnalisadorScript>.Implements<IAnalisadorScript>('IAnalisadorScript');
ContainerDI.Build;

end.
