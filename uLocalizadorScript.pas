unit uLocalizadorScript;

interface

uses
  Data.DB;

type
  ILocalizadorDeScript = Interface(IInterface)
    procedure Localizar(const DiretorioInicio: string);
  end;

  TLocalizadorDeScript = class(TInterfacedObject, ILocalizadorDeScript)
  private
    FDataSet: TDataSet;
    procedure AdicionarArquivosDoDiretorio(const DiretorioInicio: string);
  public
    class function New(const ADataSet: TDataSet): ILocalizadorDeScript;
    constructor Create(const ADataSet: TDataSet);
    procedure Localizar(const DiretorioInicio: string);
  end;

implementation

uses
  System.IOUtils, System.Classes, System.SysUtils, System.Types, System.Threading;

class function TLocalizadorDeScript.New(const ADataSet: TDataSet): ILocalizadorDeScript;
begin
  result := Create(ADataSet);
end;

constructor TLocalizadorDeScript.Create(const ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

procedure TLocalizadorDeScript.Localizar(const DiretorioInicio: string);
var
  _diretorios: TStringDynArray;
  AIndex: Integer;
begin
  _diretorios := TDirectory.GetDirectories(DiretorioInicio);

  for AIndex := Low(_diretorios) to High(_diretorios) do
  begin
    TLocalizadorDeScript.New(FDataSet).Localizar(_diretorios[AIndex]);
  end;

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

end.
