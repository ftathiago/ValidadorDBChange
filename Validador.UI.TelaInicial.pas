unit Validador.UI.TelaInicial;

{
  <div>Icons made by <a href="https://www.flaticon.com/authors/stephen-hutchings" title="Stephen Hutchings">Stephen Hutchings</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
  <div>Icons made by <a href="https://www.flaticon.com/authors/popcic" title="Popcic">Popcic</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Validador.UI.FormBase, Vcl.StdCtrls, uCardButton,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TTelaInicial = class(TFormBase)
    Label1: TLabel;
    CardButton1: TCardButton;
    CardButton2: TCardButton;
    LinkLabel1: TLinkLabel;
    procedure CardButton1Click(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
  end;

var
  TelaInicial: TTelaInicial;

implementation

{$R *.dfm}

uses
  Validador.UI.MesclarArquivos, Validador.UI.frmDBChange;

procedure TTelaInicial.CardButton1Click(Sender: TObject);
var
  _unificador: TMesclarArquivos;
begin
  inherited;
  _unificador := TMesclarArquivos.Create(nil);
  try
    _unificador.ShowModal;
  finally
    FreeAndNil(_unificador);
  end;
end;

procedure TTelaInicial.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
var
  _frmDbChange: TfrmValidadorDBChange;
begin
  inherited;
  _frmDbChange := TfrmValidadorDBChange.Create(Nil);
  try
    _frmDbChange.ShowModal;
  finally
    FreeAndNil(_frmDbChange);
  end;
end;

end.
