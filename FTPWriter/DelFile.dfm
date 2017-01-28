object FDelFile: TFDelFile
  Left = 235
  Top = 193
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Удаление файла'
  ClientHeight = 90
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PDelFile: TPanel
    Left = 0
    Top = 60
    Width = 301
    Height = 30
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object BDelFile: TSpeedButton
      Left = 4
      Top = 4
      Width = 147
      Height = 22
      Cursor = crHandPoint
      Hint = 'Потверждение удаления файла'
      Caption = 'Удалить файл'
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FFFFFFFFFFF3333300003000000000000333333888888888888F3333
        000030FFFFFFFFFF03333338F3333333338F3333000030FFFFFFFFFF03333338
        F3333333338F3333000030F00000000F03333338F8888888838F3333000030FF
        FFFF111111133338F33333FFFFFFF333000030F00000999999913338F8888888
        88888F33000030FFFFFFFFFF03333338F3333333338F3333000030F00000000F
        03333338F8888888838F3333000030FFFFFFFFFF03333338F3333333338F3333
        000030F00000000F03333338F8888888838F3333000030FFFFFFFFFF03333338
        F3333333338F3333000030FFFF00000F03333338FFF38888838F333300003000
        0FFFFFFF03333338888F3333338F33330000330F0F00000F033333338F8F8888
        838F3333000033300FFFFFFF03333333388FFFFFFF8F33330000333300000000
        0333333333888888888333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BDelFileClick
    end
    object BCancel: TSpeedButton
      Left = 151
      Top = 4
      Width = 146
      Height = 22
      Cursor = crHandPoint
      Hint = 'Отмена удаления файла'
      Caption = 'Отмена'
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
  object PMsg: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 60
    Align = alClient
    TabOrder = 1
    object LMsg1: TLabel
      Left = 4
      Top = 8
      Width = 293
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Вы действительно хотите удалить файл'
    end
    object LMsg2: TLabel
      Left = 4
      Top = 24
      Width = 293
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LMsg2'
    end
    object LMsg3: TLabel
      Left = 4
      Top = 40
      Width = 293
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'из списка?'
    end
  end
  object RxGradientCaption1: TRxGradientCaption
    Captions = <>
    FormCaption = 'Удаление файла'
    StartColor = clBlue
    Left = 272
    Top = 60
  end
end
