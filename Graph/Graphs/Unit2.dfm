object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'GraphMetrix'
  ClientHeight = 297
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GraphTable: TStringGrid
    Left = 8
    Top = 8
    Width = 401
    Height = 177
    ColCount = 7
    DefaultColWidth = 55
    RowCount = 7
    TabOrder = 0
  end
  object StartPointText: TStaticText
    Left = 8
    Top = 207
    Width = 99
    Height = 17
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1090#1086#1095#1082#1072': '
    TabOrder = 1
  end
  object StartPointEdit: TEdit
    Left = 104
    Top = 203
    Width = 97
    Height = 21
    TabOrder = 2
  end
  object EndPointText: TStaticText
    Left = 207
    Top = 207
    Width = 93
    Height = 17
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1090#1086#1095#1082#1072': '
    TabOrder = 3
  end
  object EndPointEdit: TEdit
    Left = 296
    Top = 203
    Width = 106
    Height = 21
    TabOrder = 4
  end
  object CountButton: TButton
    Left = 8
    Top = 230
    Width = 394
    Height = 25
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
    TabOrder = 5
    OnClick = CountButtonClick
  end
  object GenerateGraphButton: TButton
    Left = 8
    Top = 261
    Width = 394
    Height = 25
    Caption = #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1075#1088#1072#1092
    TabOrder = 6
    OnClick = GenerateGraphButtonClick
  end
  object RoutesTable: TValueListEditor
    Left = 415
    Top = 8
    Width = 407
    Height = 177
    TabOrder = 7
    TitleCaptions.Strings = (
      #1044#1083#1080#1085#1072
      #1055#1091#1090#1100)
    ColWidths = (
      40
      361)
  end
  object ShortestWayText: TStaticText
    Left = 424
    Top = 203
    Width = 98
    Height = 17
    Caption = #1050#1088#1072#1090#1095#1072#1081#1096#1080#1081' '#1087#1091#1090#1100':'
    TabOrder = 8
  end
  object LongestWayText: TStaticText
    Left = 424
    Top = 226
    Width = 99
    Height = 17
    Caption = #1044#1083#1080#1085#1085#1077#1081#1096#1080#1081' '#1087#1091#1090#1100':'
    TabOrder = 9
  end
  object GraphCenterText: TStaticText
    Left = 424
    Top = 249
    Width = 74
    Height = 17
    Caption = #1062#1077#1085#1090#1088' '#1075#1088#1072#1092#1072':'
    TabOrder = 10
  end
end
