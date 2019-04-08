unit uReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,uBanco, jpeg;

type
  TqrResultado = class(TQuickRep)
    QRBand1: TQRBand;
    qrlTitulo: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand4: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    qrlTotBranc: TQRLabel;
    qrlTotaNulo: TQRLabel;
    qrldata: TQRLabel;
    QRImage1: TQRImage;
    QRDBText3: TQRDBText;
    QRLabel5: TQRLabel;
    qrPagina: TQRSysData;
    qrlPagina: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qrlTotal: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
     gZebrado: Boolean;
  public

  end;

var
  qrResultado: TqrResultado;

implementation

uses DB;

{$R *.DFM}

procedure TqrResultado.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin


  with dmBanco. do begin
   Close;
   SQL.Clear;
   SQL.Add('SELECT NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao where NOME = '+QuotedStr('BRANCO')+
            ' GROUP by NOME,VOTO order BY TOTAL_VOTOS  DESC');
   open;
   qrlTotBranc.Caption := FieldByName('TOTAL_VOTOS').AsString;
  end;

  with dmBanco.qryNulos do begin
   Close;
   SQL.Clear;
   SQL.Add('SELECT NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao where NOME = '+QuotedStr('NULO')+
            ' GROUP by NOME,VOTO order BY TOTAL_VOTOS  DESC');
   open;
   qrlTotaNulo.Caption := FieldByName('TOTAL_VOTOS').AsString;
  end;

  with dmBanco.qryTotal do begin
   Close;
   open;
   qrlTotal.Caption := FieldByName('TOTAL').AsString;
  end;


end;

procedure TqrResultado.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   if ( gZebrado ) then
    Sender.Color:= $00EEEEEE
   else
    Sender.Color:= $00FFFFFF;
   gZebrado:= not gZebrado;
end;

procedure TqrResultado.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 qrlData.Caption := FormatDatetime('DD/MM/YYYY',Date);
end;

end.
