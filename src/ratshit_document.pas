unit ratshit_document;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  ratshit_misc;

type

  //文档责任用户
  TRatshitUser = class
    UserName : string;
  end;
  //文档修改时间
  TRatshitTime = class
    DateTime : TDateTime;
  end;
  //文档内容样式
  TRatshitStyle = class
    StyleName : string;
    Font:TFont;

  end;

  TRatshitContent = class;

  //文档内容列表
  TRatshitContents  = class
  private
    FContents:TList;
  protected
    function GetContent(index:integer):TRatshitContent;
    function GetContentCount:integer;
  public
    property Contents[index:integer]:TRatshitContent read GetContent; default;
    property Count:integer read GetContentCount;
  public
    procedure AppendContent(content:TRatshitContent);
    procedure InsertContent(index:integer;content:TRatshitContent);
    procedure RemoveContent(index:integer);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  //文档内容基类
  TRatshitContent = class
    Blame : TRatshitUser;
    Renew : TRatshitTime;
    Style : TRatshitStyle;
    Hash  : TRatshitContentHash;
  end;
  //文档文字内容
  TRatshitText = class(TRatshitContent)
    Text:string;
  end;
  //文档图片内容
  TRatshitPicture = class(TRatshitContent)

  end;
  //文档表格内容
  TRatshitTable = class(TRatshitContent)

  end;
  //文档公式内容
  TRatshitFormula = class(TRatshitContent)

  end;
  //文档注释内容
  TRatshitNote = class(TRatshitContent)

  end;



  //文档定义
  TRatshitDocument = class
  //磁盘访问部分
  private
    FDocumentPath : string; //文档暂存盘路径
  public
    property DocumentPath : string read FDocumentPath write FDocumentPath;

  //文档内容部分
  private
    FContents : TRatshitContents;
    FStyles   : TRatshitHashContentList;
    FUsers    : TRatshitHashContentList;
    FPictures : TRatshitHashContentList;
    FTables   : TRatshitHashContentList;
    FFormulas : TRatshitHashContentList;
    FNotes    : TRatshitHashContentList;
  public
    property Contents:TRatshitContents read FContents;

  //构造与析构
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRatshitContents }

function TRatshitContents.GetContent(index:integer):TRatshitContent;
begin
  result:=TRatshitContent(FContents[index]);
end;

function TRatshitContents.GetContentCount:integer;
begin
  result:=FContents.Count;
end;

procedure TRatshitContents.AppendContent(content:TRatshitContent);
begin
  FContents.Add(content);
end;

procedure TRatshitContents.InsertContent(index:integer;content:TRatshitContent);
begin
  FContents.Insert(index,content);
end;

procedure TRatshitContents.RemoveContent(index:integer);
begin
  FContents.Delete(index);
end;

constructor TRatshitContents.Create;
begin
  inherited Create;
  FContents:=TList.Create;
end;

destructor TRatshitContents.Destroy;
begin
  while FContents.Count>0 do
  begin
    TRatshitContent(FContents[0]).Free;
    FContents.Delete(0);
  end;
  inherited Destroy;
end;



{ TRatshitDocument }

constructor TRatshitDocument.Create;
var init_text:TRatshitText;
begin
  inherited Create;
  FContents := TRatshitContents.Create;
  FStyles   := TRatshitHashContentList.Create;
  FUsers    := TRatshitHashContentList.Create;
  FPictures := TRatshitHashContentList.Create;
  FTables   := TRatshitHashContentList.Create;
  FFormulas := TRatshitHashContentList.Create;
  FNotes    := TRatshitHashContentList.Create;

  init_text:=TRatshitText.Create;
  init_text.Blame:=nil;
  init_text.Style:=nil;
  init_text.Renew:=nil;
  //init_text.Text:='';
  init_text.Text:='123123123.';
  FContents.AppendContent(init_text);
end;

destructor TRatshitDocument.Destroy;
begin
  FContents.Free;
  FStyles.Free;
  FUsers.Free;
  FPictures.Free;
  FTables.Free;
  FFormulas.Free;
  FNotes.Free;
  inherited Destroy;
end;



end.

