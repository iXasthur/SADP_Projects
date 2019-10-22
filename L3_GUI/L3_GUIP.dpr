program L3_GUIP;

uses
  Vcl.Forms,
  L3_GUI in 'L3_GUI.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
