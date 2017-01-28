object FPropFile: TFPropFile
  Left = 199
  Top = 153
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Свойства файла'
  ClientHeight = 87
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LFileName: TLabel
    Left = 4
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Файл:'
  end
  object LDest: TLabel
    Left = 4
    Top = 36
    Width = 64
    Height = 13
    Caption = 'Назначение:'
  end
  object PPropFile: TPanel
    Left = 0
    Top = 59
    Width = 320
    Height = 28
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object BApply: TSpeedButton
      Left = 4
      Top = 3
      Width = 156
      Height = 22
      Cursor = crHandPoint
      Hint = 'Применить сделанные изменения'
      Caption = 'Применить'
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
        1111111111111111111111110000111111211111111111111111F11111111111
        000011111AA211111111111111188F1111111111000011111AAA211111111111
        111888F11111111100001111AAAA211111111111118888F11111111100001111
        AA1AA211111111111188188F111111110000111AA211AA2111111111188F1188
        F11111110000111AA111AA211111111118811188F1111111000011AA21111AA2
        1111111188F111188F111111000011AA111111AA211111118811111188F11111
        000011111111111AA211111111111111188F1111000011111111111AA2111111
        11111111188F11110000111111111111AA211111111111111188F11100001111
        111111111AA211111111111111188F1100001111111111111AA2111111111111
        11188F11000011111111111111AA111111111111111188110000111111111111
        1111111111111111111111110000111111111111111111111111111111111111
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BApplyClick
    end
    object BCancel: TSpeedButton
      Left = 160
      Top = 3
      Width = 156
      Height = 22
      Cursor = crHandPoint
      Hint = 'Отменить изменения'
      Caption = 'Отменить'
      Flat = True
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D8000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333330000003331333333333331330000003399133333333399130000003339
        9133333339913300000033339913333399133300000033333991333991333300
        0000333333991199133333000000333333399991333333000000333333339913
        3333330000003333333999913333330000003333339913991333330000003333
        3991333991333300000033339913333399133300000033399133333339913300
        0000339913333333339933000000333333333333333333000000333333333333
        333333000000333333333333333333000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BCancelClick
    end
  end
  object EFileName: TEdit
    Left = 44
    Top = 4
    Width = 269
    Height = 21
    Hint = 'Имя файла и путь к нему'
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object EDest: TEdit
    Left = 76
    Top = 32
    Width = 237
    Height = 21
    Hint = 'Каталог FTP-сервера'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object RxGradientCaption1: TRxGradientCaption
    Captions = <>
    FormCaption = 'Свойства файла'
    StartColor = clBlue
    Left = 292
    Top = 59
  end
end
