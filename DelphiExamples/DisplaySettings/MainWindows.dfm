object Form1: TForm1
  Left = 264
  Top = 108
  Width = 385
  Height = 216
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 131
    Width = 186
    Height = 25
    Caption = 'GetCurrDisplaySettings'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 185
    Height = 129
    TabOrder = 1
  end
  object Button2: TButton
    Left = 192
    Top = 132
    Width = 185
    Height = 25
    Caption = 'SetNew'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 192
    Top = 0
    Width = 185
    Height = 21
    TabOrder = 3
    Text = 'HORZRES'
  end
  object Edit2: TEdit
    Left = 192
    Top = 32
    Width = 185
    Height = 21
    TabOrder = 4
    Text = 'VERTRES'
  end
  object Edit3: TEdit
    Left = 192
    Top = 64
    Width = 185
    Height = 21
    TabOrder = 5
    Text = 'BITSPIXEL'
  end
  object Edit4: TEdit
    Left = 192
    Top = 96
    Width = 185
    Height = 21
    TabOrder = 6
    Text = 'REFRESH'
  end
  object Button3: TButton
    Left = 192
    Top = 160
    Width = 185
    Height = 25
    Caption = 'SetPreviosResolution'
    TabOrder = 7
    OnClick = Button3Click
  end
end
