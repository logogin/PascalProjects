unit MadCtrls;
interface
uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics;

type
  TMadButton = class (TGraphicControl)
  private
    FMouseInControl : Boolean;
    FBeginColor : TColor;
    FEndColor : TColor;
    FColor : TColor;
    FBorderWidth : Integer;
    procedure CMMouseEnter (var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged (var Msg : TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged (var Msg : TMessage); message CM_FONTCHANGED;
    procedure SetBeginColor (Value : TColor);
    procedure SetEndColor (Value : TColor);
    procedure SetColor (Value : TColor);
    procedure SetBorderWidth (Value : Integer);
  protected
    procedure Paint; override;
    procedure MouseDown (Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure MouseMove (Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp (Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
  public
    constructor Create (AOwner : TComponent); override;
    procedure Click; override;
  published
    property Caption;
    property ParentShowHint;
    property ShowHint;
    property BeginColor : TColor read FBeginColor write SetBeginColor;
    property EndColor : TColor read FEndColor write SetEndColor;
    property BorderWidth : Integer read FBorderWidth write SetBorderWidth;
    property Visible;
    property Font;
    property Enabled;
    property Color read FColor write SetColor;
    property OnClick;
  end;

procedure Register;

implementation
type
  TRGB = record
    Red, Green, Blue : Byte;
    Align : Byte;
  end;

constructor TMadButton.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  FMouseInControl := False;
  FBeginColor := clBtnFace;
  FEndColor := clWhite;
  FColor := clGray;
  Font.Color := clBlack;
  FBorderWidth := 6;
  Width := 80;
  Height := 30;
  Canvas.Pen.Mode := pmCopy;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;
end;

procedure TMadButton.CMMouseEnter;
begin
  inherited;
  if Enabled and not FMouseInControl then begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

procedure TMadButton.CMMouseLeave;
begin
  inherited;
  if Enabled and FMouseInControl then begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

procedure TMadButton.CMTextChanged;
begin
  Invalidate;
end;

procedure TMadButton.CMFontChanged;
begin
  Invalidate;
end;

procedure TMadButton.MouseDown (Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
end;

procedure TMadButton.MouseMove (Shift : TShiftState; X, Y : Integer);
begin
  inherited MouseMove (Shift, X, Y);
end;

procedure TMadButton.MouseUp (Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
end;

procedure TMadButton.Click;
begin
  inherited Click;
end;

procedure TMadButton.SetBeginColor;
begin
  if FBeginColor <> Value then begin
    FBeginColor := Value;
    Invalidate;
  end;
end;

procedure TMadButton.SetEndColor;
begin
  if FEndColor <> Value then begin
    FEndColor := Value;
    Invalidate;
  end;
end;

procedure TMadButton.SetColor;
begin
  if FColor <> Value then begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TMadButton.SetBorderWidth;
begin
  if FBorderWidth <> Value then begin
    FBorderWidth := Value;
    Invalidate;
  end;
end;

procedure TMadButton.Paint;
var
  BC : TColor;
  I : Integer;
  RDisp, GDisp, BDisp : ShortInt;
  R : TRect;
begin
  Canvas.Font := Font;
  BC := FBeginColor;
  RDisp := Integer (TRGB (FEndColor).Red - TRGB (FBeginColor).Red) div FBorderWidth;
  GDisp := Integer (TRGB (FEndColor).Green - TRGB (FBeginColor).Green) div FBorderWidth;
  BDisp := Integer (TRGB (FEndColor).Blue - TRGB (FBeginColor).Blue) div FBorderWidth;
  with Canvas do begin
    Pen.Color := FColor;
    Canvas.Brush.Style := bsSolid;
    Rectangle (FBorderWidth, FBorderWidth, Width - FBorderWidth, Height - FBorderWidth);
    Pen.Color := FColor;
    Canvas.Brush.Style := bsClear;
    Rectangle (FBorderWidth, FBorderWidth, Width - FBorderWidth, Height - FBorderWidth);
    Pen.Color := FColor;
    Canvas.Brush.Style := bsSolid;
    R.Top := FBorderWidth + 1; R.Left := FBorderWidth + 1;
    R.Bottom := Height - FBorderWidth - 1; R.Right := Width - FBorderWidth - 1;
{    TextRect (R, Width div 2 - TextWidth (Caption) div 2,
      Height div 2 - TextHeight (Caption) div 2, Caption);}
    DrawText(Handle, PChar (Caption), Length (Caption), R,
      DT_CENTER or DT_VCENTER);
    Canvas.Brush.Style := bsClear;
    for I := 0 to FBorderWidth - 1 do begin
      Inc (TRGB (BC).Red, RDisp);
      Inc (TRGB (BC).Green, GDisp);
      Inc (TRGB (BC).Blue, BDisp);
      Pen.Color := BC;
      Rectangle (I, I, Width - I, Height - I);
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents ('MadControls', [TMadButton]);
end;

end.
