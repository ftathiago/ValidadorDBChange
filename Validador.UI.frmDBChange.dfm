inherited frmValidadorDBChange: TfrmValidadorDBChange
  Caption = 'Validador de DBChange'
  ClientHeight = 662
  ClientWidth = 1071
  OnCreate = FormCreate
  ExplicitWidth = 1087
  ExplicitHeight = 701
  PixelsPerInch = 96
  TextHeight = 21
  object pnlAbrirDbChange: TPanel
    Left = 0
    Top = 0
    Width = 1071
    Height = 89
    Align = alTop
    Caption = 'Abrir dbChange.xml'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      1071
      89)
    object btnAbrirDbChange: TSpeedButton
      Left = 6
      Top = 7
      Width = 88
      Height = 30
      Caption = 'Abrir'
      OnClick = btnAbrirDbChangeClick
    end
    object SpeedButton1: TSpeedButton
      Left = 6
      Top = 43
      Width = 143
      Height = 30
      Caption = 'Marcar repetidos'
      OnClick = SpeedButton1Click
    end
    object Analisar: TSpeedButton
      Left = 155
      Top = 43
      Width = 142
      Height = 30
      Caption = 'Analisar dados'
      OnClick = AnalisarClick
    end
    object edtFileName: TEdit
      Left = 96
      Top = 8
      Width = 961
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 89
    Width = 1071
    Height = 573
    ActivePage = tbsScript
    Align = alClient
    TabOrder = 1
    object tbsScript: TTabSheet
      Caption = 'Scripts'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 68
        Width = 1063
        Height = 469
        Align = alClient
        DataSource = dtsDBChange
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnTitleClick = DBGrid1TitleClick
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1063
        Height = 68
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 316
          Top = 18
          Width = 122
          Height = 21
          Caption = 'Localizar SCRIPT: '
        end
        object rgpFiltro: TRadioGroup
          Left = 17
          Top = 4
          Width = 283
          Height = 55
          Caption = ' Filtro '
          Columns = 3
          Items.Strings = (
            'Todos'
            'Repetidos'
            'Importar')
          TabOrder = 0
          OnClick = rgpFiltroClick
        end
        object edtLocalizarSCRIPT: TEdit
          Left = 444
          Top = 15
          Width = 189
          Height = 29
          TabOrder = 1
          OnChange = edtLocalizarSCRIPTChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'XML (Texto)'
      object memXML: TMemo
        Left = 0
        Top = 49
        Width = 1063
        Height = 488
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1063
        Height = 49
        Align = alTop
        TabOrder = 1
        object SpeedButton2: TSpeedButton
          Left = 2
          Top = 5
          Width = 143
          Height = 30
          Caption = 'DataSet -> XML'
          OnClick = SpeedButton2Click
        end
        object SpeedButton4: TSpeedButton
          Left = 151
          Top = 5
          Width = 143
          Height = 30
          Caption = 'Salvar XML'
          OnClick = SpeedButton4Click
        end
      end
    end
    object tbsRelacaoScriptArquivo: TTabSheet
      Caption = 'Rela'#231#227'o Script x Arquivo'
      ImageIndex = 2
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 1063
        Height = 537
        Align = alClient
        DataSource = dtsArquivos
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultExtension = '*.xml'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'XML'
        FileMask = '*.xml'
      end>
    Options = []
    Left = 582
    Top = 44
  end
  object dtsDBChange: TDataSource
    DataSet = cdsDBChange
    Left = 584
    Top = 92
  end
  object cdsDBChange: TFDMemTable
    OnNewRecord = cdsDBChangeNewRecord
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 580
    Top = 142
    object cdsDBChangeOrdemOriginal: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Ord'
      DisplayWidth = 5
      FieldName = 'OrdemOriginal'
    end
    object cdsDBChangeRepetido: TBooleanField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'Repetido'
    end
    object cdsDBChangeImportar: TBooleanField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'Importar'
    end
    object cdsDBChangeExisteNaPasta: TBooleanField
      DisplayLabel = 'Existe'
      FieldName = 'ExisteNaPasta'
    end
    object cdsDBChangeNome: TStringField
      DisplayWidth = 25
      FieldName = 'Nome'
      Size = 50
    end
    object cdsDBChangeVersao: TStringField
      DisplayWidth = 10
      FieldName = 'Versao'
    end
    object cdsDBChangeZDescricao: TStringField
      DisplayWidth = 100
      FieldName = 'ZDescricao'
      Size = 250
    end
    object cdsDBChangeDescricao: TStringField
      DisplayWidth = 100
      FieldName = 'Descricao'
      Size = 250
    end
    object cdsDBChangeTemPos: TBooleanField
      Alignment = taCenter
      FieldName = 'TemPos'
    end
    object cdsDBChangeValue: TStringField
      FieldName = 'Value'
      Size = 50
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xml'
    FileName = 'dbChange.xml'
    Left = 574
    Top = 189
  end
  object cdsArquivos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 400
    Top = 256
    object cdsArquivosPATH: TStringField
      FieldName = 'PATH'
      Size = 600
    end
    object cdsArquivosNOME_ARQUIVO: TStringField
      FieldName = 'NOME_ARQUIVO'
      Size = 50
    end
  end
  object dtsArquivos: TDataSource
    DataSet = cdsArquivos
    Left = 400
    Top = 304
  end
  object DirOpen: TOpenDialog
    Left = 404
    Top = 171
  end
  object cdsAnalise: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'NOME_SCRIPT'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 328
    Top = 256
    object cdsAnaliseNOME_SCRIPT: TStringField
      DisplayLabel = 'Script'
      FieldName = 'NOME_SCRIPT'
      Size = 50
    end
    object cdsAnaliseNOME_ARQUIVO: TStringField
      DisplayLabel = 'Arquivo'
      FieldName = 'NOME_ARQUIVO'
      Size = 50
    end
  end
  object dtsAnalise: TDataSource
    DataSet = cdsAnalise
    Left = 326
    Top = 308
  end
end
