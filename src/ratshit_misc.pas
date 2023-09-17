unit ratshit_misc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TRatshitContentHash = string;

  //树状结构暂时不实现
  TRatshitHashNode = class
  private
    FItems : array [0..25] of TObject;
  public
    //property Items[index:integer]:TObject read
  end;

  TRatshitHashContentList = class
  private
    FItems : TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function AddContent(obj:TObject):TRatshitContentHash;
    function HasContent(hash:TRatshitContentHash):boolean;
    function GetContent(hash:TRatshitContentHash):TObject;
    function RemoveContent(hash:TRatshitContentHash):boolean;
    function UpdateContent(obj:TObject;hash:TRatshitContentHash):boolean;
  end;

const
  //获取新的内容ID失败时的返回值
  INVALID_CONTENT_HASH:TRatshitContentHash = '';

implementation


{ TRatshitHashContentList }
constructor TRatshitHashContentList.Create;
begin
  inherited Create;
  FItems:=TStringList.Create;
  FItems.Sorted:=true;
end;

destructor TRatshitHashContentList.Destroy;
begin
  while FItems.Count>0 do
  begin
    FItems.Objects[0].Free;
    FItems.Delete(0);
  end;
  inherited Destroy;
end;

function TRatshitHashContentList.AddContent(obj:TObject):TRatshitContentHash;
var random_id,random_id_init:int64;
    hash_str:string;
begin
  result:=INVALID_CONTENT_HASH;
  random_id:=random(maxLongint);
  random_id_init:=random_id;
  hash_str:=IntToHex(random_id,8);
  while HasContent(hash_str) do
  begin
    inc(random_id);
    if random_id_init = random_id then exit;
    if random_id>$ffffffff then random_id:=0;
    hash_str:=IntToHex(random_id,8);
  end;
  result:=hash_str;
end;

function TRatshitHashContentList.HasContent(hash:TRatshitContentHash):boolean;
var index:integer;
begin
  FItems.Find(hash,index);
  result:=not (index<0);
end;

function TRatshitHashContentList.GetContent(hash:TRatshitContentHash):TObject;
var index:integer;
begin
  FItems.Find(hash,index);
  if index<0 then result:=nil
  else result:=FItems.Objects[index];
end;

function TRatshitHashContentList.RemoveContent(hash:TRatshitContentHash):boolean;
var index:integer;
begin
  result:=false;
  FItems.Find(hash,index);
  if index<0 then exit;
  FItems.Objects[index].Free;
  FItems.Delete(index);
  result:=true;
end;

function TRatshitHashContentList.UpdateContent(obj:TObject;hash:TRatshitContentHash):boolean;
var index:integer;
begin
  result:=false;
  FItems.Find(hash,index);
  if index<0 then exit;
  FItems.Objects[index].Free;
  FItems.Objects[index]:=obj;
  result:=true;
end;


initialization
  Randomize;

end.

