program ValidadorDBChange;

uses
  Vcl.Forms,
  FireDac.Stan.StorageXML,
  dbChange in 'dbChange.pas',
  frmDBChange in 'frmDBChange.pas' {frmValidadorDBChange},
  uLocalizadorScript in 'uLocalizadorScript.pas',
  uAnalizadorScript in 'uAnalizadorScript.pas',
  Validador.UI.FormBase in 'Validador.UI.FormBase.pas' {FormBase},
  Validador.UI.TelaInicial in 'Validador.UI.TelaInicial.pas' {TelaInicial},
  Validador.UI.MesclarArquivos in 'Validador.UI.MesclarArquivos.pas' {MesclarArquivos},
  Validador.UI.VisualizarXML in 'Validador.UI.VisualizarXML.pas' {VisualizarXML: TFrame},
  Validador.Core.UnificadorXML in 'Validador.Core.UnificadorXML.pas',
  Validador.DI in 'Validador.DI.pas',
  Validador.Core.ConversorXMLDataSet in 'Validador.Core.ConversorXMLDataSet.pas',
  Validador.Data.FDdbChange in 'Validador.Data.FDdbChange.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTelaInicial, TelaInicial);
  Application.Run;
end.
