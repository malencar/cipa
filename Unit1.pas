unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UbANCO, ExtCtrls, Grids, DBGrids, StdCtrls, DBCtrls, DBSearchEdit,
  jpeg,IniFiles, XPMan, Buttons, Data.DB,UrELvOTACAO;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    pnEleicao: TPanel;
    Panel1: TPanel;
    vb: TDBText;
    vn: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    XPManifest1: TXPManifest;
    Label5: TLabel;
    dbtotal: TDBText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    LbTot: TLabel;
    dbTot: TDBText;
    procedure DBSearchEdit1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure GravaIni(Arquivo, Sessao, Subsessao, valor: string);
var
ArqIni: TIniFile;
sDirAplicacao: string;
begin
sDirAplicacao := 'C:\SINDICO\';
ArqIni := TIniFile.Create(sDirAplicacao + Arquivo);
try
ArqIni.WriteString(Sessao, Subsessao, valor);
finally
FreeAndNil(ArqIni);
end;
end;


function LerIni(Arquivo, Sessao, Subsessao: string): string;
var
ArqIni: TIniFile;
sDirAplicacao: string;
begin
sDirAplicacao := 'C:\SINDICO\';
ArqIni := TIniFile.Create(sDirAplicacao + Arquivo);
try
Result := ArqIni.ReadString(Sessao, Subsessao,'' );
finally
FreeAndNil(ArqIni);
end;
end;

procedure ConectaFireBird(Path: String);
begin
      with dmbanco do begin
       try
          FDConnection1.Connected := False;
          FDConnection1.Params.Database := path + ':c:\sindico\cipa.fdb';
          FDConnection1.Connected := True;
       except
         //ibBanco.Connected := False;
         ShowMessage('Erro ao conectar no banco de dados. Verifique se este computador e o servidor est�o em Rede ! '+
         'OU CLIQUE NO LOGOTIPO PARA INFORMAR O CAMINHO DO BANCO DE DADOS. ');
         
       end;
      end;
end;

procedure TForm1.DBSearchEdit1Click(Sender: TObject);
begin
 //DBSearchEdit1.Clear;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
dbgrid1.DataSource := dmbanco.dsReport;
 with dmbanco do begin
  try
   //ibBanco.connected := true;
   FDqryReport.Close;
   FDqryReport.Open;
   FDqryBrancos.Close;
   FDqryBrancos.Open;
   FDqryNulos.Close;
   FDqryNulos.Open;
   FDqryTotal.Close;
   FDqryTotal.Open;
   VotosValidos.Close;
   VotosValidos.Open;
  except
    on e:Exception do ShowMessage('Ocorreu um erro ao inicializar os datasets do banco de dados.');
  end;
 end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 {qrResultado.Prepare;
 qrResultado.qrlPagina.Caption := ' de '+IntToStr(QrResultado.QRPrinter.PageCount);
 qrResultado.Preview;}
 frmRelVotacao.RLReport1.Preview();
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

end.
