unit Validador.UI.FormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormBase = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetDiretorioBase: string;
  protected
    function PodeFecharForm: Boolean; virtual;
    procedure ESCPressionado(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    property DiretorioBase: string read GetDiretorioBase;
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.ESCPressionado(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Close;
end;

procedure TFormBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := PodeFecharForm;
end;

procedure TFormBase.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ESCPressionado(Sender, Key, Shift);
end;

function TFormBase.GetDiretorioBase: string;
const
  PARAMETRO_PATH_EXECUTAVEL = 0;
  PARAMETRO_DIRETORIO_BASE = 1;
begin
  Result := ParamStr(1);
  if Result.Trim.IsEmpty then
    Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
end;

function TFormBase.PodeFecharForm: Boolean;
begin
  Result := True;
end;

end.
