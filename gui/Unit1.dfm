object Form1: TForm1
  Left = 559
  Top = 306
  Caption = 'MS Word documents encoding converter (armscii-8 to UTF-8)'
  ClientHeight = 311
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 40
    Width = 297
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 336
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 16
    Top = 88
    Width = 297
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object Button2: TButton
    Left = 336
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 336
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Convert!'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 128
    Width = 305
    Height = 169
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object CheckBox1: TCheckBox
    Left = 160
    Top = 16
    Width = 249
    Height = 17
    Caption = 'Convert all documents in directory (recoursive)'
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.doc'
    Filter = 'MS Office Documents|*.doc; '
    Left = 24
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.doc'
    Left = 64
    Top = 8
  end
end
