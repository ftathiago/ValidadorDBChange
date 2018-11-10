unit Validador.Core.LocalizadorScript;

interface

uses
  Data.DB;

type
  ILocalizadorDeScript = Interface(IInterface)
    ['{11A5B89F-E97E-4501-8F49-E6B07886921E}']
    function SetDataSet(const ADataSet: TDataSet): ILocalizadorDeScript;
    procedure Localizar(const DiretorioInicio: string);
  end;

implementation



end.
