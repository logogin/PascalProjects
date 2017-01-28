object TestForm: TTestForm
  Left = 62
  Top = 101
  ActiveControl = PhoneNumber
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Тестовая программа связи через DirectPlay'
  ClientHeight = 104
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 30
    Align = alTop
    TabOrder = 0
    object Connect: TSpeedButton
      Left = 4
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Установить связь'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        003333377777777777F3333091111111103333F7F3F3F3F3F7F3311098080808
        10333777F737373737F313309999999910337F373F3F3F3F3733133309808089
        03337FFF7F7373737FFF1000109999901000777777FFFFF77777701110000000
        111037F337777777F3373099901111109990373F373333373337330999999999
        99033373FFFFFFFFFF7333310000000001333337777777777733333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ConnectClick
    end
    object ExitButton: TSpeedButton
      Left = 544
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Завершить работу'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ExitButtonClick
    end
    object WaitForConnect: TSpeedButton
      Left = 27
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Ожидание входящего звонка'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003B3000000000
        003B37F77777777777F73BB09111111110BB3777F3F3F3F3F777311098080808
        10B33777F7373737377313309999999910337F373F3F3F3F3733133309808089
        03337F3373737373733313333099999033337FFFF7FFFFF7FFFFB011B0000000
        BBBB7777777777777777B01110BBBBB0BBBB77F37777777777773011108BB333
        333337F337377F3FFFF33099111BB3010033373F33777F77773F331999100101
        11033373FFF77773337F33300099991999033337773FFFF33373333BB7100199
        113333377377773FF7F333BB333BB7011B33337733377F7777FF3BB3333BB333
        3BB3377333377F33377FBB33333BB33333BB7733333773333377}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = WaitForConnectClick
    end
    object PhoneNumber: TEdit
      Left = 77
      Top = 4
      Width = 77
      Height = 21
      Hint = 'Номер'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object DialMode: TComboBox
      Left = 165
      Top = 4
      Width = 113
      Height = 21
      Hint = 'Способ набора номера'
      Style = csDropDownList
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Items.Strings = (
        'Импульсный'
        'Тоновый')
    end
    object Modem: TComboBox
      Left = 289
      Top = 4
      Width = 189
      Height = 21
      Hint = 'Использующийся модем'
      Style = csDropDownList
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object AllowWaiting: TCheckBox
      Left = 56
      Top = 7
      Width = 13
      Height = 17
      Hint = 'Автоматический переход в режим ожидания звонка'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object DXPlay: TDXPlay
    Async = False
    GUID = '{00000000-0000-0000-0000-000000000000}'
    MaxPlayers = 0
    ModemSetting.Enabled = False
    TCPIPSetting.Enabled = False
    TCPIPSetting.Port = 0
    Top = 32
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = StartTimerTimer
    Left = 28
    Top = 32
  end
end
