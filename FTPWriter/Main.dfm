object FMain: TFMain
  Left = 191
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FTP writer'
  ClientHeight = 241
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PTools: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 30
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object BConnect: TSpeedButton
      Left = 4
      Top = 4
      Width = 148
      Height = 22
      Cursor = crHandPoint
      Hint = 'Подключиться к FTP-серверу'
      Caption = 'Установить связь'
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00222222222222
        2222222222222222222222220000222B322222222222222228F2222222222222
        00002222B332222222222222228FF22222222222000022222BB3222222222222
        22288F22222222220000222222BB322222222222222288F22222222200002222
        222BB332222222222222288FF2222222000022222222BBB32222222222222288
        8F2222220000222222222BBB322222222222222888F2222200002222222BBBBB
        B22222222222288888822222000022222BBBBBB2222222222228888882222222
        0000222222BBB322222222222222888F2222222200002222222BBB3222222222
        22222888F22222220000222222222BB322222222222222288F22222200002222
        222222BB322222222222222288F22222000022222222222BB322222222222222
        288F222200002222222222222B322222222222222228F2220000222222222222
        22B2222222222222222282220000222222222222222222222222222222222222
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BConnectClick
    end
    object BDisconnect: TSpeedButton
      Left = 296
      Top = 4
      Width = 137
      Height = 22
      Cursor = crHandPoint
      Hint = 'Отключиться от FTP-сервера'
      Caption = 'Прервать связь'
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00222222222222
        2222222222222222222222220000222B322222222222222228F2222222222222
        00002222B332222222222222228FF22222222222000022222BB3222222222222
        22288F22222222220000222291BB322229222222228F88F22228222200002222
        2991B3399122222222288F8FF88F22220000222222991B9912222222222288F8
        88F22222000022222229999132222222222228888FF2222200002222222B991B
        B222222222222888F8822222000022222BB9999122222222222888888F222222
        000022222299139912222222222288FF88F22222000022222991BB3991222222
        22288F88F88F22220000222229122BB3912222222228F2288F8F222200002222
        922222BB392222222282222288F82222000022222222222BB322222222222222
        288F222200002222222222222B322222222222222228F2220000222222222222
        22B2222222222222222282220000222222222222222222222222222222222222
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BDisconnectClick
    end
    object BWrite: TSpeedButton
      Left = 152
      Top = 4
      Width = 144
      Height = 22
      Cursor = crHandPoint
      Hint = 'Записать файлы из списка на FTP-сервер'
      Caption = 'Отправить файлы'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BWriteClick
    end
    object BClose: TSpeedButton
      Left = 441
      Top = 4
      Width = 100
      Height = 22
      Cursor = crHandPoint
      Hint = 'Завершить работу с программой'
      Caption = 'Закрыть'
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
        1111111111111111111111110000111111111111111111111111111111111111
        00001100111111111100111188F11111111188F1000011100111111110011111
        188F111111188F110000111100111111001111111188F1111188F11100001111
        100111100111111111188F11188F1111000011111100110011111111111188F1
        88F111110000111111100001111111111111188F8F1111110000111111110011
        1111111111111188F11111110000111111100001111111111111188F8F111111
        000011111100110011111111111188F188F11111000011111001111001111111
        11188F11188F11110000111100111111001111111188F1111188F11100001110
        0111111110011111188F111111188F1100001100111111111100111188F11111
        111188F100001111111111111111111111111111111111110000111111111111
        1111111111111111111111110000111111111111111111111111111111111111
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BCloseClick
    end
    object Bvl1: TBevel
      Left = 436
      Top = 2
      Width = 2
      Height = 26
      Style = bsRaised
    end
  end
  object SBStatus: TStatusBar
    Left = 0
    Top = 222
    Width = 545
    Height = 19
    Panels = <
      item
        Width = 200
      end>
    SimplePanel = False
  end
  object PCPages: TPageControl
    Left = 0
    Top = 30
    Width = 545
    Height = 192
    ActivePage = TSWriting
    Align = alClient
    TabOrder = 2
    TabStop = False
    object TSConnection: TTabSheet
      TabVisible = False
      object LUserName: TLabel
        Left = 8
        Top = 80
        Width = 99
        Height = 13
        Caption = 'Имя пользователя:'
      end
      object LPassword: TLabel
        Left = 8
        Top = 104
        Width = 41
        Height = 13
        Caption = 'Пароль:'
      end
      object LHostName: TLabel
        Left = 8
        Top = 8
        Width = 93
        Height = 13
        Caption = 'Имя FTP-сервера:'
      end
      object Bvl2: TBevel
        Left = 0
        Top = 60
        Width = 537
        Height = 2
      end
      object LPort: TLabel
        Left = 8
        Top = 32
        Width = 28
        Height = 13
        Caption = 'Порт:'
      end
      object EUserName: TEdit
        Left = 112
        Top = 76
        Width = 121
        Height = 21
        Hint = 'Введите зарегистрированное на сервере имя пользователя'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object EPassword: TEdit
        Left = 112
        Top = 100
        Width = 121
        Height = 21
        Hint = 'Введите пароль'
        ParentShowHint = False
        PasswordChar = '*'
        ShowHint = True
        TabOrder = 0
      end
      object EHostName: TEdit
        Left = 112
        Top = 4
        Width = 181
        Height = 21
        Hint = 'Введите имя сервера'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object EPort: TEdit
        Left = 112
        Top = 28
        Width = 121
        Height = 21
        Hint = 'Введите номер порта на FTP-сервере'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
    object TSWriting: TTabSheet
      Caption = 'TSWriting'
      ImageIndex = 1
      TabVisible = False
      object LWFiles: TListView
        Left = 0
        Top = 0
        Width = 537
        Height = 152
        Hint = 'Список файлов для отправки на FTP-сервер'
        Align = alClient
        Columns = <
          item
            Caption = 'Имя файла'
            Width = 269
          end
          item
            Alignment = taRightJustify
            Caption = 'Размер'
            Width = 65
          end
          item
            Caption = 'Назначение'
            Width = 199
          end>
        GridLines = True
        HotTrack = True
        HotTrackStyles = [htUnderlineHot]
        HoverTime = 1000
        ReadOnly = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnSelectItem = LWFilesSelectItem
      end
      object PCommands: TPanel
        Left = 0
        Top = 152
        Width = 537
        Height = 30
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object BAddFile: TSpeedButton
          Left = 4
          Top = 4
          Width = 177
          Height = 22
          Cursor = crHandPoint
          Hint = 'Добавить файл в список'
          Caption = 'Добавить файл'
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
        object BDelFile: TSpeedButton
          Left = 181
          Top = 4
          Width = 172
          Height = 22
          Cursor = crHandPoint
          Hint = 'Удалить файл из списка'
          Caption = 'Удалить файл'
          Enabled = False
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
        object BPropFile: TSpeedButton
          Left = 361
          Top = 4
          Width = 172
          Height = 22
          Cursor = crHandPoint
          Hint = 'Просмотр свойств файла'
          Caption = ' Свойства '
          Enabled = False
          Flat = True
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            04000000000068010000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333FFFFFFFFFFF333330000300000000000033333388888888888833333
            000030FFFFFFFFFF03333338F333333333833333000030FFFFFFFFFC43333338
            F333333338F33333000030F00000000F03333338F888888883833333000030FF
            FFFFFFFC43333338F333333338F33333000030F00000000C43333338F8888888
            88F33333000030FFFFFFFFFC43333338F333333338F33333000030F00000000F
            C4333338F8888888838F3333000030FFFFFFFC4F0C433338F3333338F388F333
            000030F00000C40F0C433338F888888F8388F333000030FFFFFFC4444C433338
            F333338FFFF8F333000030FFFF000CCCC3333338FFF38888888F333300003000
            0FFFFFFF03333338888F3333338F33330000330F0F00000F033333338F8F8888
            838F3333000033300FFFFFFF03333333388FFFFFFF8F33330000333300000000
            0333333333888888888333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BPropFileClick
        end
        object Bevel1: TBevel
          Left = 356
          Top = 2
          Width = 2
          Height = 26
          Style = bsRaised
        end
      end
    end
    object TSNone: TTabSheet
      Caption = 'TSNone'
      ImageIndex = 2
      TabVisible = False
    end
  end
  object FTP: TNMFTP
    Port = 21
    TimeOut = 5000
    ReportLevel = 0
    Vendor = 2411
    ParseList = True
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 516
    Top = 212
  end
  object RxGradientCaption1: TRxGradientCaption
    Captions = <>
    FormCaption = 'FTP writer'
    StartColor = clBlack
    Left = 488
    Top = 212
  end
end
