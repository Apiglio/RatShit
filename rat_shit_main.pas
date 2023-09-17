unit rat_shit_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ratshit_document, ratshit_misc;

type

  { TFormRatShit }

  TFormRatShit = class(TForm)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormRatShit: TFormRatShit;
  RatshitDocument:TRatshitDocument;

implementation
uses ratshit_edit;

{$R *.lfm}

{ TFormRatShit }

procedure TFormRatShit.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  RatshitDocument.Free;
end;

procedure TFormRatShit.FormCreate(Sender: TObject);
var RatshitEdit:TRatshitEdit;
begin
  RatshitDocument:=TRatshitDocument.Create;
  RatshitEdit:=TRatshitEdit.Create(Self);
  RatshitEdit.Parent:=Self;
  RatshitEdit.Align:=alClient;
  RatshitEdit.Assign(RatshitDocument);
end;

end.

