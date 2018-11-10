program ValidadorDBChange;

uses
  Vcl.Forms,
  Validador.Data.dbChangeXML in 'Validador.Data.dbChangeXML.pas',
  Validador.UI.frmDBChange in 'Validador.UI.frmDBChange.pas' {frmValidadorDBChange},
  Validador.Core.LocalizadorScript in 'Validador.Core.LocalizadorScript.pas',
  Validador.Core.AnalisadorScript in 'Validador.Core.AnalisadorScript.pas',
  Validador.UI.FormBase in 'Validador.UI.FormBase.pas' {FormBase},
  Validador.UI.TelaInicial in 'Validador.UI.TelaInicial.pas' {TelaInicial},
  Validador.UI.MesclarArquivos in 'Validador.UI.MesclarArquivos.pas' {MesclarArquivos},
  Validador.UI.VisualizarXML in 'Validador.UI.VisualizarXML.pas' {VisualizarXML: TFrame},
  Validador.Core.UnificadorXML in 'Validador.Core.UnificadorXML.pas',
  Validador.DI in 'Validador.DI.pas',
  Validador.Core.ConversorXMLDataSet in 'Validador.Core.ConversorXMLDataSet.pas',
  Validador.Data.FDdbChange in 'Validador.Data.FDdbChange.pas',
  Vcl.Themes,
  Vcl.Styles,
  Validador.Core.Impl.LocalizadorScript in 'Validador.Core.Impl.LocalizadorScript.pas',
  Validador.Core.Impl.ConversorXMLDataSet in 'Validador.Core.Impl.ConversorXMLDataSet.pas',
  Validador.Core.Impl.AnalisadorScript in 'Validador.Core.Impl.AnalisadorScript.pas',
  Validador.Core.Impl.UnificadorXML in 'Validador.Core.Impl.UnificadorXML.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TTelaInicial, TelaInicial);
  Application.Run;

end.
