program ValidadorDBChange;

uses
  Vcl.Forms,
  dbChange in 'dbChange.pas',
  frmDBChange in 'frmDBChange.pas' {frmValidadorDBChange};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmValidadorDBChange, frmValidadorDBChange);
  Application.Run;
end.
