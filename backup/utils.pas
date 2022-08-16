unit Utils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ShlObj, StdCtrls;

  procedure AddAllFilesInDir(const Dir: string; const TargetListBox: TListBox);
  function GetSpecialFolder(const CSIDL: integer) : string;

implementation

procedure AddAllFilesInDir(const Dir: string; const TargetListBox: TListBox);
var
    SR: TSearchRec;
begin
  if FindFirst(IncludeTrailingBackslash(Dir) + '*.*', faAnyFile or faDirectory, SR) = 0 then
    try
      repeat
        if (SR.Attr and faDirectory) = 0 then
          begin
            TargetListBox.Items.Add(SR.Name);
//Application.ProcessMessages;
          end
        else if (SR.Name <> '.') and (SR.Name <> '..') then
          AddAllFilesInDir(IncludeTrailingBackslash(Dir) + SR.Name);  // recursive call!
      until FindNext(Sr) <> 0;
    finally
      FindClose(SR);
    end;
end;

function GetSpecialFolder(const CSIDL: integer): string;
var
    RecPath : PWideChar;
begin
    result := '';
    RecPath := WideStrAlloc(MAX_PATH);
    try
      FillChar(RecPath^, MAX_PATH, 0);
      if SHGetFolderPathW(0, CSIDL, 0, 0, RecPath) = 0 then result := RecPath;
    finally
      StrDispose(RecPath);
    end;
end;




end.

