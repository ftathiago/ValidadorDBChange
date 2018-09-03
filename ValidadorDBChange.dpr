program ValidadorDBChange;

uses
  Vcl.Forms,
  dbChange in 'dbChange.pas',
  frmDBChange in 'frmDBChange.pas' {frmValidadorDBChange},
  uLocalizadorScript in 'uLocalizadorScript.pas',
  uAnalizadorScript in 'uAnalizadorScript.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmValidadorDBChange, frmValidadorDBChange);
  Application.Run;
end.
