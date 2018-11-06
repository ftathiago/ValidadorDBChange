program ValidadorDBChange;

uses
  Vcl.Forms,
  dbChange in 'dbChange.pas',
  frmDBChange in 'frmDBChange.pas' {frmValidadorDBChange},
  Validador.Core.LocalizadorScript in 'Validador.Core.LocalizadorScript.pas',
  Validador.Core.AnalizadorScript in 'Validador.Core.AnalizadorScript.pas',
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
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTelaInicial, TelaInicial);
  Application.Run;

end.
