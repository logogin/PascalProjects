(*==========================================================================;
 *
 *  Copyright (C) 1996-1999 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dinput.h
 *  Content:    DirectInput include file
 *
 *  DirectX 7.0 Delphi adaptation by Erik Unger, input format
 *  variable structure & other fixups by Arne SchРґpers (as)
 *
 *  Modified: 04-Jan-2000
 *
 *  Download: http://www.delphi-jedi.org/DelphiGraphics/
 *  E-Mail: Erik.Unger@gmx.at
 *          a.schaepers@digitalpublishing.de            
 *
 ***************************************************************************)

{ Some notes from as:
  1. DirectInput Enum callback functions which are documented with result
  type BOOL in the SDK had to be changed to result type integer because the debug
  version of DINPUT.DLL (which is the same for SDK versions 5.0, 5.2, 6.0, and 6.1)
  explicitely checks for two possible return values:

  0 - FALSE in C and in Delphi
  1 - TRUE in C, defined as DIENUM_CONTINUE

  In Delphi, TRUE means $FFFFFFFF (= -1) for the LongBool (= BOOL) data
  type, and AL = 1 (upper three bytes undefined) for the Boolean data type.
  The debug version of DINPUT.DLL will throw an external exception
  ("invalid return value for callback") when fed with either value.

  This change affects the following methods:
  EnumDevices, EnumObjects, EnumEffects, EnumCreatedEffectObjects

  2. Windows 98 and DX6 debug versions DInput and DSound

  Under Windows 98, the "debug" setup of the DirectX SDK 6.x skips DInput.DLL
  and DSound.DLL, i.e. makes you end up with the retail version of these two
  files without any notice.
  The debug versions of DInput.DLL and DSound.DLL can be found in the
  \extras\Win98\Win98Dbg folder of the SDK CD; they need to be installed
  "manually".

  This problem has been fixed with DX7 where the SDK installs the debug versions
  of DInput and DSound without any "manual" help.

}

unit DirectInput;

{$MINENUMSIZE 4}
{$ALIGN ON}
                                                
interface

uses
  Windows,
  MMSystem;

var
  DInputDLL : HMODULE;

{$IFDEF DIRECTX3}
const DIRECTINPUT_VERSION = $0300;
{$ELSE}
const DIRECTINPUT_VERSION = $0700;
{$ENDIF}

function DIErrorString(Value: HResult) : string;

type
  TRefGUID = packed record
    case integer of
    1: (guid : PGUID);
    2: (dwFlags : DWORD);
  end;

(****************************************************************************
 *
 *      Class IDs
 *
 ****************************************************************************)
const
  CLSID_DirectInput: TGUID =
      (D1:$25E609E0;D2:$B259;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  CLSID_DirectInputDevice: TGUID =
      (D1:$25E609E1;D2:$B259;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));

(****************************************************************************
 *
 *      Predefined object types
 *
 ****************************************************************************)

  GUID_XAxis: TGUID =
      (D1:$A36D02E0;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_YAxis: TGUID =
      (D1:$A36D02E1;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_ZAxis: TGUID =
      (D1:$A36D02E2;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_RxAxis: TGUID =
      (D1:$A36D02F4;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_RyAxis: TGUID =
      (D1:$A36D02F5;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_RzAxis: TGUID =
      (D1:$A36D02E3;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_Slider: TGUID =
      (D1:$A36D02E4;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));

  GUID_Button: TGUID =
      (D1:$A36D02F0;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_Key: TGUID =
      (D1:$55728220;D2:$D33C;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));

  GUID_POV: TGUID =
      (D1:$A36D02F2;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));

  GUID_Unknown: TGUID =
      (D1:$A36D02F3;D2:$C9F3;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));

(****************************************************************************
 *
 *      Predefined product GUIDs
 *
 ****************************************************************************)

  GUID_SysMouse: TGUID =
      (D1:$6F1D2B60;D2:$D5A0;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_SysKeyboard: TGUID =
      (D1:$6F1D2B61;D2:$D5A0;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_Joystick: TGUID =
      (D1:$6F1D2B70;D2:$D5A0;D3:$11CF;D4:($BF,$C7,$44,$45,$53,$54,$00,$00));
  GUID_SysMouseEm: TGUID = '{6F1D2B80-D5A0-11CF-BFC7-444553540000}';
  GUID_SysMouseEm2: TGUID = '{6F1D2B81-D5A0-11CF-BFC7-444553540000}';
  GUID_SysKeyboardEm: TGUID = '{6F1D2B82-D5A0-11CF-BFC7-444553540000}';
  GUID_SysKeyboardEm2: TGUID = '{6F1D2B83-D5A0-11CF-BFC7-444553540000}';

(****************************************************************************
 *
 *      Predefined force feedback effects
 *
 ****************************************************************************)

  GUID_ConstantForce: TGUID =
      (D1:$13541C20;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_RampForce: TGUID =
      (D1:$13541C21;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Square: TGUID =
      (D1:$13541C22;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Sine: TGUID =
      (D1:$13541C23;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Triangle: TGUID =
      (D1:$13541C24;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_SawtoothUp: TGUID =
      (D1:$13541C25;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_SawtoothDown: TGUID =
      (D1:$13541C26;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Spring: TGUID =
      (D1:$13541C27;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Damper: TGUID =
      (D1:$13541C28;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Inertia: TGUID =
      (D1:$13541C29;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_Friction: TGUID =
      (D1:$13541C2A;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));
  GUID_CustomForce: TGUID =
      (D1:$13541C2B;D2:$8E33;D3:$11D0;D4:($9A,$D0,$00,$A0,$C9,$A0,$6E,$35));



(****************************************************************************
 *
 *      Interfaces and Structures...
 *
 ****************************************************************************)

(****************************************************************************
 *
 *      IDirectInputEffect
 *
 ****************************************************************************)

const
  DIEFT_ALL                   = $00000000;

  DIEFT_CONSTANTFORCE         = $00000001;
  DIEFT_RAMPFORCE             = $00000002;
  DIEFT_PERIODIC              = $00000003;
  DIEFT_CONDITION             = $00000004;
  DIEFT_CUSTOMFORCE           = $00000005;
  DIEFT_HARDWARE              = $000000FF;

  DIEFT_FFATTACK              = $00000200;
  DIEFT_FFFADE                = $00000400;
  DIEFT_SATURATION            = $00000800;
  DIEFT_POSNEGCOEFFICIENTS    = $00001000;
  DIEFT_POSNEGSATURATION      = $00002000;
  DIEFT_DEADBAND              = $00004000;
  DIEFT_STARTDELAY            = $00008000;

function DIEFT_GETTYPE(n: variant) : byte;

const
  DI_DEGREES                  =     100;
  DI_FFNOMINALMAX             =   10000;
  DI_SECONDS                  = 1000000;

type
  PDIConstantForce = ^TDIConstantForce;
  TDIConstantForce = packed record
    lMagnitude : LongInt;
  end;

  PDIRampForce = ^TDIRampForce;
  TDIRampForce = packed record
    lStart : LongInt;
    lEnd : LongInt;
  end;

  PDIPeriodic = ^TDIPeriodic;
  TDIPeriodic = packed record
    dwMagnitude : DWORD;
    lOffset : LongInt;
    dwPhase : DWORD;
    dwPeriod : DWORD;
  end;

  PDICondition = ^TDICondition;
  TDICondition = packed record
    lOffset : LongInt;
    lPositiveCoefficient : LongInt;
    lNegativeCoefficient : LongInt;
    dwPositiveSaturation : DWORD;
    dwNegativeSaturation : DWORD;
    lDeadBand : LongInt;
  end;

  PDICustomForce = ^TDICustomForce;
  TDICustomForce = packed record
    cChannels : DWORD;
    dwSamplePeriod : DWORD;
    cSamples : DWORD;
    rglForceData : PLongInt;
  end;

  PDIEnvelope = ^TDIEnvelope;
  TDIEnvelope = packed record
    dwSize : DWORD;                   (* sizeof(DIENVELOPE)   *)
    dwAttackLevel : DWORD;
    dwAttackTime : DWORD;             (* Microseconds         *)
    dwFadeLevel : DWORD;
    dwFadeTime : DWORD;               (* Microseconds         *)
  end;

  PDIEffect_DX5 = ^TDIEffect_DX5;
  TDIEffect_DX5 = packed record
    dwSize : DWORD;                   (* sizeof(DIEFFECT)     *)
    dwFlags : DWORD;                  (* DIEFF_*              *)
    dwDuration : DWORD;               (* Microseconds         *)
    dwSamplePeriod : DWORD;           (* Microseconds         *)
    dwGain : DWORD;
    dwTriggerButton : DWORD;          (* or DIEB_NOTRIGGER    *)
    dwTriggerRepeatInterval : DWORD;  (* Microseconds         *)
    cAxes : DWORD;                    (* Number of axes       *)
    rgdwAxes : PDWORD;                (* Array of axes        *)
    rglDirection : PLongInt;          (* Array of directions  *)
    lpEnvelope : PDIEnvelope;         (* Optional             *)
    cbTypeSpecificParams : DWORD;     (* Size of params       *)
    lpvTypeSpecificParams : pointer;  (* Pointer to params    *)
  end;

  PDIEffect_DX6 = ^TDIEffect_DX6;
  TDIEffect_DX6 = packed record
    dwSize : DWORD;                   (* sizeof(DIEFFECT)     *)
    dwFlags : DWORD;                  (* DIEFF_*              *)
    dwDuration : DWORD;               (* Microseconds         *)
    dwSamplePeriod : DWORD;           (* Microseconds         *)
    dwGain : DWORD;
    dwTriggerButton : DWORD;          (* or DIEB_NOTRIGGER    *)
    dwTriggerRepeatInterval : DWORD;  (* Microseconds         *)
    cAxes : DWORD;                    (* Number of axes       *)
    rgdwAxes : PDWORD;                (* Array of axes        *)
    rglDirection : PLongInt;          (* Array of directions  *)
    lpEnvelope : PDIEnvelope;         (* Optional             *)
    cbTypeSpecificParams : DWORD;     (* Size of params       *)
    lpvTypeSpecificParams : pointer;  (* Pointer to params    *)
    dwStartDelay: DWORD;              (* Microseconds         *)
  end;

  PDIEffect = ^TDIEffect;
{$IFDEF DIRECTX5}
  TDIEffect = TDIEffect_DX5;
{$ELSE}
  TDIEffect = TDIEffect_DX6;
{$ENDIF}

  PDIFileEffect = ^TDIFileEffect;
  TDIFileEffect = packed record
    dwSize : DWORD;
    GuidEffect: TGUID;
    lpDiEffect: PDIEffect;
    szFriendlyName : array [0..MAX_PATH-1] of AnsiChar;
  end;

const
  DIEFF_OBJECTIDS             = $00000001;
  DIEFF_OBJECTOFFSETS         = $00000002;
  DIEFF_CARTESIAN             = $00000010;
  DIEFF_POLAR                 = $00000020;
  DIEFF_SPHERICAL             = $00000040;

  DIEP_DURATION               = $00000001;
  DIEP_SAMPLEPERIOD           = $00000002;
  DIEP_GAIN                   = $00000004;
  DIEP_TRIGGERBUTTON          = $00000008;
  DIEP_TRIGGERREPEATINTERVAL  = $00000010;
  DIEP_AXES                   = $00000020;
  DIEP_DIRECTION              = $00000040;
  DIEP_ENVELOPE               = $00000080;
  DIEP_TYPESPECIFICPARAMS     = $00000100;
{$IFDEF DIRECTX5}
  DIEP_ALLPARAMS              = $000001FF;
{$ELSE}
  DIEP_STARTDELAY             = $00000200;
  DIEP_ALLPARAMS_DX5          = $000001FF;
  DIEP_ALLPARAMS              = $000003FF;
{$ENDIF}
  DIEP_START                  = $20000000;
  DIEP_NORESTART              = $40000000;
  DIEP_NODOWNLOAD             = $80000000;
  DIEB_NOTRIGGER              = $FFFFFFFF;

  DIES_SOLO                   = $00000001;
  DIES_NODOWNLOAD             = $80000000;

  DIEGES_PLAYING              = $00000001;
  DIEGES_EMULATED             = $00000002;


type
  PDIEffEscape = ^TDIEffEscape;
  TDIEffEscape = packed record
    dwSize : DWORD;
    dwCommand : DWORD;
    lpvInBuffer : pointer;
    cbInBuffer : DWORD;
    lpvOutBuffer : pointer;
    cbOutBuffer : DWORD;
  end;


//
// IDirectSoundCapture  // as: ???
//
  IDirectInputEffect = interface (IUnknown)
    ['{E7E1F7C0-88D2-11D0-9AD0-00A0C9A06E35}']
    (** IDirectInputEffect methods ***)
    function Initialize(hinst: THandle; dwVersion: DWORD;
        const rguid: TGUID) : HResult;  stdcall;
    function GetEffectGuid(var pguid: TGUID) : HResult;  stdcall;
    function GetParameters(var peff: TDIEffect; dwFlags: DWORD) : HResult;  stdcall;
    function SetParameters(var peff: TDIEffect; dwFlags: DWORD) : HResult;  stdcall;
    function Start(dwIterations: DWORD; dwFlags: DWORD) : HResult;  stdcall;
    function Stop : HResult;  stdcall;
    function GetEffectStatus(var pdwFlags : DWORD) : HResult;  stdcall;
    function Download : HResult;  stdcall;
    function Unload : HResult;  stdcall;
    function Escape(var pesc: TDIEffEscape) : HResult;  stdcall;
  end;

(****************************************************************************
 *
 *      IDirectInputDevice
 *
 ****************************************************************************)

const
  DIDEVTYPE_DEVICE = 1;
  DIDEVTYPE_MOUSE = 2;
  DIDEVTYPE_KEYBOARD = 3;
  DIDEVTYPE_JOYSTICK = 4;
  DIDEVTYPE_HID = $00010000;

  DIDEVTYPEMOUSE_UNKNOWN = 1;
  DIDEVTYPEMOUSE_TRADITIONAL = 2;
  DIDEVTYPEMOUSE_FINGERSTICK = 3;
  DIDEVTYPEMOUSE_TOUCHPAD = 4;
  DIDEVTYPEMOUSE_TRACKBALL = 5;

  DIDEVTYPEKEYBOARD_UNKNOWN = 0;
  DIDEVTYPEKEYBOARD_PCXT = 1;
  DIDEVTYPEKEYBOARD_OLIVETTI = 2;
  DIDEVTYPEKEYBOARD_PCAT = 3;
  DIDEVTYPEKEYBOARD_PCENH = 4;
  DIDEVTYPEKEYBOARD_NOKIA1050 = 5;
  DIDEVTYPEKEYBOARD_NOKIA9140 = 6;
  DIDEVTYPEKEYBOARD_NEC98 = 7;
  DIDEVTYPEKEYBOARD_NEC98LAPTOP = 8;
  DIDEVTYPEKEYBOARD_NEC98106 = 9;
  DIDEVTYPEKEYBOARD_JAPAN106 = 10;
  DIDEVTYPEKEYBOARD_JAPANAX = 11;
  DIDEVTYPEKEYBOARD_J3100 = 12;

  DIDEVTYPEJOYSTICK_UNKNOWN = 1;
  DIDEVTYPEJOYSTICK_TRADITIONAL = 2;
  DIDEVTYPEJOYSTICK_FLIGHTSTICK = 3;
  DIDEVTYPEJOYSTICK_GAMEPAD = 4;
  DIDEVTYPEJOYSTICK_RUDDER = 5;
  DIDEVTYPEJOYSTICK_WHEEL = 6;
  DIDEVTYPEJOYSTICK_HEADTRACKER = 7;

function GET_DIDEVICE_TYPE(dwDevType: variant) : byte;
function GET_DIDEVICE_SUBTYPE(dwDevType: variant) : byte;

type
  PDIDevCaps_DX3 = ^TDIDevCaps_DX3;
  TDIDevCaps_DX3 = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwDevType: DWORD;
    dwAxes: DWORD;
    dwButtons: DWORD;
    dwPOVs: DWORD;
  end;

  PDIDevCaps_DX5 = ^TDIDevCaps_DX5;
  TDIDevCaps_DX5 = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwDevType: DWORD;
    dwAxes: DWORD;
    dwButtons: DWORD;
    dwPOVs: DWORD;
    dwFFSamplePeriod: DWORD;
    dwFFMinTimeResolution: DWORD;
    dwFirmwareRevision: DWORD;
    dwHardwareRevision: DWORD;
    dwFFDriverVersion: DWORD;
  end;

  PDIDevCaps = ^TDIDevCaps;
{$IFDEF DIRECTX3}
  TDIDevCaps = TDIDevCaps_DX3;
{$ELSE}
  TDIDevCaps = TDIDevCaps_DX5;
{$ENDIF}

const
  DIDC_ATTACHED           = $00000001;
  DIDC_POLLEDDEVICE       = $00000002;
  DIDC_EMULATED           = $00000004;
  DIDC_POLLEDDATAFORMAT   = $00000008;
  DIDC_FORCEFEEDBACK      = $00000100;
  DIDC_FFATTACK           = $00000200;
  DIDC_FFFADE             = $00000400;
  DIDC_SATURATION         = $00000800;
  DIDC_POSNEGCOEFFICIENTS = $00001000;
  DIDC_POSNEGSATURATION   = $00002000;
  DIDC_DEADBAND           = $00004000;
  DIDC_STARTDELAY         = $00008000;
  DIDC_ALIAS              = $00010000;
  DIDC_PHANTOM            = $00020000;

  DIDFT_ALL = $00000000;

  DIDFT_RELAXIS = $00000001;
  DIDFT_ABSAXIS = $00000002;
  DIDFT_AXIS    = $00000003;

  DIDFT_PSHBUTTON = $00000004;
  DIDFT_TGLBUTTON = $00000008;
  DIDFT_BUTTON    = $0000000C;

  DIDFT_POV        = $00000010;
  DIDFT_COLLECTION = $00000040;
  DIDFT_NODATA     = $00000080;

  DIDFT_ANYINSTANCE = $00FFFF00;
  DIDFT_INSTANCEMASK = DIDFT_ANYINSTANCE;
function DIDFT_MAKEINSTANCE(n: variant) : DWORD;
function DIDFT_GETTYPE(n: variant) : byte;
function DIDFT_GETINSTANCE(n: variant) : DWORD;
const
  DIDFT_FFACTUATOR        = $01000000;
  DIDFT_FFEFFECTTRIGGER   = $02000000;
  DIDFT_OUTPUT            = $10000000;
  DIDFT_VENDORDEFINED     = $04000000;
  DIDFT_ALIAS             = $08000000;

function DIDFT_ENUMCOLLECTION(n: variant) : DWORD;
const
  DIDFT_NOCOLLECTION = $00FFFF00;



type
  PDIObjectDataFormat = ^TDIObjectDataFormat;
  TDIObjectDataFormat = packed record
    pguid: PGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
  end;

  PDIDataFormat = ^TDIDataFormat;
  TDIDataFormat = packed record
    dwSize: DWORD;   
    dwObjSize: DWORD;
    dwFlags: DWORD;   
    dwDataSize: DWORD;   
    dwNumObjs: DWORD;   
    rgodf: PDIObjectDataFormat;
  end;

const
  DIDF_ABSAXIS = $00000001;
  DIDF_RELAXIS = $00000002;

type
  PDIDeviceObjectInstance_DX3A = ^TDIDeviceObjectInstance_DX3A;
  TDIDeviceObjectInstance_DX3A = packed record
    dwSize: DWORD;
    guidType: TGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
    tszName: Array [0..MAX_PATH-1] of CHAR;
  end;

  PDIDeviceObjectInstance_DX3W = ^TDIDeviceObjectInstance_DX3W;
  TDIDeviceObjectInstance_DX3W = packed record
    dwSize: DWORD;
    guidType: TGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
    tszName: Array [0..MAX_PATH-1] of WCHAR;
  end;

  PDIDeviceObjectInstance_DX3 = ^TDIDeviceObjectInstance_DX3;
{$IFDEF UNICODE}
  TDIDeviceObjectInstance_DX3 = TDIDeviceObjectInstance_DX3W;
{$ELSE}
  TDIDeviceObjectInstance_DX3 = TDIDeviceObjectInstance_DX3A;
{$ENDIF}

  PDIDeviceObjectInstance_DX5A = ^TDIDeviceObjectInstance_DX5A;
  TDIDeviceObjectInstance_DX5A = packed record
    dwSize: DWORD;
    guidType: TGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
    tszName: Array [0..MAX_PATH-1] of CHAR;
    dwFFMaxForce: DWORD;
    dwFFForceResolution: DWORD;
    wCollectionNumber: WORD;
    wDesignatorIndex: WORD;
    wUsagePage: WORD;
    wUsage: WORD;
    dwDimension: DWORD;
    wExponent: WORD;
    wReserved: WORD;
  end;

  PDIDeviceObjectInstance_DX5W = ^TDIDeviceObjectInstance_DX5W;
  TDIDeviceObjectInstance_DX5W = packed record
    dwSize: DWORD;
    guidType: TGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
    tszName: Array [0..MAX_PATH-1] of WCHAR;
    dwFFMaxForce: DWORD;
    dwFFForceResolution: DWORD;
    wCollectionNumber: WORD;
    wDesignatorIndex: WORD;
    wUsagePage: WORD;
    wUsage: WORD;
    dwDimension: DWORD;
    wExponent: WORD;
    wReserved: WORD;
  end;

  PDIDeviceObjectInstance_DX5 = ^TDIDeviceObjectInstance_DX5;
{$IFDEF UNICODE}
  TDIDeviceObjectInstance_DX5 = TDIDeviceObjectInstance_DX5W;
{$ELSE}
  TDIDeviceObjectInstance_DX5 = TDIDeviceObjectInstance_DX5A;
{$ENDIF}

  PDIDeviceObjectInstanceA = ^TDIDeviceObjectInstanceA;
  PDIDeviceObjectInstanceW = ^TDIDeviceObjectInstanceA;
  PDIDeviceObjectInstance = ^TDIDeviceObjectInstance;
{$IFDEF DIRECTX3}
  TDIDeviceObjectInstanceA = TDIDeviceObjectInstance_DX3A;
  TDIDeviceObjectInstanceW = TDIDeviceObjectInstance_DX3W;
  TDIDeviceObjectInstance = TDIDeviceObjectInstance_DX3;
{$ELSE}
  TDIDeviceObjectInstanceA = TDIDeviceObjectInstance_DX5A;
  TDIDeviceObjectInstanceW = TDIDeviceObjectInstance_DX5W;
  TDIDeviceObjectInstance = TDIDeviceObjectInstance_DX5;
{$ENDIF}

  // Bug fix (and deviation from the SDK). Callback *must* return
  // DIENUM_STOP (= 0) or DIENUM_CONTINUE (=1) in order to work
  // with the debug version of DINPUT.DLL
  TDIEnumDeviceObjectsCallbackA = function (
      var lpddoi: TDIDeviceObjectInstanceA; pvRef: Pointer): Integer; stdcall; // BOOL; stdcall;
  TDIEnumDeviceObjectsCallbackW = function (
      var lpddoi: TDIDeviceObjectInstanceW; pvRef: Pointer): Integer; stdcall; // BOOL; stdcall;
  TDIEnumDeviceObjectsCallback = function (
      var lpddoi: TDIDeviceObjectInstance; pvRef: Pointer): Integer; stdcall; // BOOL; stdcall;

  TDIEnumDeviceObjectsProc = function (
      var lpddoi: TDIDeviceObjectInstance; pvRef: Pointer): Integer; stdcall; // BOOL; stdcall;

const
  DIDOI_FFACTUATOR        = $00000001;
  DIDOI_FFEFFECTTRIGGER   = $00000002;
  DIDOI_POLLED            = $00008000;
  DIDOI_ASPECTPOSITION    = $00000100;
  DIDOI_ASPECTVELOCITY    = $00000200;
  DIDOI_ASPECTACCEL       = $00000300;
  DIDOI_ASPECTFORCE       = $00000400;
  DIDOI_ASPECTMASK        = $00000F00;
  DIDOI_GUIDISUSAGE       = $00010000;

type
  PDIPropHeader = ^TDIPropHeader;
  TDIPropHeader = packed record
    dwSize: DWORD;
    dwHeaderSize: DWORD;
    dwObj: DWORD;
    dwHow: DWORD;
  end;

const
  DIPH_DEVICE = 0;
  DIPH_BYOFFSET = 1;
  DIPH_BYID = 2;
  DIPH_BYUSAGE = 3;

function DIMAKEUSAGEDWORD(UsagePage, Usage: WORD) : DWORD;

type
  PDIPropDWord = ^TDIPropDWord;
  TDIPropDWord = packed record
    diph: TDIPropHeader;
    dwData: DWORD;
  end;

  PDIPropRange = ^TDIPropRange;
  TDIPropRange = packed record
    diph: TDIPropHeader;
    lMin: Longint;
    lMax: Longint;
  end;

const
  DIPROPRANGE_NOMIN = $80000000;
  DIPROPRANGE_NOMAX = $7FFFFFFF;

type
  PDIPropCal = ^TDIPropCal;
  TDIPropCal = packed record
    diph: TDIPropHeader;
    lMin:    LongInt;
    lCenter: LongInt;
    lMax:    LongInt;
  end;

  PDIPropGUIDAndPath = ^TDIPropGUIDAndPath;
  TDIPropGUIDAndPath = packed record
    diph: TDIPropHeader;
    guidClass: TGUID;
    wszPath: array [0..MAX_PATH-1] of WideChar;
  end;

  PDIPropString = ^TDIPropString;
  TDIPropString = packed record
    diph: TDIPropHeader;
    wsz: array [0..MAX_PATH-1] of WideChar;
  end;

type
  MAKEDIPROP = PGUID;

const
  DIPROP_BUFFERSIZE = MAKEDIPROP(1);

  DIPROP_AXISMODE = MAKEDIPROP(2);

  DIPROPAXISMODE_ABS = 0;
  DIPROPAXISMODE_REL = 1;

  DIPROP_GRANULARITY = MAKEDIPROP(3);

  DIPROP_RANGE = MAKEDIPROP(4);

  DIPROP_DEADZONE = MAKEDIPROP(5);

  DIPROP_SATURATION = MAKEDIPROP(6);

  DIPROP_FFGAIN = MAKEDIPROP(7);

  DIPROP_FFLOAD = MAKEDIPROP(8);

  DIPROP_AUTOCENTER = MAKEDIPROP(9);

  DIPROPAUTOCENTER_OFF = 0;
  DIPROPAUTOCENTER_ON = 1;

  DIPROP_CALIBRATIONMODE = MAKEDIPROP(10);

  DIPROPCALIBRATIONMODE_COOKED = 0;
  DIPROPCALIBRATIONMODE_RAW = 1;

  DIPROP_CALIBRATION      = MAKEDIPROP(11);

  DIPROP_GUIDANDPATH      = MAKEDIPROP(12);

  DIPROP_INSTANCENAME     = MAKEDIPROP(13);

  DIPROP_PRODUCTNAME      = MAKEDIPROP(14);

  DIPROP_JOYSTICKID       = MAKEDIPROP(15);

  DIPROP_GETPORTDISPLAYNAME       = MAKEDIPROP(16);


  DIPROP_ENABLEREPORTID       = MAKEDIPROP(17);


  DIPROP_GETPHYSICALRANGE            = MAKEDIPROP(18);

  DIPROP_GETLOGICALRANGE            = MAKEDIPROP(19);


type
  PDIDeviceObjectData = ^TDIDeviceObjectData;
  TDIDeviceObjectData = packed record
    dwOfs: DWORD;
    dwData: DWORD;
    dwTimeStamp: DWORD;
    dwSequence: DWORD;
  end;

const
  DIGDD_PEEK = $00000001;
{
#define DISEQUENCE_COMPARE(dwSequence1, cmp, dwSequence2) \
                         (int) ((dwSequence1) - (dwSequence2))  cmp 0
}

  DISCL_EXCLUSIVE  = $00000001;
  DISCL_NONEXCLUSIVE = $00000002;
  DISCL_FOREGROUND = $00000004;
  DISCL_BACKGROUND = $00000008;
  DISCL_NOWINKEY   = $00000010;


type

  PDIDeviceInstance_DX3A = ^TDIDeviceInstance_DX3A;
  TDIDeviceInstance_DX3A = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: Array [0..MAX_PATH-1] of AnsiChar;
    tszProductName: Array [0..MAX_PATH-1] of AnsiChar;
  end;

  PDIDeviceInstance_DX3W = ^TDIDeviceInstance_DX3W;
  TDIDeviceInstance_DX3W = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: Array [0..MAX_PATH-1] of WideChar;
    tszProductName: Array [0..MAX_PATH-1] of WideChar;
  end;

  PDIDeviceInstance_DX3 = ^TDIDeviceInstance_DX3;
{$IFDEF UNICODE}
  TDIDeviceInstance_DX3 = TDIDeviceInstance_DX3W;
{$ELSE}
  TDIDeviceInstance_DX3 = TDIDeviceInstance_DX3A;
{$ENDIF}

  PDIDeviceInstance_DX5A = ^TDIDeviceInstance_DX5A;
  TDIDeviceInstance_DX5A = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: Array [0..MAX_PATH-1] of AnsiChar;
    tszProductName: Array [0..MAX_PATH-1] of AnsiChar;
    guidFFDriver: TGUID;
    wUsagePage: WORD;
    wUsage: WORD;
  end;

  PDIDeviceInstance_DX5W = ^TDIDeviceInstance_DX5W;
  TDIDeviceInstance_DX5W = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: Array [0..MAX_PATH-1] of WideChar;
    tszProductName: Array [0..MAX_PATH-1] of WideChar;
    guidFFDriver: TGUID;
    wUsagePage: WORD;
    wUsage: WORD;
  end;

  PDIDeviceInstance_DX5 = ^TDIDeviceInstance_DX5;
{$IFDEF UNICODE}
  TDIDeviceInstance_DX5 = TDIDeviceInstance_DX5W;
{$ELSE}
  TDIDeviceInstance_DX5 = TDIDeviceInstance_DX5A;
{$ENDIF}

  PDIDeviceInstanceA = ^TDIDeviceInstanceA;
  PDIDeviceInstanceW = ^TDIDeviceInstanceW;
  PDIDeviceInstance = ^TDIDeviceInstance;
{$IFDEF DIRECTX3}
  TDIDeviceInstanceA = TDIDeviceInstance_DX3A;
  TDIDeviceInstanceW = TDIDeviceInstance_DX3W;
  TDIDeviceInstance = TDIDeviceInstance_DX3;
{$ELSE}
  TDIDeviceInstanceA = TDIDeviceInstance_DX5A;
  TDIDeviceInstanceW = TDIDeviceInstance_DX5W;
  TDIDeviceInstance = TDIDeviceInstance_DX5;
{$ENDIF}

  IDirectInputDeviceA = interface (IUnknown)
    ['{5944E680-C92E-11CF-BFC7-444553540000}']
    (*** IDirectInputDeviceA methods ***)
    function GetCapabilities(var lpDIDevCaps: TDIDevCaps) : HResult;  stdcall;
    function EnumObjects(lpCallback: TDIEnumDeviceObjectsCallbackA;
        pvRef: Pointer; dwFlags: DWORD) : HResult;  stdcall;
    function GetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader) :
        HResult;  stdcall;
    function SetProperty(rguidProp: PGUID; const pdiph: TDIPropHeader) :
        HResult;  stdcall;
    function Acquire : HResult;  stdcall;
    function Unacquire : HResult;  stdcall;
    function GetDeviceState(cbData: DWORD; lpvData: Pointer) : HResult;  stdcall;
    function GetDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData;
        var pdwInOut: DWORD; dwFlags: DWORD) : HResult;  stdcall;
    function SetDataFormat(var lpdf: TDIDataFormat) : HResult;  stdcall;
    function SetEventNotification(hEvent: THandle) : HResult;  stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD) : HResult;  stdcall;
    function GetObjectInfo(var pdidoi: TDIDeviceObjectInstanceA; dwObj: DWORD;
        dwHow: DWORD) : HResult;  stdcall;
    function GetDeviceInfo(var pdidi: TDIDeviceInstanceA) : HResult;  stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD) : HResult;  stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID) : HResult;  stdcall;
  end;

  IDirectInputDeviceW = interface (IUnknown)
    ['{5944E681-C92E-11CF-BFC7-444553540000}']
    (*** IDirectInputDeviceW methods ***)
    function GetCapabilities(var lpDIDevCaps: TDIDevCaps) : HResult;  stdcall;
    function EnumObjects(lpCallback: TDIEnumDeviceObjectsCallbackW;
        pvRef: Pointer; dwFlags: DWORD) : HResult;  stdcall;
    function GetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader) :
        HResult;  stdcall;
    function SetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader) :
        HResult;  stdcall;
    function Acquire : HResult;  stdcall;
    function Unacquire : HResult;  stdcall;
    function GetDeviceState(cbData: DWORD; lpvData: Pointer) : HResult;  stdcall;
    function GetDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData;
        var pdwInOut: DWORD; dwFlags: DWORD) : HResult;  stdcall;
    function SetDataFormat(var lpdf: TDIDataFormat) : HResult;  stdcall;
    function SetEventNotification(hEvent: THandle) : HResult;  stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD) : HResult;  stdcall;
    function GetObjectInfo(var pdidoi: TDIDeviceObjectInstanceW; dwObj: DWORD;
        dwHow: DWORD) : HResult;  stdcall;
    function GetDeviceInfo(var pdidi: TDIDeviceInstanceW) : HResult;  stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD) : HResult;  stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID) : HResult;  stdcall;
  end;

{$IFDEF UNICODE}
  IDirectInputDevice = IDirectInputDeviceW;
{$ELSE}
  IDirectInputDevice = IDirectInputDeviceA;
{$ENDIF}

const
  DISFFC_RESET            = $00000001;
  DISFFC_STOPALL          = $00000002;
  DISFFC_PAUSE            = $00000004;
  DISFFC_CONTINUE         = $00000008;
  DISFFC_SETACTUATORSON   = $00000010;
  DISFFC_SETACTUATORSOFF  = $00000020;

  DIGFFS_EMPTY            = $00000001;
  DIGFFS_STOPPED          = $00000002;
  DIGFFS_PAUSED           = $00000004;
  DIGFFS_ACTUATORSON      = $00000010;
  DIGFFS_ACTUATORSOFF     = $00000020;
  DIGFFS_POWERON          = $00000040;
  DIGFFS_POWEROFF         = $00000080;
  DIGFFS_SAFETYSWITCHON   = $00000100;
  DIGFFS_SAFETYSWITCHOFF  = $00000200;
  DIGFFS_USERFFSWITCHON   = $00000400;
  DIGFFS_USERFFSWITCHOFF  = $00000800;
  DIGFFS_DEVICELOST       = $80000000;

type
  PDIEffectInfoA = ^TDIEffectInfoA;
  TDIEffectInfoA = packed record
    dwSize : DWORD;
    guid : TGUID;
    dwEffType : DWORD;
    dwStaticParams : DWORD;
    dwDynamicParams : DWORD;
    tszName : array [0..MAX_PATH-1] of CHAR;
  end;

  PDIEffectInfoW = ^TDIEffectInfoW;
  TDIEffectInfoW = packed record
    dwSize : DWORD;
    guid : TGUID;
    dwEffType : DWORD;
    dwStaticParams : DWORD;
    dwDynamicParams : DWORD;
    tszName : array [0..MAX_PATH-1] of WCHAR;
  end;

  PDIEffectInfo = ^TDIEffectInfo;
{$IFDEF UNICODE}
  TDIEffectInfo = TDIEffectInfoW;
{$ELSE}
  TDIEffectInfo = TDIEffectInfoA;
{$ENDIF}

const
  DISDD_CONTINUE          = $00000001;

  // Bug fix & deviation from the SDK: Must return DIENUM_STOP or
  // DIENUM_CONTINUE (=1) in order to work with the debug version of DINPUT.DLL
type
  TDIEnumEffectsCallbackA =
      function(var pdei: TDIEffectInfoA; pvRef: pointer): Integer; stdcall; // BOOL; stdcall;
  TDIEnumEffectsCallbackW =
      function(var pdei: TDIEffectInfoW; pvRef: pointer): Integer; stdcall; // BOOL; stdcall;
  TDIEnumEffectsCallback =
      function(var pdei: TDIEffectInfo; pvRef: pointer) : Integer; stdcall; // BOOL; stdcall;
  TDIEnumEffectsProc = TDIEnumEffectsCallback;

  TDIEnumCreatedEffectObjectsCallback =
      function(peff: IDirectInputEffect; pvRev: pointer): Integer; stdcall; // BOOL; stdcall;
  TDIEnumCreatedEffectObjectsProc = TDIEnumCreatedEffectObjectsCallback;

  IDirectInputDevice2A = interface (IDirectInputDeviceA)
    ['{5944E682-C92E-11CF-BFC7-444553540000}']
    (*** IDirectInputDevice2A methods ***)
    function CreateEffect(const rguid: TGUID; lpeff: PDIEffect;
        var ppdeff: IDirectInputEffect; punkOuter: IUnknown) : HResult;  stdcall;
    function EnumEffects(lpCallback: TDIEnumEffectsCallbackA;
        pvRef: pointer; dwEffType: DWORD) : HResult;  stdcall;
    function GetEffectInfo(pdei: TDIEffectInfoA; const rguid: TGUID) : HResult;  stdcall;
    function GetForceFeedbackState(var pdwOut: DWORD) : HResult;  stdcall;
    function SendForceFeedbackCommand(dwFlags: DWORD) : HResult;  stdcall;
    function EnumCreatedEffectObjects(lpCallback:
        TDIEnumCreatedEffectObjectsCallback;
        pvRef: pointer; fl: DWORD) : HResult;  stdcall;
    function Escape(var pesc: TDIEffEscape) : HResult;  stdcall;
    function Poll : HResult;  stdcall;
    function SendDeviceData
        (cbObjectData: DWORD; var rgdod: TDIDeviceObjectData;
        var pdwInOut: DWORD; fl: DWORD) : HResult;  stdcall;
  end;

  IDirectInputDevice2W = interface (IDirectInputDeviceW)
    ['{5944E683-C92E-11CF-BFC7-444553540000}']
    (*** IDirectInputDevice2W methods ***)
    function CreateEffect(const rguid: TGUID; lpeff: PDIEffect;
        var ppdeff: IDirectInputEffect; punkOuter: IUnknown) : HResult;  stdcall;
    function EnumEffects(lpCallback: TDIEnumEffectsCallbackW;
        pvRef: pointer; dwEffType: DWORD) : HResult;  stdcall;
    function GetEffectInfo(pdei: TDIEffectInfoW; const rguid: TGUID) : HResult;  stdcall;
    function GetForceFeedbackState(var pdwOut: DWORD) : HResult;  stdcall;
    function SendForceFeedbackCommand(dwFlags: DWORD) : HResult;  stdcall;
    function EnumCreatedEffectObjects(lpCallback:
        TDIEnumCreatedEffectObjectsCallback;
        pvRef: pointer; fl: DWORD) : HResult;  stdcall;
    function Escape(var pesc: TDIEffEscape) : HResult;  stdcall;
    function Poll : HResult;  stdcall;
    function SendDeviceData
        (cbObjectData: DWORD; var rgdod: TDIDeviceObjectData;
        var pdwInOut: DWORD; fl: DWORD) : HResult;  stdcall;
  end;

{$IFDEF UNICODE}
  IDirectInputDevice2 = IDirectInputDevice2W;
{$ELSE}
  IDirectInputDevice2 = IDirectInputDevice2A;
{$ENDIF}

const
  DIFEF_DEFAULT               = $00000000;
  DIFEF_INCLUDENONSTANDARD    = $00000001;
  DIFEF_MODIFYIFNEEDED	    	= $00000010;

///Weitermachen:  (as: nur die Deklarationen eingefСЊllt, die ich zum Testen gebraucht habe)

type
  TEnumEffectsInFileCallback = function(gaga, huhu: Integer): HResult;

type
  IDirectInputDevice7W = interface (IDirectInputDevice2W)
    ['{57D7C6BD-2356-11D3-8E9D-00C04F6844AE}']
    (*** IDirectInputDevice7A methods ***)
    function EnumEffectsInFile(const lpszFileName: PChar;
      pec: TEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWord): HResult; stdcall;
    function WriteEffectToFile(const lpszFileName: PChar;
      dwEntries: DWord; const rgDIFileEft: PDIFileEffect; dwFlags: DWord): HResult; stdcall;
  end;

  IDirectInputDevice7A = interface (IDirectInputDevice2A)
    ['{57D7C6BC-2356-11D3-8E9D-00C04F6844AE}']
    function EnumEffectsInFile(const lpszFileName: PChar;
      pec: TEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWord): HResult; stdcall;
    function WriteEffectToFile(const lpszFileName: PChar;
      dwEntries: DWord; const rgDIFileEft: PDIFileEffect; dwFlags: DWord): HResult; stdcall;
  end;

{$IFDEF UNICODE}
  IDirectInputDevice7 = IDirectInputDevice7W;
{$ELSE}
  IDirectInputDevice7 = IDirectInputDevice7A;
{$ENDIF}

(****************************************************************************
 *
 *      Mouse
 *
 ****************************************************************************)

type
  PDIMouseState = ^TDIMouseState;
  TDIMouseState = packed record
    lX: Longint;
    lY: Longint;
    lZ: Longint;
    rgbButtons: Array [0..3] of BYTE;  // up to 4 buttons
  end;

  PDIMouseState2 = ^TDIMouseState2;
  TDIMouseState2 = packed record
    lX: Longint;
    lY: Longint;
    lZ: Longint;
    rgbButtons: Array [0..7] of BYTE;  // up to 8 buttons
  end;

const
  DIMOFS_X       = 0;
  DIMOFS_Y       = 4;
  DIMOFS_Z       = 8;
  DIMOFS_BUTTON0 = 12;
  DIMOFS_BUTTON1 = 13;
  DIMOFS_BUTTON2 = 14;
  DIMOFS_BUTTON3 = 15;
  // DX7 supports up to 8 mouse buttons
  DIMOFS_BUTTON4 = DIMOFS_BUTTON0+4;
  DIMOFS_BUTTON5 = DIMOFS_BUTTON0+5;
  DIMOFS_BUTTON6 = DIMOFS_BUTTON0+6;
  DIMOFS_BUTTON7 = DIMOFS_BUTTON0+7;


const
  _c_dfDIMouse_Objects: array[0..6] of TDIObjectDataFormat = (
    (  pguid: @GUID_XAxis;
       dwOfs: DIMOFS_X;
       dwType: DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: @GUID_YAxis;
       dwOfs: DIMOFS_Y;
       dwType: DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: @GUID_ZAxis;
       dwOfs: DIMOFS_Z;
       dwType: $80000000 or DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON0;
       dwType: DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON1;
       dwType: DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON2;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON3;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0)
    );

  c_dfDIMouse: TDIDataFormat = (
    dwSize: Sizeof(c_dfDIMouse);              // $18
    dwObjSize: Sizeof(TDIObjectDataFormat);   // $10
    dwFlags: DIDF_RELAXIS;                    //
    dwDataSize: Sizeof(TDIMouseState);        // $10
    dwNumObjs: High(_c_dfDIMouse_Objects)+1;  // 7
    rgodf: @_c_dfDIMouse_Objects[Low(_c_dfDIMouse_Objects)]
  );


  _c_dfDIMouse2_Objects: array[0..10] of TDIObjectDataFormat = (
    (  pguid: @GUID_XAxis;
       dwOfs: DIMOFS_X;
       dwType: DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: @GUID_YAxis;
       dwOfs: DIMOFS_Y;
       dwType: DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: @GUID_ZAxis;
       dwOfs: DIMOFS_Z;
       dwType: $80000000 or DIDFT_AXIS or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON0;
       dwType: DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON1;
       dwType: DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON2;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON3;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    // fields introduced with IDirectInputDevice7.GetDeviceState       
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON4;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON5;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON6;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0),
    (  pguid: nil;
       dwOfs: DIMOFS_BUTTON7;
       dwType: $80000000 or DIDFT_BUTTON or DIDFT_NOCOLLECTION;
       dwFlags: 0)
    );

  c_dfDIMouse2: TDIDataFormat = (
    dwSize: Sizeof(c_dfDIMouse);              // $18
    dwObjSize: Sizeof(TDIObjectDataFormat);   // $10
    dwFlags: DIDF_RELAXIS;                    //
    dwDataSize: Sizeof(TDIMouseState2);        // $14
    dwNumObjs: High(_c_dfDIMouse_Objects)+1;  // 11
    rgodf: @_c_dfDIMouse2_Objects[Low(_c_dfDIMouse2_Objects)]
  );


(****************************************************************************
 *
 *      DirectInput keyboard scan codes
 *
 ****************************************************************************)

const
  DIK_ESCAPE          = $01;
  DIK_1               = $02;
  DIK_2               = $03;
  DIK_3               = $04;
  DIK_4               = $05;
  DIK_5               = $06;
  DIK_6               = $07;
  DIK_7               = $08;
  DIK_8               = $09;
  DIK_9               = $0A;
  DIK_0               = $0B;
  DIK_MINUS           = $0C;    (* - on main keyboard *)
  DIK_EQUALS          = $0D;
  DIK_BACK            = $0E;    (* backspace *)
  DIK_TAB             = $0F;
  DIK_Q               = $10;
  DIK_W               = $11;
  DIK_E               = $12;
  DIK_R               = $13;
  DIK_T               = $14;
  DIK_Y               = $15;
  DIK_U               = $16;
  DIK_I               = $17;
  DIK_O               = $18;
  DIK_P               = $19;
  DIK_LBRACKET        = $1A;
  DIK_RBRACKET        = $1B;
  DIK_RETURN          = $1C;    (* Enter on main keyboard *)
  DIK_LCONTROL        = $1D;
  DIK_A               = $1E;
  DIK_S               = $1F;
  DIK_D               = $20;
  DIK_F               = $21;
  DIK_G               = $22;
  DIK_H               = $23;
  DIK_J               = $24;
  DIK_K               = $25;
  DIK_L               = $26;
  DIK_SEMICOLON       = $27;
  DIK_APOSTROPHE      = $28;
  DIK_GRAVE           = $29;    (* accent grave *)
  DIK_LSHIFT          = $2A;
  DIK_BACKSLASH       = $2B;
  DIK_Z               = $2C;
  DIK_X               = $2D;
  DIK_C               = $2E;
  DIK_V                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            