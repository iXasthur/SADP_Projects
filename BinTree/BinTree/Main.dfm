object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 563
  ClientWidth = 1029
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
  object DirectSearchLabel: TLabel
    Left = 135
    Top = 441
    Width = 12
    Height = 13
    Caption = '---'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SymmetricalSearch: TLabel
    Left = 135
    Top = 472
    Width = 12
    Height = 13
    Caption = '---'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ReversedSearch: TLabel
    Left = 135
    Top = 503
    Width = 12
    Height = 13
    Caption = '---'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DrawPic: TImage
    Left = 8
    Top = 8
    Width = 1013
    Height = 422
  end
  object DirectSearchButton: TButton
    Left = 8
    Top = 436
    Width = 121
    Height = 25
    Caption = #1055#1088#1103#1084#1086#1081' '#1086#1073#1093#1086#1076': '
    TabOrder = 0
    OnClick = DirectSearchButtonClick
  end
  object SymmetricSearchButton: TButton
    Left = 8
    Top = 467
    Width = 121
    Height = 25
    Caption = #1057#1080#1084#1084#1077#1090#1088#1080#1095#1085#1099#1081' '#1086#1073#1093#1086#1076':'
    TabOrder = 1
    OnClick = SymmetricSearchButtonClick
  end
  object RevercedSearchButton: TButton
    Left = 8
    Top = 498
    Width = 121
    Height = 25
    Caption = #1050#1086#1085#1094#1077#1074#1086#1081' '#1086#1073#1093#1086#1076':'
    TabOrder = 2
    OnClick = RevercedSearchButtonClick
  end
  object RemoveButton: TButton
    Left = 8
    Top = 529
    Width = 121
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 3
    OnClick = RemoveButtonClick
  end
  object RemoveField: TEdit
    Left = 135
    Top = 529
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
