program cipa;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uImport in 'uImport.pas' {frmImport},
  uBanco in 'uBanco.pas' {dmBanco: TDataModule},
  uCadastro in 'uCadastro.pas' {FrmCadastro},
  uVotacao in 'uVotacao.pas' {FrmVotacao},
  uFIM in 'uFIM.pas' {frmFIM},
  uManut in 'uManut.pas' {FrmManut},
  Unit1 in 'Unit1.pas' {Form1},
  uPath in 'uPath.pas' {FrmPath},
  uRelVotacao in 'uRelVotacao.pas' {frmRelVotacao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmImport, frmImport);
  Application.CreateForm(TdmBanco, dmBanco);
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  Application.CreateForm(TFrmVotacao, FrmVotacao);
  Application.CreateForm(TfrmFIM, frmFIM);
  Application.CreateForm(TFrmManut, FrmManut);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmPath, FrmPath);
  Application.CreateForm(TfrmRelVotacao, frmRelVotacao);
  Application.Run;
end.
