object Form1: TForm1
  Left = 312
  Top = 243
  Width = 416
  Height = 340
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
  object btSetHook: TButton
    Left = 8
    Top = 0
    Width = 75
    Height = 25
    Caption = 'btSetHook'
    TabOrder = 0
    OnClick = btSetHookClick
  end
  object btUnHook: TButton
    Left = 88
    Top = 32
    Width = 75
    Height = 25
    Caption = 'btUnHook'
    TabOrder = 1
    OnClick = btUnHookClick
  end
  object btBlockMouse: TButton
    Left = 88
    Top = 0
    Width = 75
    Height = 25
    Caption = 'btBlockMouse'
    TabOrder = 2
    OnClick = btBlockMouseClick
  end
  object btClearMouse: TButton
    Left = 8
    Top = 32
    Width = 75
    Height = 25
    Caption = 'btClearMouse'
    TabOrder = 3
    OnClick = btClearMouseClick
  end
end
