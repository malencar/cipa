unit uImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons,ComObj,uBanco, ExtCtrls;

type
  TfrmImport = class(TForm)
    Label1: TLabel;
    sgFunc: TStringGrid;
    Label2: TLabel;
    edPath: TEdit;
    btnEscolher: TBitBtn;
    opDlg: TOpenDialog;
    Button1: TButton;
    pngrid: TPanel;
    btnLimpar: TButton;
    lbRec: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnEscolherClick(Sender: TObject);
    procedure sgFuncDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    function insertBanco : boolean;
    function LoadGrid: boolean;
    
    

    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmImport: TfrmImport;

implementation

{$R *.dfm}

function Xls_To_StringGrid(AGrid: TStringGrid; AXLSFile: string): Boolean;
const
  xlCellTypeLastCell = $0000000B;
var
  XLApp, Sheet: OLEVariant;
  RangeMatrix: Variant;
  x, y, k, r: Integer;
begin
  Result := False;
  // Create Excel-OLE Object
  XLApp := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    XLApp.Visible := False;

    // Open the Workbook
    XLApp.Workbooks.Open(AXLSFile);

    // Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet := XLApp.Workbooks[ExtractFileName(AXLSFile)].WorkSheets[1];

    // In order to know the dimension of the WorkSheet, i.e the number of rows
    // and the number of columns, we activate the last non-empty cell of it

    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Get the value of the last row
    x := XLApp.ActiveCell.Row;
    // Get the value of the last column
    y := XLApp.ActiveCell.Column;

    // Set Stringgrid's row &col dimensions.

    AGrid.RowCount := x;
    AGrid.ColCount := y;

    // Assign the Variant associated with the WorkSheet to the Delphi Variant

    RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
    //  Define the loop for filling in the TStringGrid
    k := 1;
    repeat
      for r := 1 to y do
        AGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[K, R];
      Inc(k, 1);
      AGrid.RowCount := k + 1;
    until k > x;
    // Unassign the Delphi Variant Matrix
    RangeMatrix := Unassigned;

  finally
    // Quit Excel
    if not VarIsEmpty(XLApp) then
    begin
      // XLApp.DisplayAlerts := False;
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      Result := True;
    end;
  end;
end;

procedure TfrmImport.FormCreate(Sender: TObject);
begin

 sgFunc.cells[0,0]:='RE';
 sgFunc.cells[1,0]:='NOME';
 sgFunc.cells[2,0]:='CARGO';
 sgFunc.cells[3,0]:='SUBGRUPO';
 sgFunc.cells[4,0]:='GRUPO';
 sgFunc.cells[5,0]:='SEXO';
 sgFunc.cells[6,0]:='CCUSTO';
 sgFunc.cells[7,0]:='TEXTO_CCUSTO';
 sgFunc.cells[8,0]:='DTNASCIMENTO';
 sgFunc.cells[9,0]:='DTENTRADA';
 

end;

function Dc_MessageDlg(Msg: string; AType: TMsgDlgType; AButtons:
  TMsgDlgButtons; IndiceHelp: LongInt; DefButton: TMOdalResult = mrNone;
  Portugues: Boolean = True): Word;
var
  I: Integer;
  Mensagem: TForm;
begin
  Mensagem := CreateMessageDialog(Msg, AType, Abuttons);
  Mensagem.HelpContext := IndiceHelp;
  with Mensagem do 
  begin 
    for i := 0 to ComponentCount - 1 do 
    begin 
      if (Components[i] is TButton) then 
      begin 
        if (TButton(Components[i]).ModalResult = DefButton) then 
        begin 
          ActiveControl := TWincontrol(Components[i]); 
        end; 
      end; 
    end; 
    if Portugues then 
    begin 
      if Atype = mtConfirmation then 
        Caption := 'Confirmação' 
      else if AType = mtWarning then 
        Caption := 'Aviso' 
      else if AType = mtError then 
        Caption := 'Erro' 
      else if AType = mtInformation then 
        Caption := 'Informação'; 
    end; 
  end; 
  if Portugues then 
  begin 
    TButton(Mensagem.FindComponent('YES')).Caption := '&Sim'; 
    TButton(Mensagem.FindComponent('NO')).Caption := '&Não'; 
    TButton(Mensagem.FindComponent('CANCEL')).Caption := '&Cancelar'; 
    TButton(Mensagem.FindComponent('ABORT')).Caption := '&Abortar'; 
    TButton(Mensagem.FindComponent('RETRY')).Caption := '&Repetir'; 
    TButton(Mensagem.FindComponent('IGNORE')).Caption := '&Ignorar'; 
    TButton(Mensagem.FindComponent('ALL')).Caption := '&Todos'; 
    TButton(Mensagem.FindComponent('HELP')).Caption := 'A&juda'; 
  end; 
  Result := Mensagem.ShowModal; 
  Mensagem.Free; 
end;

procedure TfrmImport.btnEscolherClick(Sender: TObject);
begin
 {dmBanco.DSET.close;
 dmBanco.DSET.Prepare;
 dmBanco.DSET.open;
 pngrid.Caption := 'Aguarde...Verificando Funcionários já importados anteriormente...';
 dmBanco.DSET.Last;
 if (dmbanco.DSET.RecordCount > 0) then begin
     if DC_MessageDlg ('Já existe uma lista de funcionários importada anterioremente.'+#13+ 'Se importar novamente, a lista anterior será excluída.'+#13+
                       'VOCÊ TEM CERTEZA ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
       begin
         if (opDlg.Execute) then begin
          edPath.Text := opDlg.FileName;
           Xls_To_StringGrid(sgFunc, opDlg.FileName) ;
           dmbanco.dset.Delete;
           if not (dmbanco.IBTransaction1.Connection.InTransaction) then
            dmbanco.IBTransaction1.StartTransaction;
         end;
       end
       // se nao quiser importar, apenas mostra o que foi importado anteriormente
       else begin
        dmbanco.DSET.First;

        pngrid.Visible := true;
        frmImport.Refresh;
        LoadGrid;
        pngrid.visible := false;
        exit;
       end;
 end
 else begin
   if (opDlg.Execute) then begin
          edPath.Text := opDlg.FileName;
     //pngrid.Caption := 'Aguarde...Importando Lista de Funcionários...';
     Xls_To_StringGrid(sgFunc, opDlg.FileName) ;
   end;
 end;

 insertBanco;
 pngrid.Visible := false;
 ShowMessage('Arquivo importado com sucesso');
 dmBanco.DSET.Last;
 lbRec.Caption := IntToStr(dmbanco.DSET.RecordCount-1) + ' registros foram importados';
 btnLimpar.Visible := sgFunc.Cells[0,1] <> '';}
end;

procedure TfrmImport.sgFuncDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  {If (arow > 0)  then // testa se não é a primeira linha (fixa)
     if (odd(arow)) then begin // verifica se a linha é impar
        sgFunc.Canvas.Font.Color:= clBlack;
        sgFunc.Canvas.Brush.Color:= $00B9F1F9;
     end
     else begin
        sgFunc.Canvas.Font.Color:= clBlack;
        sgFunc.Canvas.Brush.Color:= clLtGray;
     end;
  //sgFunc.Canvas.FillRect(Rect); // redesenha a celula
  sgFunc.Canvas.TextOut(Rect.Left+2,Rect.Top,sgFunc.Cells[acol,arow]); // reimprime  o texto.

  if gdFocused in State then
   with (Sender as TStringGrid).Canvas do begin
    Brush.Color:=clRed;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, sgFunc.Cells[acol,arow]);

   end;}

end;

function TfrmImport.insertBanco: boolean;
var i:integer;
begin
    { for i:=1 to sgFunc.RowCount -1 do begin
      with dmBanco do begin
       //dmBanco.DSET.close;
      // dmBanco.DSET.Prepare;
      // dmBanco.DSET.open;
      // DSet.Open;
      pngrid.Caption := 'Aguarde...Importando '+ IntToStr(i) + ' de '+ IntToStr(sgFunc.RowCount) + ' funcionários';
      pngrid.Visible := true;
      frmImport.Refresh;
       if not (dmbanco.IBTransaction1.Connection.InTransaction) then
            dmbanco.IBTransaction1.StartTransaction;
       DSet.Insert;
       DSet.FieldByName('RE').AsString := sgFunc.Cells[0,i];
       DSet.FieldByName('NOME').AsString := sgFunc.Cells[1,i];
       DSet.FieldByName('CARGO').AsString := sgFunc.Cells[2,i];
       DSet.FieldByName('SETOR').AsString := sgFunc.Cells[3,i];
       DSet.FieldByName('SITUACAO').AsString := sgFunc.Cells[4,i];
       DSet.FieldByName('SEXO').AsString := sgFunc.Cells[5,i];
       DSet.FieldByName('CCUSTO').AsString := sgFunc.Cells[6,i];
       DSet.FieldByName('NOME_CCUSTO').AsString := sgFunc.Cells[7,i];
       DSet.FieldByName('DTNASCIMENTO').AsString := sgFunc.Cells[8,i];
       DSet.FieldByName('ADMISSAO').AsString := sgFunc.Cells[9,i];
       DSet.Post;
      end;

     end;
     dmbanco.IBTransaction1.Commit;
     dmBanco.DSET.open;}
end;

function TFrmImport.LoadGrid:boolean;
  var i:integer;
begin
   {   with dmBanco do begin
       DSet.Open;
       //dset.FetchAll;
       sgFunc.RowCount := DSET.RecordCount;
       for i:=1 to sgFunc.RowCount do begin
       sgFunc.Cells[0,i] := DSet.FieldByName('RE').AsString;
       sgFunc.Cells[1,i] := DSet.FieldByName('NOME').AsString;
       sgFunc.Cells[2,i] := DSet.FieldByName('CARGO').AsString;
       sgFunc.Cells[3,i] := DSet.FieldByName('SETOR').AsString;
       sgFunc.Cells[4,i] := DSet.FieldByName('SITUACAO').AsString;
       sgFunc.Cells[5,i] := DSet.FieldByName('SEXO').AsString;
       sgFunc.Cells[6,i] := DSet.FieldByName('CCUSTO').AsString;
       sgFunc.Cells[7,i] := DSet.FieldByName('NOME_CCUSTO').AsString;
       sgFunc.Cells[8,i] := DSet.FieldByName('DTNASCIMENTO').AsString;
       sgFunc.Cells[9,i] := DSet.FieldByName('ADMISSAO').AsString;
       dset.Next;
      end;
     result := true;
     end;}
end;

procedure TfrmImport.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmImport.FormShow(Sender: TObject);
begin
sgFunc.cells[0,0]:='RE';
 sgFunc.cells[1,0]:='NOME';
 sgFunc.cells[2,0]:='CARGO';
 sgFunc.cells[3,0]:='SUBGRUPO';
 sgFunc.cells[4,0]:='GRUPO';
 sgFunc.cells[5,0]:='SEXO';
 sgFunc.cells[6,0]:='CCUSTO';
 sgFunc.cells[7,0]:='TEXTO_CCUSTO';
 sgFunc.cells[8,0]:='DTNASCIMENTO';
 sgFunc.cells[9,0]:='DTENTRADA';

 btnLimpar.Visible := sgFunc.Cells[0,1] <> '';
end;

procedure TfrmImport.btnLimparClick(Sender: TObject);
var i:Integer;
begin
 {with dmbanco do begin
  dmBanco.DSET.close;
 dmBanco.DSET.Prepare;
 dmBanco.DSET.open;
   if not (dmbanco.IBTransaction1.Connection.InTransaction) then
            dmbanco.IBTransaction1.StartTransaction;
  dset.Delete;
  IBTransaction1.Commit;
  with sgFunc do
    for I := 0 to RowCount -1 do
      Rows[I].Clear;
 end;
 btnLimpar.Visible := sgFunc.Cells[0,1] <> '';}
end;

end.
