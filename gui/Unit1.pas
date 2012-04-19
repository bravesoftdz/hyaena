unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI, ShlObj;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function BrowseFolder{(Sender: TObject)} : string;
var
  TitleName : string;
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := Form1.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := 'Please specify a directory';
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <>  nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    //ShowMessage(TempPath);
    result := TempPath;
    GlobalFreePtr(lpItemID);
  end;
end;



procedure TForm1.Button1Click(Sender: TObject);
var  s : string;
begin
if CheckBox1.Checked = false then begin
OpenDialog1.Filter := 'ms word files|*.doc;*.docx';
if OpenDialog1.Execute then begin
    Edit1.Text := OpenDialog1.FileName;
end;
end;
if checkbox1.Checked then begin
s := BrowseFolder;
Edit1.Text := s;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if edit1.Text = '' then begin ShowMessage ('You did not choose file to open') end else begin
SaveDialog1.DefaultExt := SysUtils.ExtractFileExt(Edit1.Text);
if SaveDialog1.Execute then begin
if SaveDialog1.FileName = OpenDialog1.FileName then begin
        ShowMessage ('Same file!');
        edit2.text := ''
        end
       else
        begin
        Edit2.Text := SaveDialog1.FileName
        end;
end;
end;
end;

procedure RunDosInMemo(CmdLine:String;AMemo:TMemo);       overload;
 const
   ReadBuffer = 2400;
 var
  Security       : TSecurityAttributes;
  ReadPipe,WritePipe  : THandle;
  start        : TStartUpInfo;
  ProcessInfo     : TProcessInformation;
  Buffer        : PAnsichar;
  BytesRead      : DWord;
  Apprunning      : DWord;
  ok : boolean;
 begin
  Screen.Cursor:=CrHourGlass;
  Form1.Button1.Enabled:=False;
  With Security do begin
  nlength        := SizeOf(TSecurityAttributes);
  binherithandle    := true;
  lpsecuritydescriptor := nil;
  end;
  if Createpipe (ReadPipe, WritePipe,
         @Security, 0) then begin
  Buffer  := AllocMem(ReadBuffer + 1);
  FillChar(Start,Sizeof(Start),#0);
  start.cb      := SizeOf(start);
  start.hStdOutput  := WritePipe;
  start.hStdInput  := ReadPipe;
  start.dwFlags   := STARTF_USESTDHANDLES +
             STARTF_USESHOWWINDOW;
  start.wShowWindow := SW_HIDE;

  if CreateProcess(nil,
      PChar(CmdLine),
      @Security,
      @Security,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo)
  then
  begin
   ok := false;
   repeat
   Apprunning := WaitForSingleObject
          (ProcessInfo.hProcess,100);
if not ok then    ReadFile(ReadPipe,Buffer[0],
       ReadBuffer,BytesRead,nil);
    Buffer[BytesRead]:= #0;
    OemToAnsi(Buffer,Buffer);
    if not ok then begin
    AMemo.Text := AMemo.text + String(Buffer);
        AMemo.Perform(WM_VScroll, SB_BOTTOM,0);
    end;

   Application.ProcessMessages;
   ok := true;
   until (Apprunning <> WAIT_TIMEOUT);
  end;
  FreeMem(Buffer);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ReadPipe);
  CloseHandle(WritePipe);
  end;
  Screen.Cursor:=CrDefault;
  Form1.Button1.Enabled:=True;
 end;


procedure RunDosInMemo(cmd, arguments:String;AMemo:TMemo); overload;
 const
   ReadBuffer = 2400;
 var
  Security       : TSecurityAttributes;
  ReadPipe,WritePipe  : THandle;
  start        : TStartUpInfo;
  ProcessInfo     : TProcessInformation;
  Buffer        : PAnsichar;
  BytesRead      : DWord;
  Apprunning      : DWord;
  ok : boolean;
 begin
  Screen.Cursor:=CrHourGlass;
  Form1.Button1.Enabled:=False;
  With Security do begin
  nlength        := SizeOf(TSecurityAttributes);
  binherithandle    := true;
  lpsecuritydescriptor := nil;
  end;
  if Createpipe (ReadPipe, WritePipe,
         @Security, 0) then begin
  Buffer  := AllocMem(ReadBuffer + 1);
  FillChar(Start,Sizeof(Start),#0);
  start.cb      := SizeOf(start);
  start.hStdOutput  := WritePipe;
  start.hStdInput  := ReadPipe;
  start.dwFlags   := STARTF_USESTDHANDLES +
             STARTF_USESHOWWINDOW;
  start.wShowWindow := SW_HIDE;

  if CreateProcess(PChar(cmd),
      PChar(arguments),
      @Security,
      @Security,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo)
  then
  begin
   ok := false;
   repeat
   Apprunning := WaitForSingleObject
          (ProcessInfo.hProcess,100);
if not ok then    ReadFile(ReadPipe,Buffer[0],
       ReadBuffer,BytesRead,nil);
    Buffer[BytesRead]:= #0;
    OemToAnsi(Buffer,Buffer);
    if not ok then begin
    AMemo.Text := AMemo.text + String(Buffer);
        AMemo.Perform(WM_VScroll, SB_BOTTOM,0);
    end;

   Application.ProcessMessages;
   ok := true;
   until (Apprunning <> WAIT_TIMEOUT);
  end;
  FreeMem(Buffer);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ReadPipe);
  CloseHandle(WritePipe);
  end;
  Screen.Cursor:=CrDefault;
  Form1.Button1.Enabled:=True;
 end;


procedure TForm1.BitBtn1Click(Sender: TObject);
var p : string;

Procedure ScanDir(Dir:string);
var SearchRec:TSearchRec;
strlist : TStringList;
begin
 if Dir<>'' then if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
 if FindFirst(Dir+'*.*', faAnyFile, SearchRec)=0 then
 repeat
 if (SearchRec.name='.') or (SearchRec.name='..') then continue;
 if (SearchRec.Attr and faDirectory)<>0 then
 ScanDir(Dir+SearchRec.name) //we found Directory: "Dir+SearchRec.name"
else
 //Showmessage(Dir+SearchRec.name); //we found File: "Dir+SearchRec.name"
 if (SysUtils.ExtractFileExt(SearchRec.name) = '.doc') or
     (SysUtils.ExtractFileExt(SearchRec.name) = '.docx')  then begin
 Memo1.Lines.Add('Found word document ' + Dir + SearchRec.Name );
//strlist := tstringlist.Create;

//RunDosInMemo ('armdocconv.exe', '"' + Dir + SearchRec.Name + '"', Form1.Memo1);
 RunDosInMemo ('armdocconv.exe ' + '"' +  Dir + SearchRec.Name + '"', Form1.Memo1 );


 //  RunDosInMemo ('armdocconv.exe ' + Dir + SearchRec.Name, strlist);
// Memo1.Lines.AddStrings(strlist);
// strlist.free;
 end;

 until FindNext(SearchRec)<>0;
 FindClose(SearchRec);
end;

begin
if CheckBox1.Checked = false then begin
p:= 'armdocconv.exe -o ' + '"' + OpenDialog1.FileName + '"' + ' -n ' + '"' + SaveDialog1.FileName + '"';
RunDosInMemo (p, Memo1);
end;
if CheckBox1.Checked = true then begin
ScanDir (Edit1.Text);
end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked then Button2.Enabled := false else button2.Enabled := True;
end;

end.
