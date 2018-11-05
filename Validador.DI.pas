unit Validador.DI;

interface

uses
  Spring.Container;

function ContainerDI: TContainer;

implementation

var
  FContainer: TContainer;

function ContainerDI: TContainer;
begin
  if FContainer = nil then
  begin
    FContainer := TContainer.Create;
  end;
  Result := FContainer;
end;

end.
