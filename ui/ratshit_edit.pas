unit ratshit_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls,
  ratshit_document;

type
  TCustomRatshitEdit = class(TCustomPanel)
  private
    FDocument:TRatshitDocument;
  public
    procedure Assign(ADocument:TRatshitDocument);
    property Document:TRatshitDocument read FDocument;
  protected
    procedure Paint; override;
  end;

  TRatshitEdit = class(TCustomRatshitEdit)
  end;

implementation
uses Graphics;

{ TCustomRatshitEdit }

procedure TCustomRatshitEdit.Assign(ADocument:TRatshitDocument);
begin
  FDocument:=ADocument;
  Paint;
end;

procedure TCustomRatshitEdit.Paint;
var pi:integer;
    content:TRatshitContent;
begin
  Canvas.Brush.Color:=clWhite;
  Canvas.Clear;
  pi:=0;
  while pi<FDocument.Contents.Count do
  begin
    content:=FDocument.Contents[pi];
    case content.ClassName of
      'TRatshitText':Canvas.TextOut(0,0,TRatshitText(content).Text);
    end;
    inc(pi);
  end;
end;

end.

