inherited MesclarArquivos: TMesclarArquivos
  Caption = 'Mesclar arquivos'
  ClientHeight = 573
  ClientWidth = 1081
  WindowState = wsMaximized
  OnCreate = FormCreate
  ExplicitWidth = 1097
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 21
  object pnlProximo: TPanel
    Left = 0
    Top = 528
    Width = 1081
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlProximo'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      1081
      45)
    object btnProximo: TButton
      Left = 896
      Top = 5
      Width = 178
      Height = 35
      Action = actMesclarDocumentos
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object pgcEtapas: TPageControl
    Left = 0
    Top = 0
    Width = 1081
    Height = 528
    ActivePage = tbsArquivos
    Align = alClient
    TabOrder = 1
    object tbsArquivos: TTabSheet
      Caption = 'Arquivos'
      TabVisible = False
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 1073
        Height = 518
        Align = alClient
        ColumnCollection = <
          item
            Value = 50.001188872450380000
          end
          item
            SizeStyle = ssAbsolute
            Value = 20.000000000000000000
          end
          item
            Value = 49.998811127549620000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label1
            Row = 0
          end
          item
            Column = 2
            Control = Label3
            Row = 0
          end
          item
            Column = 0
            Control = VisualizarXML1
            Row = 1
          end
          item
            Column = 1
            Control = Splitter1
            Row = 1
          end
          item
            Column = 2
            Control = VisualizarXML2
            Row = 1
          end>
        ParentColor = True
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 0
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 525
          Height = 30
          Align = alClient
          Alignment = taCenter
          Caption = 'Arquivo local'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 113
          ExplicitHeight = 25
        end
        object Label3: TLabel
          Left = 546
          Top = 1
          Width = 526
          Height = 30
          Align = alClient
          Alignment = taCenter
          Caption = 'Arquivo da Stream'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 159
          ExplicitHeight = 25
        end
        inline VisualizarXML1: TVisualizarXML
          Left = 1
          Top = 31
          Width = 525
          Height = 486
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitLeft = 1
          ExplicitTop = 31
          ExplicitWidth = 525
          ExplicitHeight = 486
          inherited memoXML: TMemo
            Width = 525
            Height = 457
            ExplicitWidth = 525
            ExplicitHeight = 457
          end
          inherited ToolBar1: TToolBar
            Width = 525
            ExplicitWidth = 525
          end
        end
        object Splitter1: TSplitter
          Left = 526
          Top = 31
          Width = 20
          Height = 486
          Align = alClient
          ExplicitLeft = 516
          ExplicitTop = 22
          ExplicitWidth = 21
          ExplicitHeight = 616
        end
        inline VisualizarXML2: TVisualizarXML
          Left = 546
          Top = 31
          Width = 526
          Height = 486
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitLeft = 546
          ExplicitTop = 31
          ExplicitWidth = 526
          ExplicitHeight = 486
          inherited memoXML: TMemo
            Width = 526
            Height = 457
            ExplicitWidth = 526
            ExplicitHeight = 457
          end
          inherited ToolBar1: TToolBar
            Width = 526
            ExplicitWidth = 526
          end
        end
      end
    end
    object tbsFinal: TTabSheet
      Caption = 'Final'
      ImageIndex = 1
      TabVisible = False
      inline VisualizarXML3: TVisualizarXML
        Left = 0
        Top = 0
        Width = 1073
        Height = 518
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 1073
        ExplicitHeight = 518
        inherited memoXML: TMemo
          Width = 1073
          Height = 489
          ExplicitWidth = 1073
          ExplicitHeight = 489
        end
        inherited ToolBar1: TToolBar
          Width = 1073
          ExplicitWidth = 1073
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 856
    Top = 352
    object actMesclarDocumentos: TAction
      Caption = 'Mesclar documentos'
      OnExecute = actMesclarDocumentosExecute
    end
    object actVoltar: TAction
      Caption = 'Tentar novamente'
      OnExecute = actVoltarExecute
    end
  end
end
