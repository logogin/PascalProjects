object Form1: TForm1
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 369
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 289
    Height = 337
    TabOrder = 0
  end
  object Button1: TButton
    Left = 214
    Top = 343
    Width = 75
    Height = 25
    Caption = 'GetInfo'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 344
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'C:\'
  end
end
