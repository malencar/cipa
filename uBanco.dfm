object dmBanco: TdmBanco
  OldCreateOrder = False
  Height = 735
  Width = 1346
  object dsCadastro: TDataSource
    DataSet = qryCdastro
    Left = 104
    Top = 32
  end
  object dsetCadastro: TIBDataSet
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from CIPEIRO'
      'where'
      '  NUMERO = :OLD_NUMERO')
    InsertSQL.Strings = (
      'insert into CIPEIRO'
      '  (NUMERO, NOME, FOTO)'
      'values'
      '  (:NUMERO, :NOME, :FOTO)')
    RefreshSQL.Strings = (
      'Select '
      '  NUMERO,'
      '  NOME,'
      '  FOTO'
      'from CIPEIRO '
      'where'
      '  NUMERO = :NUMERO and'
      '  NOME = :NOME and'
      '  FOTO = :FOTO')
    SelectSQL.Strings = (
      'select * from CIPEIRO ORDER BY 1')
    ModifySQL.Strings = (
      'update CIPEIRO'
      'set'
      '  NUMERO = :NUMERO,'
      '  NOME = :NOME,'
      '  FOTO = :FOTO'
      'where'
      '  NUMERO = :OLD_NUMERO')
    ParamCheck = True
    UniDirectional = False
    Left = 504
    Top = 576
    object dsetCadastroID: TSmallintField
      FieldName = 'ID'
      Origin = 'CIPEIRO.ID'
      Visible = False
    end
    object dsetCadastroNUMERO: TIBStringField
      FieldName = 'NUMERO'
      Origin = 'CIPEIRO.NUMERO'
      Size = 10
    end
    object dsetCadastroNOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'CIPEIRO.NOME'
      Size = 51
    end
    object dsetCadastroFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'CIPEIRO.FOTO'
      Size = 8
    end
  end
  object dtsFoto: TIBDataSet
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select FOTO from CIPEIRO'
      'where numero = :numero')
    ParamCheck = True
    UniDirectional = False
    Left = 432
    Top = 576
    object dtsFotoFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'CIPEIRO.FOTO'
      Size = 8
    end
  end
  object dsFoto: TDataSource
    DataSet = dtsFoto
    Left = 464
    Top = 472
  end
  object dsReport: TDataSource
    DataSet = FDQryReport
    Left = 8
    Top = 424
  end
  object dsBrancos: TDataSource
    DataSet = FDQryBrancos
    Left = 24
    Top = 624
  end
  object IBTransaction7: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 312
    Top = 472
  end
  object dsNulos: TDataSource
    DataSet = FDQryNulos
    Left = 16
    Top = 680
  end
  object dsTotal: TDataSource
    DataSet = FDQryTotal
    Left = 8
    Top = 496
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Database=C:\SINDICO\CIPA.FDB'
      'Password=Masterkey')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction2
    Left = 21
    Top = 160
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 23
    Top = 224
  end
  object qryCdastro: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from CIPEIRO ORDER BY 1')
    Left = 184
    Top = 32
    object qryCdastroID: TSmallintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
      Visible = False
    end
    object qryCdastroNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object qryCdastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 51
    end
    object qryCdastroFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object FDQuery3: TFDQuery
    DetailFields = 'NOME;NUMERO;TOTAL_VOTOS'
    Connection = FDConnection1
    Transaction = FDTransaction3
    SQL.Strings = (
      
        'SELECT NUMERO,NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao wher' +
        'e NOME NOT IN ('#39'BRANCO'#39','#39'NULO'#39')'
      'GROUP by NUMERO,NOME,VOTO order BY TOTAL_VOTOS  DESC')
    Left = 168
    Top = 176
    object FDQuery3NUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQuery3NOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 51
    end
    object FDQuery3TOTAL_VOTOS: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'VOTOS V'#193'LIDOS'
      FieldName = 'TOTAL_VOTOS'
      Origin = 'TOTAL_VOTOS'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction4
    SQL.Strings = (
      'SELECT NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao'
      ' where NOME IN ('#39'BRANCO'#39','#39'NULO'#39')'
      ' GROUP by NOME,VOTO order BY TOTAL_VOTOS  DESC')
    Left = 160
    Top = 240
  end
  object FDQuery5: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction5
    SQL.Strings = (
      'select FOTO from CIPEIRO'
      'where numero = :numero')
    Left = 168
    Top = 312
    ParamData = <
      item
        Name = 'NUMERO'
        DataType = ftString
        ParamType = ptInput
        Size = 10
      end>
  end
  object FDQuery6: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction6
    SQL.Strings = (
      'select * from FUNCIONARIOS')
    Left = 168
    Top = 408
  end
  object IBTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 736
    Top = 232
  end
  object IBTransaction2: TFDTransaction
    Connection = FDConnection1
    Left = 832
    Top = 232
  end
  object FDTransaction3: TFDTransaction
    Connection = FDConnection1
    Left = 304
    Top = 216
  end
  object IBTransaction4: TFDTransaction
    Connection = FDConnection1
    Left = 944
    Top = 320
  end
  object IBTransaction5: TFDTransaction
    Connection = FDConnection1
    Left = 720
    Top = 304
  end
  object IBTransaction6: TFDTransaction
    Connection = FDConnection1
    Left = 832
    Top = 320
  end
  object FDQryTotal: TFDQuery
    DetailFields = 'TOTAL'
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT COUNT(VOTO) AS TOTAL FROM votacao')
    Left = 56
    Top = 504
    object FDQryTotalTOTAL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQryReport: TFDQuery
    DetailFields = 'NOME;NUMERO;TOTAL_VOTOS'
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT NUMERO,NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao wher' +
        'e NOME NOT IN ('#39'BRANCO'#39','#39'NULO'#39')'
      'GROUP by NUMERO,NOME,VOTO order BY TOTAL_VOTOS  DESC')
    Left = 56
    Top = 432
    object FDQryReportNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQryReportNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 51
    end
    object FDQryReportTOTAL_VOTOS: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'VOTOS'
      FieldName = 'TOTAL_VOTOS'
      Origin = 'TOTAL_VOTOS'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQryBrancos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao'
      ' where NOME IN ('#39'BRANCO'#39')'
      ' GROUP by NOME,VOTO order BY TOTAL_VOTOS  DESC')
    Left = 88
    Top = 624
  end
  object FDQuery9: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT NUMERO,NOME,FOTO FROM CIPEIRO WHERE NUMERO = :NUMERO')
    Left = 464
    Top = 400
    ParamData = <
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end>
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 304
    Top = 72
  end
  object FDQuery10: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction2
    SQL.Strings = (
      'SELECT NUMERO,NOME,FOTO FROM CIPEIRO')
    Left = 456
    Top = 72
  end
  object FDTransaction2: TFDTransaction
    Connection = FDConnection1
    Left = 304
    Top = 136
  end
  object FDTransaction4: TFDTransaction
    Connection = FDConnection1
    Left = 288
    Top = 288
  end
  object FDQuery11: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction2
    SQL.Strings = (
      'SELECT FOTO FROM CIPEIRO WHERE NUMERO = :NUMERO')
    Left = 752
    Top = 80
    ParamData = <
      item
        Name = 'NUMERO'
        DataType = ftString
        ParamType = ptInput
        Size = 10
      end>
  end
  object FDQuery12: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction5
    SQL.Strings = (
      'DELETE FROM CIPEIRO WHERE NUMERO = :numero')
    Left = 464
    Top = 240
    ParamData = <
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end>
  end
  object FDTransaction5: TFDTransaction
    Connection = FDConnection1
    Left = 304
    Top = 344
  end
  object FDQuery13: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction5
    SQL.Strings = (
      'DELETE FROM CIPEIRO WHERE NUMERO = :numero')
    Left = 472
    Top = 312
    ParamData = <
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end>
  end
  object FDQuery14: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction6
    SQL.Strings = (
      
        'UPDATE CIPEIRO SET NOME =:NOME,FOTO =:FOTO WHERE NUMERO = :NUMER' +
        'O')
    Left = 464
    Top = 152
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'FOTO'
        ParamType = ptInput
      end
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end>
  end
  object FDTransaction6: TFDTransaction
    Connection = FDConnection1
    Left = 312
    Top = 408
  end
  object FDQryNulos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT NOME, COUNT(VOTO) AS TOTAL_VOTOS FROM votacao'
      ' where NOME IN ('#39'NULO'#39')'
      ' GROUP by NOME,VOTO order BY TOTAL_VOTOS  DESC')
    Left = 96
    Top = 680
  end
  object VotosValidos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT COUNT(VOTO) AS VOTOS_validos FROM votacao where NOME NOT ' +
        'IN ('#39'BRANCO'#39','#39'NULO'#39')'
      '')
    Left = 88
    Top = 552
    object VotosValidosVOTOS_VALIDOS: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'VOTOS_VALIDOS'
      Origin = 'VOTOS_VALIDOS'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsVotosValidos: TDataSource
    DataSet = VotosValidos
    Left = 8
    Top = 552
  end
  object FDQryLimpar: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction7
    SQL.Strings = (
      'SELECT * FROM CIPEIRO WHERE NUMERO =1')
    Left = 744
    Top = 152
  end
  object FDTransaction7: TFDTransaction
    Connection = FDConnection1
    Left = 840
    Top = 160
  end
  object FDQueryVotacao: TFDQuery
    Connection = FDConnection1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from CIPEIRO ORDER BY 1')
    Left = 304
    Top = 624
    object SmallintField1: TSmallintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
      Visible = False
    end
    object StringField1: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 51
    end
    object BlobField1: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
end
