object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 553
  ClientWidth = 782
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 553
    Align = alClient
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 10.881984996411560000
      end
      item
        Value = 10.881984856242850000
      end
      item
        Value = 10.881984773336770000
      end
      item
        Value = 10.881984766339490000
      end
      item
        Value = 10.881984813881410000
      end
      item
        Value = 10.881984876591030000
      end
      item
        Value = 10.881984922065940000
      end
      item
        Value = 10.881984936770500000
      end
      item
        Value = 10.881984924728420000
      end
      item
        Value = 2.062136133632033000
      end>
    ControlCollection = <
      item
        Column = 3
        ColumnSpan = 6
        Control = Memo1
        Row = 1
        RowSpan = 8
      end
      item
        Column = 0
        ColumnSpan = 3
        Control = SpeedButton1
        Row = 3
      end
      item
        Column = 0
        Control = SpeedButton2
        Row = 4
      end
      item
        Column = 0
        ColumnSpan = 3
        Control = SpeedButton3
        Row = 7
      end
      item
        Column = 0
        ColumnSpan = 3
        Control = SpeedButton4
        Row = 8
      end
      item
        Column = 3
        ColumnSpan = 6
        Control = Label1
        Row = 9
      end
      item
        Column = 2
        Control = SpeedButton5
        Row = 4
      end
      item
        Column = 1
        Control = SpeedButton6
        Row = 4
      end
      item
        Column = 0
        ColumnSpan = 2
        Control = INPUT_TF
        Row = 1
      end
      item
        Column = 2
        Control = SpeedButton7
        Row = 1
      end
      item
        Column = 2
        Control = SpeedButton8
        Row = 2
      end>
    RowCollection = <
      item
        Value = 2.972087851141588000
      end
      item
        Value = 10.780879127650930000
      end
      item
        Value = 10.780879127650930000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end
      item
        Value = 10.780879127650940000
      end>
    TabOrder = 0
    object Memo1: TMemo
      Left = 253
      Top = 17
      Width = 504
      Height = 472
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 145
      Width = 232
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'SEARCH'
      OnClick = SpeedButton1Click
      ExplicitLeft = 416
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object SpeedButton2: TSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 204
      Width = 64
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'DELETE'
      OnClick = SpeedButton2Click
      ExplicitLeft = 35
      ExplicitTop = 148
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object SpeedButton3: TSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 381
      Width = 232
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'SORT BY ABC'
      OnClick = SpeedButton3Click
      ExplicitLeft = 416
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object SpeedButton4: TSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 440
      Width = 232
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'RESET'
      OnClick = SpeedButton4Click
      ExplicitLeft = 416
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 256
      Top = 499
      Width = 45
      Height = 50
      Margins.Top = 10
      Align = alLeft
      Caption = 'ROOT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 21
    end
    object SpeedButton5: TSpeedButton
      AlignWithMargins = True
      Left = 179
      Top = 204
      Width = 64
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'ADD'
      OnClick = SpeedButton5Click
      ExplicitLeft = 384
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object SpeedButton6: TSpeedButton
      AlignWithMargins = True
      Left = 95
      Top = 204
      Width = 64
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'EDIT'
      OnClick = SpeedButton6Click
      ExplicitLeft = 384
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object INPUT_TF: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 27
      Width = 148
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Lines.Strings = (
        'INPUT_TF')
      TabOrder = 1
    end
    object SpeedButton7: TSpeedButton
      AlignWithMargins = True
      Left = 179
      Top = 27
      Width = 64
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'MOVE TO'
      OnClick = SpeedButton7Click
      ExplicitLeft = 384
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object SpeedButton8: TSpeedButton
      AlignWithMargins = True
      Left = 179
      Top = 86
      Width = 64
      Height = 39
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'MOVE IN'
      OnClick = SpeedButton8Click
      ExplicitLeft = 384
      ExplicitTop = 264
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
end
