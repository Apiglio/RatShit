unit ratshit_document;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

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
  end;

  //文档内容基类
  TRatshitContent = class
    Blame : TRatshitUser;
    Renew : TRatshitTime;
    Style : TRatshitStyle;
  end;
  //文档文字内容
  TRatshitText = class(TRatshitContent)

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
    FContents : TList;

  end;

implementation

end.

