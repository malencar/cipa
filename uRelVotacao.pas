unit uRelVotacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport,uBanco, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelVotacao = class(TForm)
    RLReport1: TRLReport;
    dsVotacao: TDataSource;
    FDQuery2: TFDQuery;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLBand2: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLBand4: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText7: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVotacao: TfrmRelVotacao;

implementation

{$R *.dfm}

end.