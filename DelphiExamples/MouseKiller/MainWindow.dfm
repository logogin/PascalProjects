object Form1: TForm1
  Left = 424
  Top = 164
  Width = 155
  Height = 158
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
    Left = 40
    Top = 8
    Width = 75
    Height = 25
    Caption = 'SetHook'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 40
    Width = 75
    Height = 25
    Caption = 'KillHook'
    TabOrder = 1
    OnClick = Button2Click
  end
end
