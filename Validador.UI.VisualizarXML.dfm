object VisualizarXML: TVisualizarXML
  Left = 0
  Top = 0
  Width = 754
  Height = 663
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object memoXML: TMemo
    Left = 0
    Top = 29
    Width = 754
    Height = 634
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 754
    Height = 29
    AutoSize = True
    ButtonHeight = 29
    ButtonWidth = 107
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actAbrirArquivo
    end
    object ToolButton2: TToolButton
      Left = 107
      Top = 0
      Action = actSalvarArquivo
    end
    object ToolButton3: TToolButton
      Left = 214
      Top = 0
      Action = actCopiarXML
    end
  end
  object ActionList: TActionList
    Left = 96
    Top = 40
    object actAbrirArquivo: TAction
      Caption = 'Abrir arquivo'
      OnExecute = actAbrirArquivoExecute
    end
    object actSalvarArquivo: TAction
      Caption = 'Salvar arquivo'
      OnExecute = actSalvarArquivoExecute
    end
    object actSelecionarTudo: TAction
      Caption = 'Selecionar tudo'
      ShortCut = 16449
      OnExecute = actSelecionarTudoExecute
    end
    object actCopiarXML: TAction
      Caption = 'Copiar XML'
      ShortCut = 16451
      OnExecute = actCopiarXMLExecute
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = '*.xml|*.xml'
    Left = 32
    Top = 88
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.xml'
    FileName = 'dbChange.xml'
    Filter = '*.xml|*.xml'
    Left = 96
    Top = 88
  end
end
