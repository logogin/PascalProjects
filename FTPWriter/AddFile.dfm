object FAddFile: TFAddFile
  Left = 210
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Добавить файл'
  ClientHeight = 84
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LFileName: TLabel
    Left = 4
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Имя файла:'
  end
  object LDest: TLabel
    Left = 4
    Top = 32
    Width = 64
    Height = 13
    Caption = 'Назначение:'
  end
  object FEFile: TFilenameEdit
    Left = 76
    Top = 4
    Width = 237
    Height = 21
    Hint = 'Имя файла и путь к нему'
    OnAfterDialog = FEFileAfterDialog
    DialogOptions = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    DialogTitle = 'Укажите файл'
    NumGlyphs = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = FEFileChange
  end
  object EDest: TEdit
    Left = 76
    Top = 28
    Width = 237
    Height = 21
    Hint = 'Путь к каталогу FTP-сервера'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object PAddFile: TPanel
    Left = 0
    Top = 54
    Width = 314
    Height = 30
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    object BAddFile: TSpeedButton
      Left = 4
      Top = 4
      Width = 153
      Height = 22
      Cursor = crHandPoint
      Hint = 'Добавить файл в список'
      Caption = 'Добавить файл'
      Enabled = False
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
        11111111FFFFFFFFFFF1111100001000000000000111111888888888888F1111
        000010FFFFFFFFFF01111118F1111111118F1111000010FFFFFFFFFA21111118
        F111111118F11111000010F00000000A21111118F888888888F11111000010FF
        FFFF222A22211118F11111FFF8FFF111000010F00000AAAAAAA11118F8888888
        88888111000010FFFFFFFFFA21111118F111111118F11111000010F00000000A
        21111118F888888888F11111000010FFFFFFFFFA21111118F111111118F11111
        000010F00000000F01111118F8888888818F1111000010FFFFFFFFFF01111118
        F1111111118F1111000010FFFF00000F01111118FFF18888818F111100001000
        0FFFFFFF01111118888F1111118F11110000110F0F00000F011111118F8F8888
        818F1111000011100FFFFFFF01111111188FFFFFFF8F11110000111100000000
        0111111111888888888111110000111111111111111111111111111111111111
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BAddFileClick
    end
    object BCancel: TSpeedButton
      Left = 157
      Top = 4
      Width = 153
      Height = 22
      Cursor = crHandPoint
      Hint = 'Отменить добавление файла'
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
  object RxGradientCaption1: TRxGradientCaption
    Captions = <>
    FormCaption = 'Добавить файл'
    StartColor = clBlue
    Left = 284
    Top = 52
  end
end
