unit uVotacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ColorButton, ubanco,db,uFIM,MMSystem,
  Vcl.Buttons;

type
  TFrmVotacao = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    imFoto: TImage;
    Label3: TLabel;
    Label4: TLabel;
    edNumero: TEdit;
    edNome: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    Label9: TLabel;
    Label10: TLabel;
    lbErro: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    procedure btnCorrigeClick(Sender: TObject);
    procedure edNumeroChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnBrancoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Panel7Click(Sender: TObject);
    procedure Panel8Click(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure Panel11Click(Sender: TObject);
    procedure Panel13Click(Sender: TObject);
    procedure Panel12Click(Sender: TObject);
    procedure Panel10Click(Sender: TObject);
  private
    function insertBanco: boolean;
    procedure LoadPhoto;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVotacao: TFrmVotacao;
  tipo : string;
implementation

{$R *.dfm}

Procedure TFrmVotacao.LoadPhoto;
var Stream :TStream;
 jpeg : TJPEGImage;
begin
  jpeg := TJPEGImage.Create;
  if not (dmbanco.FDTransaction4.cONNECTION.InTransaction) then
            dmbanco.FDTransaction4.StartTransaction;

  with dmbanco.FDQuery9 do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT NUMERO,NOME,FOTO FROM CIPEIRO WHERE NUMERO = :NUMERO');
      ParamByName('NUMERO').AsString := edNumero.Text;
      Open;
      Stream := CreateBlobStream(FieldByName('FOTO'), bmRead);
      ednome.Text :=  FieldByName('NOME').AsString;
    end;
   if edNome.Text = '' then begin
    lbErro.Visible:= true;
    //imFoto.Picture := nil;
    jpeg.LoadFromFile('c:\sindico\fotocipa.jpg');
    imFoto.Picture.Assign(jpeg);
    stream.Free;
    jpeg.Free;
    exit;
   end;
   lberro.Caption := 'CANDIDATO N�O EXISTE !!!';
   lbErro.Visible := false;
   jpeg.LoadFromStream(Stream);
   //imFoto.Picture.Graphic.LoadFromStream(Stream);
   imFoto.Picture.Assign(jpeg);
   stream.Free;
   jpeg.Free;
end;

procedure TFrmVotacao.Panel10Click(Sender: TObject);
begin
tipo := 'BRANCO';
 edNumero.Clear;
 edNumero.Text := 'BRANCO';
 edNome.Clear;
 edNome.Text := 'VOTO EM BRANCO';
 lbErro.Caption := 'VOTO EM BRANCO ! CLIQUE NO BOT�O CONFIRMA';
 lbErro.Visible := true;
end;

procedure TFrmVotacao.Panel11Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
    edNumero.Text := edNumero.Text + '0';
end;

procedure TFrmVotacao.Panel12Click(Sender: TObject);
var JPEG: TJpegimage;
begin
 jpeg := TJPEGImage.Create;
 lbErro.caption := 'CANDIDATO N�O EXISTE';
 lbErro.Visible := false;
 edNumero.Clear;
 edNome.Clear;
 try
  jpeg.LoadFromFile('c:\sindico\fotocipa.jpg');
  imFoto.Picture.Assign(jpeg);
   jpeg.Free;
 except
 end;
 tipo := '';
 edNumero.SetFocus;

end;

procedure TFrmVotacao.Panel13Click(Sender: TObject);
begin
 if (edNumero.Text = '') and (edNome.Text = '')  then begin
    lberro.Caption := 'DIGITE O N�MERO DO CANDIDATO';
    lberro.Visible := true;
 end
 else begin
   if (tipo = '') then begin
     if (edNumero.Text <> '') and (edNome.Text = '')  then begin
      lberro.Caption := 'CANDIDATO N�O EXISTE';
      lberro.Visible := true;
      exit;
     end;
     insertBanco;
     //sndPlaySound('c:\sindico\urna.wav', SND_ASYNC);
     //Panel13Click(Self);
     frmFIM.Align := alnone;
     frmFIM.Visible := true;
     frmFIM.BringToFront;
     Timer1.Enabled := true;

   end
   else begin
    insertBanco;
    //sndPlaySound('c:\sindico\urna.wav', SND_ASYNC);
    //Panel12Click(Self);
    //frmFIM.Align := alClient;
    frmFIM.Visible := true;
    frmFIM.BringToFront;
    Timer1.Enabled := true;

   end;
 end;
 edNumero.Clear;
 edNome.Clear;
 lbErro.Caption:= '';
end;

procedure TFrmVotacao.Panel1Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '1';
end;

procedure TFrmVotacao.Panel2Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '2';
end;

procedure TFrmVotacao.Panel3Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '3';
end;

procedure TFrmVotacao.Panel4Click(Sender: TObject);
begin
   if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
   edNumero.Text := edNumero.Text + '4';
end;

procedure TFrmVotacao.Panel5Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '5';
end;

procedure TFrmVotacao.Panel6Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '6';
end;

procedure TFrmVotacao.Panel7Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '7';
end;

procedure TFrmVotacao.Panel8Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '8';
end;

procedure TFrmVotacao.Panel9Click(Sender: TObject);
begin
 if (edNumero.Text = 'BRANCO') or (edNumero.Text = '00') then begin
    edNumero.Clear;
    edNome.Clear;
 end;
 edNumero.Text := edNumero.Text + '9';
end;

function Tfrmvotacao.insertBanco: boolean;
begin

if not (dmbanco.FDTransaction1.Connection.InTransaction) then
            dmbanco.FDTransaction1.StartTransaction;

  with dmbanco.FDQueryVotacao do
    begin
      close;
      sql.Clear;
      sql.Add('INSERT INTO VOTACAO VALUES(:NUMERO,:NOME,:VOTO)');
      ParamByName('NUMERO').AsString := edNumero.Text;
      ParamByName('nome').AsString := edNOME.Text;
      ParamByName('VOTO').AsInteger := StrToInt('1');

      if tipo = 'BRANCO' then begin
        ParamByName('NUMERO').AsString := 'BRANCO';
        ParamByName('nome').AsString := 'BRANCO';
        ParamByName('VOTO').AsInteger := StrToInt('1');
      end;

      if tipo = 'NULO' then begin
        ParamByName('NUMERO').AsString := 'NULO';
        ParamByName('nome').AsString := 'NULO';
        ParamByName('VOTO').AsInteger := StrToInt('1');
      end;
     try
      ExecSql;
      dmbanco.FDTransaction1.Commit;
      sndPlaySound('c:\sindico\urna.wav', SND_ASYNC);
     except on e:exception do ShowMessage('FALHA NA REDE');
     end;
    end;
    tipo:= '';
end;

procedure TFrmVotacao.btnCorrigeClick(Sender: TObject);
var JPEG: TJpegimage;
begin
 jpeg := TJPEGImage.Create;
 lbErro.caption := 'CANDIDATO N�O EXISTE';
 lbErro.Visible := false;
 edNumero.Clear;
 edNome.Clear;
 try
  jpeg.LoadFromFile('c:\sindico\fotocipa.jpg');
  imFoto.Picture.Assign(jpeg);
   jpeg.Free;
 except
 end;
 tipo := '';
 edNumero.SetFocus;

end;

procedure TFrmVotacao.edNumeroChange(Sender: TObject);
begin
 if (edNumero.Text = '') then exit;
 if (edNumero.Text = '00') then begin
    tipo:='NULO';
    lbErro.Caption := 'VOTO NULO ! CLIQUE NO BOT�O CONFIRMA';
    edNome.Text := 'VOTO NULO';
    lbErro.Visible := true;
    exit;
 end
 else begin
  lberro.Caption := 'CANDIDATO N�O EXISTE';
  LoadPhoto;
 end;
end;

procedure TFrmVotacao.btnConfirmaClick(Sender: TObject);
begin
 if (edNumero.Text = '') and (edNome.Text = '')  then begin
    lberro.Caption := 'DIGITE O N�MERO DO CANDIDATO';
    lberro.Visible := true;
 end
 else begin
   if (tipo = '') then begin
     if (edNumero.Text <> '') and (edNome.Text = '')  then begin
      lberro.Caption := 'CANDIDATO N�O EXISTE';
      lberro.Visible := true;
      exit;
     end;
     insertBanco;
     //sndPlaySound('c:\sindico\urna.wav', SND_ASYNC);
     btnCorrigeClick(Self);
     frmFIM.Align := alnone;
     frmFIM.Visible := true;
     frmFIM.BringToFront;
     Timer1.Enabled := true;

   end
   else begin
    insertBanco;
    //sndPlaySound('c:\sindico\urna.wav', SND_ASYNC);
    btnCorrigeClick(Self);
    //frmFIM.Align := alClient;
    frmFIM.Visible := true;
    frmFIM.BringToFront;
    Timer1.Enabled := true;

   end;
 end;
 
end;

procedure TFrmVotacao.btnBrancoClick(Sender: TObject);
begin
 tipo := 'BRANCO';
 edNumero.Text := 'BRANCO';
 edNome.Text := 'VOTO EM BRANCO';
 lbErro.Caption := 'VOTO EM BRANCO ! CLIQUE NO BOT�O CONFIRMA';
 lbErro.Visible := true;
end;

procedure TFrmVotacao.FormShow(Sender: TObject);
begin
 edNumero.SetFocus;
 Panel12.Color := RGB(255,69,0);
end;

procedure TFrmVotacao.Timer1Timer(Sender: TObject);
begin
 FrmFIM.Visible := false;
 Timer1.Enabled := false;
end;

end.
