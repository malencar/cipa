unit uBanco;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBQuery, IBCustomDataSet, IBTable,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
  Datasnap.DBClient;

type
  TdmBanco = class(TDataModule)
    dsCadastro: TDataSource;
    dsetCadastro: TIBDataSet;
    dsetCadastroNUMERO: TIBStringField;
    dsetCadastroNOME: TIBStringField;
    dsetCadastroFOTO: TBlobField;
    dtsFoto: TIBDataSet;
    dsFoto: TDataSource;
    dtsFotoFOTO: TBlobField;
    dsReport: TDataSource;
    dsBrancos: TDataSource;
    IBTransaction7: TIBTransaction;
    dsNulos: TDataSource;
    dsTotal: TDataSource;
    dsetCadastroID: TSmallintField;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    qryCdastro: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery4: TFDQuery;
    FDQuery5: TFDQuery;
    FDQuery6: TFDQuery;
    IBTransaction1: TFDTransaction;
    IBTransaction2: TFDTransaction;
    FDTransaction3: TFDTransaction;
    IBTransaction4: TFDTransaction;
    IBTransaction5: TFDTransaction;
    IBTransaction6: TFDTransaction;
    FDQryTotal: TFDQuery;
    FDQryReport: TFDQuery;
    FDQryBrancos: TFDQuery;
    FDQuery9: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDQuery10: TFDQuery;
    FDTransaction2: TFDTransaction;
    FDTransaction4: TFDTransaction;
    FDQuery11: TFDQuery;
    FDQuery12: TFDQuery;
    FDTransaction5: TFDTransaction;
    FDQuery13: TFDQuery;
    qryCdastroID: TSmallintField;
    qryCdastroNUMERO: TStringField;
    qryCdastroNOME: TStringField;
    qryCdastroFOTO: TBlobField;
    FDQuery14: TFDQuery;
    FDTransaction6: TFDTransaction;
    FDQryNulos: TFDQuery;
    VotosValidos: TFDQuery;
    VotosValidosVOTOS_VALIDOS: TIntegerField;
    dsVotosValidos: TDataSource;
    FDQryLimpar: TFDQuery;
    FDTransaction7: TFDTransaction;
    FDQuery3NUMERO: TStringField;
    FDQuery3NOME: TStringField;
    FDQuery3TOTAL_VOTOS: TIntegerField;
    FDQryTotalTOTAL: TIntegerField;
    FDQueryVotacao: TFDQuery;
    SmallintField1: TSmallintField;
    StringField1: TStringField;
    StringField2: TStringField;
    BlobField1: TBlobField;
    FDQryReportNUMERO: TStringField;
    FDQryReportNOME: TStringField;
    FDQryReportTOTAL_VOTOS: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmBanco: TdmBanco;

implementation

{$R *.dfm}

end.
