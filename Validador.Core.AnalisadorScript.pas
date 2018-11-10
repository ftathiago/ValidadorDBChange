unit Validador.Core.AnalisadorScript;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  IAnalisadorScript = interface(IInterface)
    ['{2BA5DC51-9989-4DFC-9AEA-A0074BCFBC8C}']
    function SetAnalise(const AAnalise: TFDMemTable): IAnalisadorScript;
    function SetDBChange(const ADBChange: TFDMemTable): IAnalisadorScript;
    function SetArquivos(const AArquivos: TFDMemTable): IAnalisadorScript;
    function SetDiretorioPadrao(const ADiretorioPadrao: TFileName): IAnalisadorScript;
    procedure Analisar;
  end;

implementation


end.
