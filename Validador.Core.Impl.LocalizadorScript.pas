unit Validador.Core.Impl.LocalizadorScript;

interface

implementation

uses
  System.IOUtils, System.Classes, System.SysUtils, System.Types, System.Threading, Data.DB,
  Validador.DI, Validador.Core.LocalizadorScript;

type
  TLocalizadorDeScript = class(TInterfacedObject, ILocalizadorDeScript)
  private
    FDataSet: TDataSet;
    procedure AdicionarArquivosDoDiretorio(const DiretorioInicio: string);
  public
    function SetDataSet(const ADataSet: TDataSet): ILocalizadorDeScript;
    destructor Destroy; override;
    procedure Localizar(const DiretorioInicio: string);
  end;

function TLocalizadorDeScript.SetDataSet(const ADataSet: TDataSet): ILocalizadorDeScript;
begin
  FDataSet := ADataSet;
  FDataSet.DisableControls;
end;

destructor TLocalizadorDeScript.Destroy;
begin
  FDataSet.EnableControls;
end;

procedure TLocalizadorDeScript.Localizar(const DiretorioInicio: string);
var
  _diretorios: TStringDynArray;
  AIndex: Integer;
begin
  _diretorios := TDirectory.GetDirectories(DiretorioInicio);

  for AIndex := Low(_diretorios) to High(_diretorios) do
    ContainerDI.Resolve<ILocalizadorDeScript>.SetDataSet(FDataSet).Localizar(_diretorios[AIndex]);

  AdicionarArquivosDoDiretorio(DiretorioInicio);
end;

procedure TLocalizadorDeScript.AdicionarArquivosDoDiretorio(const DiretorioInicio: string);
var
  _arquivos: TStringDynArray;
  AIndex: Integer;
begin
  _arquivos := TDirectory.GetFiles(DiretorioInicio, '*.DH4');

  for AIndex := Low(_arquivos) to High(_arquivos) do
  begin
    FDataSet.Insert;
    FDataSet.FieldByName('PATH').AsString := DiretorioInicio;
    FDataSet.FieldByName('NOME_ARQUIVO').AsString := ExtractFileName(_arquivos[AIndex]);
    FDataSet.Post;
  end;
end;

initialization

ContainerDI.RegisterType<TLocalizadorDeScript>.Implements<ILocalizadorDeScript>;
ContainerDI.Build;

end.
