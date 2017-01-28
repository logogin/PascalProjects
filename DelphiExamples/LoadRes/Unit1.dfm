object Form1: TForm1
  Left = 245
  Top = 107
  Width = 177
  Height = 96
  Caption = 'Icon Graber'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ImageViewer: TImage
    Left = 8
    Top = 8
    Width = 73
    Height = 57
  end
  object Button1: TButton
    Left = 88
    Top = 8
    Width = 81
    Height = 57
    Caption = 'Load Program'
    TabOrder = 0
    OnClick = Button1Click
  end
  object FileOpenDialog: TOpenDialog
    Left = 40
    Top = 16
  end
end
