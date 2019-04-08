unit uPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles;

type
  TFrmPath = class(TForm)
    edPath: TEdit;
    Label1: TLabel;
    btnOK: TButton;
    Button1: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edPathKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPath: TFrmPath;

implementation

uses uBanco, uPrincipal;

{$R *.dfm}

procedure GravaIni(Arquivo, Sessao, Subsessao, valor: string);
var
ArqIni: TIniFile;
sDirAplicacao: string;
begin
sDirAplicacao := 'C:\Sindico\';
ArqIni := TIniFile.Create(sDirAplicacao + Arquivo);
try
ArqIni.WriteString(Sessao, Subsessao, valor);
finally
FreeAndNil(ArqIni);
end;
end;

Function ConectaFireBird(Path: String):boolean;
begin
      with dmbanco do begin
       try
          FDConnection1.Connected := False;
          FDConnection1.Params.Database := Path;
          FDConnection1.Connected := True;
          Result := true;
       except
         result := False;
         ShowMessage('N�o � poss�vel comunica��o com o Banco de Dados'+#13+
         'Digite um (IP) v�lido para o banco de dados.');
         //Application.Terminate;
       end;
       
      end;
end;

procedure TFrmPath.btnOKClick(Sender: TObject);
begin
 if edPath.Text <> '' then begin
  if ConectaFireBird(edPath.Text + ':c:\sindico\cipa.fdb')then
    GravaIni('configuracao.ini','CONFIGURACAO','DATABASE',edPath.Text);

  Close;
 end 
 else
  ShowMessage('DIGITE UM ENDERE�O IP V�LIDO');
 end;

procedure TFrmPath.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmPath.edPathKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then btnOKClick(self);
end;

end.
