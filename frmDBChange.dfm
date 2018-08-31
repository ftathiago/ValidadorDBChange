object frmValidadorDBChange: TfrmValidadorDBChange
  Left = 0
  Top = 0
  Caption = 'Validador de DBChange'
  ClientHeight = 508
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAbrirDbChange: TPanel
    Left = 0
    Top = 0
    Width = 813
    Height = 75
    Align = alTop
    Caption = 'Abrir dbChange.xml'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      813
      75)
    object btnAbrirDbChange: TSpeedButton
      Left = 6
      Top = 7
      Width = 88
      Height = 22
      Caption = 'Abrir'
      OnClick = btnAbrirDbChangeClick
    end
    object SpeedButton1: TSpeedButton
      Left = 12
      Top = 38
      Width = 99
      Height = 22
      Caption = 'Marcar repetidos'
      OnClick = SpeedButton1Click
    end
    object edtFileName: TEdit
      Left = 96
      Top = 8
      Width = 703
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 75
    Width = 813
    Height = 433
    ActivePage = tbsScript
    Align = alClient
    TabOrder = 1
    object tbsScript: TTabSheet
      Caption = 'Scripts'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 55
        Width = 805
        Height = 350
        Align = alClient
        DataSource = dtsDBChange
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = DBGrid1TitleClick
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 805
        Height = 55
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 316
          Top = 18
          Width = 87
          Height = 13
          Caption = 'Localizar SCRIPT: '
        end
        object rgpFiltro: TRadioGroup
          Left = 2
          Top = 4
          Width = 283
          Height = 44
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
          Left = 403
          Top = 15
          Width = 121
          Height = 21
          TabOrder = 1
          OnChange = edtLocalizarSCRIPTChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'XML (Texto)'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object memXML: TMemo
        Left = 0
        Top = 33
        Width = 805
        Height = 372
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 805
        Height = 33
        Align = alTop
        TabOrder = 1
        object SpeedButton2: TSpeedButton
          Left = 2
          Top = 2
          Width = 89
          Height = 22
          Caption = 'DataSet -> XML'
          OnClick = SpeedButton2Click
        end
        object SpeedButton4: TSpeedButton
          Left = 92
          Top = 2
          Width = 80
          Height = 22
          Caption = 'Salvar XML'
          OnClick = SpeedButton4Click
        end
      end
    end
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultExtension = '*.xml'
    FavoriteLinks = <>
    FileTypes = <>
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
end