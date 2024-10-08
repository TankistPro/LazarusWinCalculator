unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, BCButton, fpexprpars;

type

  { TForm1 }

  TForm1 = class(TForm)
    BCButton1: TBCButton;
    BCButton10: TBCButton;
    BCButton11: TBCButton;
    BCButton12: TBCButton;
    BCButton13: TBCButton;
    BCButton14: TBCButton;
    BCButton15: TBCButton;
    BCButton16: TBCButton;
    BCButton17: TBCButton;
    BCButton18: TBCButton;
    BCButton19: TBCButton;
    BCButton2: TBCButton;
    BCButton20: TBCButton;
    BCButton3: TBCButton;
    BCButton4: TBCButton;
    BCButton5: TBCButton;
    BCButton6: TBCButton;
    BCButton7: TBCButton;
    BCButton8: TBCButton;
    BCButton9: TBCButton;
    InputForm: TEdit;
    InputExpression: TEdit;
    procedure AddPoint(Sender: TObject);
    procedure ClearCalculator(Sender: TObject);
    procedure ClearInputForm(Sender: TObject);
    procedure ExpressOperation(Sender: TObject);
    procedure ExpressResult(Sender: TObject);
    procedure InputFormChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InputNumber(Sender: TObject);
    procedure TransformSign(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  isReasultValue: boolean;
implementation
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    isReasultValue := False;
end;

procedure TForm1.InputFormChange(Sender: TObject);
begin

end;

procedure TForm1.ClearCalculator(Sender: TObject);
begin
   InputForm.Text := '0';
   InputExpression.Text := '';
   isReasultValue := False;
end;

procedure TForm1.ClearInputForm(Sender: TObject);
begin
    InputForm.Text := '0';
end;

procedure TForm1.AddPoint(Sender: TObject);
begin
    if Not(pos('.', InputForm.Text) = 0) then Exit();

    InputForm.Text := InputForm.Text + '.';
end;

procedure TForm1.ExpressOperation(Sender: TObject);
var
  operation: String;
begin
     operation := (Sender as TBCButton).Caption;
     if operation = 'x' then operation := '*'
        else if operation = '÷' then operation := '/';

     if(isReasultValue = True) then begin
        InputExpression.Text := InputForm.Text + operation;;
        isReasultValue := False;
     end
     else begin
       InputExpression.Text := InputExpression.Text + InputForm.Text + operation;
     end;

    InputForm.Text := '0';
end;

procedure TForm1.ExpressResult(Sender: TObject);
var
  FParser: TFPExpressionParser;
  resultValue: Double;
  parserResult: TFPExpressionResult;
begin
     if(isReasultValue = True) then Exit();

     isReasultValue := True;
     FParser := TFpExpressionParser.Create(nil);
     try
        FParser.Expression := (InputExpression.Text + InputForm.Text);
        parserResult := FParser.Evaluate;
        resultValue := ArgToFloat(parserResult);

        InputExpression.Text := InputExpression.Text + InputForm.Text + (Sender as TBCButton).Caption;
        InputForm.Text := FloatToStr(resultValue);
     finally
       FParser.Free;
     end;

end;

procedure TForm1.InputNumber(Sender: TObject);
begin
  if InputForm.Text = '0' then
     InputForm.Text := (Sender as TBCButton).Caption
  else InputForm.Text := InputForm.Text + (Sender as TBCButton).Caption;
end;

procedure TForm1.TransformSign(Sender: TObject);
var
  isNegativValue: Boolean;
  NegativSignIndex: Integer;
begin
  isNegativValue:= Not(pos('-', InputForm.Text) = 0);

  if (Not(isNegativValue)) then InputForm.Text := '-' + InputForm.Text;
end;

end.

