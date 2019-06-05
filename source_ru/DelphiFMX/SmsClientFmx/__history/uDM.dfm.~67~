object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 444
  Width = 371
  object IdTCPClient: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 40
    Top = 40
  end
  object odTelList: TOpenDialog
    Filter = 'TXT Files|*.txt'
    Left = 120
    Top = 40
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'StringFormat=Unicode'
      'Database=D:\'#1055#1088#1080#1084#1077#1088#1099'\SmsClientFmx\db\SmsData.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 256
    Top = 104
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 256
    Top = 160
  end
  object fdQGetHistorySmsSending: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID_CONTACTS, _NAME, _DATE, CONT_LIST'
      'FROM CONTACTS'
      'WHERE USER_ID = :pUId;')
    Left = 120
    Top = 248
    ParamData = <
      item
        Name = 'PUID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object fdQGetHistorySmsSendingID_CONTACTS: TFDAutoIncField
      FieldName = 'ID_CONTACTS'
      Origin = 'ID_CONTACTS'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdQGetHistorySmsSending_NAME: TWideStringField
      FieldName = '_NAME'
      Origin = '_NAME'
      Required = True
      Size = 32767
    end
    object fdQGetHistorySmsSending_DATE: TDateTimeField
      FieldName = '_DATE'
      Origin = '_DATE'
    end
    object fdQGetHistorySmsSendingCONT_LIST: TWideMemoField
      FieldName = 'CONT_LIST'
      Origin = 'CONT_LIST'
      Required = True
      BlobType = ftWideMemo
    end
  end
  object fdAddNewUser: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'insert or ignore INTO USERS (LOGIN, PASS) VALUES (:pLog, :pPass)' +
        ';'
      'SELECT ID_USER FROM USERS WHERE LOGIN = :pLog_;')
    Left = 120
    Top = 200
    ParamData = <
      item
        Name = 'PLOG'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PPASS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PLOG_'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object fdAddNewSendHistory: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'INSERT INTO CONTACTS (_NAME, _DATE, USER_ID, CONT_LIST)'
      'VALUES'
      '(:pName, :pDate, :pUId, :pCntL);')
    Left = 120
    Top = 352
    ParamData = <
      item
        Name = 'PNAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PDATE'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'PUID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PCNTL'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object fdQGetUserId: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT ID_USER FROM USERS WHERE (LOGIN = :pLog) AND (PASS = :pPa' +
        'ss);')
    Left = 120
    Top = 296
    ParamData = <
      item
        Name = 'PLOG'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PPASS'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object fdQFreeCmd: TFDQuery
    Connection = FDConnection
    Left = 120
    Top = 144
  end
  object fdQInserOrUpdateSendHistory: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      ''
      
        'INSERT OR REPLACE INTO CONTACTS (_NAME, _DATE, USER_ID, CONT_LIS' +
        'T)'
      'VALUES'
      '(:pName, :pDate, :pUId, :pCntL);')
    Left = 272
    Top = 272
    ParamData = <
      item
        Name = 'PNAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PDATE'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'PUID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PCNTL'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
