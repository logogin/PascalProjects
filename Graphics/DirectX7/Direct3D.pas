(*==========================================================================;
 *
 *  Copyright (C) 1995-1998 Microsoft Corporation.  All Rights Reserved.
 *
 *  Files:   d3dtypes.h d3dcaps.h d3d.h
 *
 *  DirectX 7.0 Delphi adaptation by Erik Unger
 *
 *  Modyfied: 19-Feb-2000
 *
 *  Download: http://www.delphi-jedi.org/DelphiGraphics/
 *  E-Mail: Erik.Unger@gmx.at
 *
 ***************************************************************************)

unit Direct3D;

{$MINENUMSIZE 4}
{$ALIGN ON}

interface

uses
  Windows,
  DirectDraw;

(* TD3DValue is the fundamental Direct3D fractional data type *)

type
  TRefClsID = TGUID;

type
  TD3DValue = Single;
  TD3DFixed = LongInt;
  float = TD3DValue;
  PD3DColor = ^TD3DColor;
  TD3DColor = DWORD;

function D3DVal(val: variant) : float;
function D3DDivide(a,b: double) : float;
function D3DMultiply(a,b: double) : float;

(*
 * Format of CI colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |         color index           |   fraction    |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define CI_GETALPHA(ci)    ((ci) >> 24)
function CI_GETALPHA(ci: DWORD) : DWORD;

// #define CI_GETINDEX(ci)    (((ci) >> 8) & 0xffff)
function CI_GETINDEX(ci: DWORD) : DWORD;

// #define CI_GETFRACTION(ci) ((ci) & 0xff)
function CI_GETFRACTION(ci: DWORD) : DWORD;

// #define CI_ROUNDINDEX(ci)  CI_GETINDEX((ci) + 0x80)
function CI_ROUNDINDEX(ci: DWORD) : DWORD;

// #define CI_MASKALPHA(ci)   ((ci) & 0xffffff)
function CI_MASKALPHA(ci: DWORD) : DWORD;

// #define CI_MAKE(a, i, f)    (((a) << 24) | ((i) << 8) | (f))
function CI_MAKE(a,i,f: DWORD) : DWORD;

(*
 * Format of RGBA colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGBA_GETALPHA(rgb)      ((rgb) >> 24)
function RGBA_GETALPHA(rgb: TD3DColor) : DWORD;

// #define RGBA_GETRED(rgb)        (((rgb) >> 16) & 0xff)
function RGBA_GETRED(rgb: TD3DColor) : DWORD;

// #define RGBA_GETGREEN(rgb)      (((rgb) >> 8) & 0xff)
function RGBA_GETGREEN(rgb: TD3DColor) : DWORD;

// #define RGBA_GETBLUE(rgb)       ((rgb) & 0xff)
function RGBA_GETBLUE(rgb: TD3DColor) : DWORD;

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD) : TD3DColor;

(* D3DRGB and D3DRGBA may be used as initialisers for D3DCOLORs
 * The float values must be in the range 0..1
 *)

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: float) : TD3DColor;

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: float) : TD3DColor;

(*
 * Format of RGB colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    ignored    |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGB_GETRED(rgb)         (((rgb) >> 16) & 0xff)
function RGB_GETRED(rgb: TD3DColor) : DWORD;

// #define RGB_GETGREEN(rgb)       (((rgb) >> 8) & 0xff)
function RGB_GETGREEN(rgb: TD3DColor) : DWORD;

// #define RGB_GETBLUE(rgb)        ((rgb) & 0xff)
function RGB_GETBLUE(rgb: TD3DColor) : DWORD;

// #define RGBA_SETALPHA(rgba, x) (((x) << 24) | ((rgba) & 0x00ffffff))
function RGBA_SETALPHA(rgba: TD3DColor; x: DWORD) : TD3DColor;

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD) : TD3DColor;

// #define RGBA_TORGB(rgba)       ((TD3DColor) ((rgba) & 0xffffff))
function RGBA_TORGB(rgba: TD3DColor) : TD3DColor;

// #define RGB_TORGBA(rgb)        ((TD3DColor) ((rgb) | 0xff000000))
function RGB_TORGBA(rgb: TD3DColor) : TD3DColor;

(*
 * Flags for Enumerate functions
 *)
const

(*
 * Stop the enumeration
 *)

  D3DENUMRET_CANCEL                        = DDENUMRET_CANCEL;

(*
 * Continue the enumeration
 *)

  D3DENUMRET_OK                            = DDENUMRET_OK;

type
  TD3DValidateCallback = function (lpUserArg: Pointer;
      dwOffset: DWORD): HResult; stdcall;
  TD3DEnumTextureFormatsCallback = function (var lpDdsd: TDDSurfaceDesc;
      lpContext: Pointer): HResult; stdcall;
  TD3DEnumPixelFormatsCallback = function (var lpDDPixFmt: TDDPixelFormat;
      lpContext: Pointer): HResult; stdcall;


  PD3DMaterialHandle = ^TD3DMaterialHandle;
  TD3DMaterialHandle = DWORD;

  PD3DTextureHandle = ^TD3DTextureHandle;
  TD3DTextureHandle = DWORD;

  PD3DMatrixHandle = ^TD3DMatrixHandle;
  TD3DMatrixHandle = DWORD;

  PD3DColorValue = ^TD3DColorValue;
  TD3DColorValue = packed record
    case Integer of
    0: (
      r: TD3DValue;
      g: TD3DValue;
      b: TD3DValue;
      a: TD3DValue;
     );
    1: (
      dvR: TD3DValue;
      dvG: TD3DValue;
      dvB: TD3DValue;
      dvA: TD3DValue;
     );
  end;

  PD3DRect = ^TD3DRect;
  TD3DRect = packed record
    case Integer of
    0: (
      x1: LongInt;
      y1: LongInt;
      x2: LongInt;
      y2: LongInt;
     );
    1: (
      lX1: LongInt;
      lY1: LongInt;
      lX2: LongInt;
      lY2: LongInt;
     );
     2: (
       a: array[0..3] of LongInt;
     );
  end;

  PD3DVector = ^TD3DVector;
  TD3DVector = packed record
    case Integer of
    0: (
      x: TD3DValue;
      y: TD3DValue;
      z: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
     );
  end;

(******************************************************************
 *                                                                *
 *   D3DVec.inl                                                   *
 *                                                                *
 *   Float-valued 3D vector class for Direct3D.                   *
 *                                                                *
 *   Copyright (c) 1996-1998 Microsoft Corp. All rights reserved. *
 *                                                                *
 ******************************************************************)

    // Addition and subtraction
  function VectorAdd(const v1, v2: TD3DVector) : TD3DVector;
  function VectorSub(const v1, v2: TD3DVector) : TD3DVector;
    // Scalar multiplication and division
  function VectorMulS(const v: TD3DVector; s: TD3DValue) : TD3DVector;
  function VectorDivS(const v: TD3DVector; s: TD3DValue) : TD3DVector;
    // Memberwise multiplication and division
  function VectorMul(const v1, v2: TD3DVector) : TD3DVector;
  function VectorDiv(const v1, v2: TD3DVector) : TD3DVector;
    // Vector dominance
  function VectorSmaller(v1, v2: TD3DVector) : boolean;
  function VectorSmallerEquel(v1, v2: TD3DVector) : boolean;
    // Bitwise equality
  function VectorEquel(v1, v2: TD3DVector) : boolean;
    // Length-related functions
  function VectorSquareMagnitude(v: TD3DVector) : TD3DValue;
  function VectorMagnitude(v: TD3DVector) : TD3DValue;
    // Returns vector with same direction and unit length
  function VectorNormalize(const v: TD3DVector) : TD3DVector;
    // Return min/max component of the input vector
  function VectorMin(v: TD3DVector) : TD3DValue;
  function VectorMax(v: TD3DVector) : TD3DValue;
    // Return memberwise min/max of input vectors
  function VectorMinimize(const v1, v2: TD3DVector) : TD3DVector;
  function VectorMaximize(const v1, v2: TD3DVector) : TD3DVector;
    // Dot and cross product
  function VectorDotProduct(v1, v2: TD3DVector) : TD3DValue;
  function VectorCrossProduct(const v1, v2: TD3DVector) : TD3DVector;

type
(*
 * Vertex data types supported in an ExecuteBuffer.
 *)

(*
 * Homogeneous vertices
 *)

  PD3DHVertex = ^TD3DHVertex;
  TD3DHVertex = packed record
    dwFlags: DWORD;        (* Homogeneous clipping flags *)
    case Integer of
    0: (
      hx: TD3DValue;
      hy: TD3DValue;
      hz: TD3DValue;
     );
    1: (
      dvHX: TD3DValue;
      dvHY: TD3DValue;
      dvHZ: TD3DValue;
     );
  end;

(*
 * Transformed/lit vertices
 *)

  PD3DTLVertex = ^TD3DTLVertex;
  TD3DTLVertex = packed record
    case Integer of
    0: (
      sx: TD3DValue;             (* Screen coordinates *)
      sy: TD3DValue;
      sz: TD3DValue;
      rhw: TD3DValue;            (* Reciprocal of homogeneous w *)
      color: TD3DColor;          (* Vertex color *)
      specular: TD3DColor;       (* Specular component of vertex *)
      tu: TD3DValue;             (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvSX: TD3DValue;
      dvSY: TD3DValue;
      dvSZ: TD3DValue;
      dvRHW: TD3DValue;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;

(*
 * Untransformed/lit vertices
 *)

  PD3DLVertex = ^TD3DLVertex;
  TD3DLVertex = packed record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      dwReserved: DWORD;
      color: TD3DColor;         (* Vertex color *)
      specular: TD3DColor;      (* Specular component of vertex *)
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      UNIONFILLER1d: DWORD;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;

(*
 * Untransformed/unlit vertices
 *)

  PD3DVertex = ^TD3DVertex;
  TD3DVertex = packed record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      nx: TD3DValue;            (* Normal *)
      ny: TD3DValue;
      nz: TD3DValue;
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      dvNX: TD3DValue;
      dvNY: TD3DValue;
      dvNZ: TD3DValue;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;

(*
 * Matrix, viewport, and tranformation structures and definitions.
 *)

  PD3DMatrix = ^TD3DMatrix;
  TD3DMatrix = packed record
    case integer of
      0 : (_11, _12, _13, _14: TD3DValue;
           _21, _22, _23, _24: TD3DValue;
           _31, _32, _33, _34: TD3DValue;
           _41, _42, _43, _44: TD3DValue);
      1 : (m : array [0..3, 0..3] of TD3DValue);
  end;

  PD3DViewport = ^TD3DViewport;
  TD3DViewport = packed record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Dimensions *)
    dvScaleX: TD3DValue;       (* Scale homogeneous to screen *)
    dvScaleY: TD3DValue;       (* Scale homogeneous to screen *)
    dvMaxX: TD3DValue;         (* Min/max homogeneous x coord *)
    dvMaxY: TD3DValue;         (* Min/max homogeneous y coord *)
    dvMinZ: TD3DValue;
    dvMaxZ: TD3DValue;         (* Min/max homogeneous z coord *)
  end;

  PD3DViewport2 = ^TD3DViewport2;
  TD3DViewport2 = packed record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvClipX: TD3DValue;	       (* Top left of clip volume *)
    dvClipY: TD3DValue;
    dvClipWidth: TD3DValue;    (* Clip Volume Dimensions *)
    dvClipHeight: TD3DValue;
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;

  PD3DViewport7 = ^TD3DViewport7;
  TD3DViewport7 = packed record
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;

(*
 * Values for clip fields.
 *)

const
// Max number of user clipping planes, supported in D3D.
  D3DMAXUSERCLIPPLANES  = 32;

// These bits could be ORed together to use with D3DRENDERSTATE_CLIPPLANEENABLE
//
  D3DCLIPPLANE0 = (1 shl 0);
  D3DCLIPPLANE1 = (1 shl 1);
  D3DCLIPPLANE2 = (1 shl 2);
  D3DCLIPPLANE3 = (1 shl 3);
  D3DCLIPPLANE4 = (1 shl 4);
  D3DCLIPPLANE5 = (1 shl 5);

const
  D3DCLIP_LEFT                            = $00000001;
  D3DCLIP_RIGHT                           = $00000002;
  D3DCLIP_TOP                             = $00000004;
  D3DCLIP_BOTTOM                          = $00000008;
  D3DCLIP_FRONT                           = $00000010;
  D3DCLIP_BACK                            = $00000020;
  D3DCLIP_GEN0                            = $00000040;
  D3DCLIP_GEN1                            = $00000080;
  D3DCLIP_GEN2                            = $00000100;
  D3DCLIP_GEN3                            = $00000200;
  D3DCLIP_GEN4                            = $00000400;
  D3DCLIP_GEN5                            = $00000800;

(*
 * Values for d3d status.
 *)

  D3DSTATUS_CLIPUNIONLEFT                 = D3DCLIP_LEFT;
  D3DSTATUS_CLIPUNIONRIGHT                = D3DCLIP_RIGHT;
  D3DSTATUS_CLIPUNIONTOP                  = D3DCLIP_TOP;
  D3DSTATUS_CLIPUNIONBOTTOM               = D3DCLIP_BOTTOM;
  D3DSTATUS_CLIPUNIONFRONT                = D3DCLIP_FRONT;
  D3DSTATUS_CLIPUNIONBACK                 = D3DCLIP_BACK;
  D3DSTATUS_CLIPUNIONGEN0                 = D3DCLIP_GEN0;
  D3DSTATUS_CLIPUNIONGEN1                 = D3DCLIP_GEN1;
  D3DSTATUS_CLIPUNIONGEN2                 = D3DCLIP_GEN2;
  D3DSTATUS_CLIPUNIONGEN3                 = D3DCLIP_GEN3;
  D3DSTATUS_CLIPUNIONGEN4                 = D3DCLIP_GEN4;
  D3DSTATUS_CLIPUNIONGEN5                 = D3DCLIP_GEN5;

  D3DSTATUS_CLIPINTERSECTIONLEFT          = $00001000;
  D3DSTATUS_CLIPINTERSECTIONRIGHT         = $00002000;
  D3DSTATUS_CLIPINTERSECTIONTOP           = $00004000;
  D3DSTATUS_CLIPINTERSECTIONBOTTOM        = $00008000;
  D3DSTATUS_CLIPINTERSECTIONFRONT         = $00010000;
  D3DSTATUS_CLIPINTERSECTIONBACK          = $00020000;
  D3DSTATUS_CLIPINTERSECTIONGEN0          = $00040000;
  D3DSTATUS_CLIPINTERSECTIONGEN1          = $00080000;
  D3DSTATUS_CLIPINTERSECTIONGEN2          = $00100000;
  D3DSTATUS_CLIPINTERSECTIONGEN3          = $00200000;
  D3DSTATUS_CLIPINTERSECTIONGEN4          = $00400000;
  D3DSTATUS_CLIPINTERSECTIONGEN5          = $00800000;
  D3DSTATUS_ZNOTVISIBLE                   = $01000000;
(* Do not use 0x80000000 for any status flags in future as it is reserved *)

  D3DSTATUS_CLIPUNIONALL = (
            D3DSTATUS_CLIPUNIONLEFT or
            D3DSTATUS_CLIPUNIONRIGHT or
            D3DSTATUS_CLIPUNIONTOP or
            D3DSTATUS_CLIPUNIONBOTTOM or
            D3DSTATUS_CLIPUNIONFRONT or
            D3DSTATUS_CLIPUNIONBACK or
            D3DSTATUS_CLIPUNIONGEN0 or
            D3DSTATUS_CLIPUNIONGEN1 or
            D3DSTATUS_CLIPUNIONGEN2 or
            D3DSTATUS_CLIPUNIONGEN3 or
            D3DSTATUS_CLIPUNIONGEN4 or
            D3DSTATUS_CLIPUNIONGEN5);

  D3DSTATUS_CLIPINTERSECTIONALL = (
            D3DSTATUS_CLIPINTERSECTIONLEFT or
            D3DSTATUS_CLIPINTERSECTIONRIGHT or
            D3DSTATUS_CLIPINTERSECTIONTOP or
            D3DSTATUS_CLIPINTERSECTIONBOTTOM or
            D3DSTATUS_CLIPINTERSECTIONFRONT or
            D3DSTATUS_CLIPINTERSECTIONBACK or
            D3DSTATUS_CLIPINTERSECTIONGEN0 or
            D3DSTATUS_CLIPINTERSECTIONGEN1 or
            D3DSTATUS_CLIPINTERSECTIONGEN2 or
            D3DSTATUS_CLIPINTERSECTIONGEN3 or
            D3DSTATUS_CLIPINTERSECTIONGEN4 or
            D3DSTATUS_CLIPINTERSECTIONGEN5);

  D3DSTATUS_DEFAULT = (
            D3DSTATUS_CLIPINTERSECTIONALL or
            D3DSTATUS_ZNOTVISIBLE);

(*
 * Options for direct transform calls
 *)

  D3DTRANSFORM_CLIPPED       = $00000001;
  D3DTRANSFORM_UNCLIPPED     = $00000002;

type
  PD3DTransformData = ^TD3DTransformData;
  TD3DTransformData = packed record
    dwSize: DWORD;
    lpIn: Pointer;             (* Input vertices *)
    dwInSize: DWORD;           (* Stride of input vertices *)
    lpOut: Pointer;            (* Output vertices *)
    dwOutSize: DWORD;          (* Stride of output vertices *)
    lpHOut: ^TD3DHVertex;       (* Output homogeneous vertices *)
    dwClip: DWORD;             (* Clipping hint *)
    dwClipIntersection: DWORD;
    dwClipUnion: DWORD;        (* Union of all clip flags *)
    drExtent: TD3DRect;         (* Extent of transformed vertices *)
  end;

(*
 * Structure defining position and direction properties for lighting.
 *)

  PD3DLightingElement = ^TD3DLightingElement;
  TD3DLightingElement = packed record
    dvPosition: TD3DVector;           (* Lightable point in model space *)
    dvNormal: TD3DVector;             (* Normalised unit vector *)
  end;

(*
 * Structure defining material properties for lighting.
 *)

  PD3DMaterial = ^TD3DMaterial;
  TD3DMaterial = packed record
    dwSize: DWORD;
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
      hTexture: TD3DTextureHandle;    (* Handle to texture map *)
      dwRampSize: DWORD;
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;

  PD3DMaterial7 = ^TD3DMaterial7;
  TD3DMaterial7 = packed record
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;

  PD3DLightType = ^TD3DLightType;
  TD3DLightType = (
    D3DLIGHT_INVALID_0,
    D3DLIGHT_POINT,
    D3DLIGHT_SPOT,
    D3DLIGHT_DIRECTIONAL,
// Note: The following light type (D3DLIGHT_PARALLELPOINT)
// is no longer supported from D3D for DX7 onwards.
    D3DLIGHT_PARALLELPOINT,
    D3DLIGHT_GLSPOT);

(*
 * Structure defining a light source and its properties.
 *)

  PD3DLight = ^TD3DLight;
  TD3DLight = packed record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;

  PD3DLight7 = ^TD3DLight7;
  TD3DLight7 = packed record
    dltType: TD3DLightType;     (* Type of light source *)
    dcvDiffuse: TD3DColorValue; (* Diffuse color of light *)
    dcvSpecular: TD3DColorValue;(* Specular color of light *)
    dcvAmbient: TD3DColorValue; (* Ambient color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;

(*
 * Structure defining a light source and its properties.
 *)

(* flags bits *)
const
  D3DLIGHT_ACTIVE		  	= $00000001;
  D3DLIGHT_NO_SPECULAR  = $00000002;
  D3DLIGHT_ALL = D3DLIGHT_ACTIVE or D3DLIGHT_ACTIVE;

(* maximum valid light range *)
  D3DLIGHT_RANGE_MAX		= 1.8439088915e+18; //sqrt(FLT_MAX);

type
  PD3DLight2 = ^TD3DLight2;
  TD3DLight2 = packed record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
    dwFlags: DWORD;
  end;

  PD3DLightData = ^TD3DLightData;
  TD3DLightData = packed record
    dwSize: DWORD;
    lpIn: ^TD3DLightingElement;   (* Input positions and normals *)
    dwInSize: DWORD;             (* Stride of input elements *)
    lpOut: ^TD3DTLVertex;         (* Output colors *)
    dwOutSize: DWORD;            (* Stride of output colors *)
  end;

(*
 * Before DX5, these values were in an enum called
 * TD3DColorModel. This was not correct, since they are
 * bit flags. A driver can surface either or both flags
 * in the dcmColorModel member of D3DDEVICEDESC.
 *)

type
  TD3DColorModel = DWORD;
 
const
  D3DCOLOR_MONO = 1;
  D3DCOLOR_RGB  = 2;

(*
 * Options for clearing
 *)

const
  D3DCLEAR_TARGET            = $00000001; (* Clear target surface *)
  D3DCLEAR_ZBUFFER           = $00000002; (* Clear target z buffer *)
  D3DCLEAR_STENCIL           = $00000004; (* Clear stencil planes *)

(*
 * Execute buffers are allocated via Direct3D.  These buffers may then
 * be filled by the application with instructions to execute along with
 * vertex data.
 *)

(*
 * Supported op codes for execute instructions.
 *)

type
  PD3DOpcode = ^TD3DOpcode;
  TD3DOpcode = (
    D3DOP_INVALID_0,
    D3DOP_POINT,
    D3DOP_LINE,
    D3DOP_TRIANGLE,
    D3DOP_MATRIXLOAD,
    D3DOP_MATRIXMULTIPLY,
    D3DOP_STATETRANSFORM,
    D3DOP_STATELIGHT,
    D3DOP_STATERENDER,
    D3DOP_PROCESSVERTICES,
    D3DOP_TEXTURELOAD,
    D3DOP_EXIT,
    D3DOP_BRANCHFORWARD,
    D3DOP_SPAN,
    D3DOP_SETSTATUS);

  PD3DInstruction = ^TD3DInstruction;
  TD3DInstruction = packed record
    bOpcode: BYTE;   (* Instruction opcode *)
    bSize: BYTE;     (* Size of each instruction data unit *)
    wCount: WORD;    (* Count of instruction data units to follow *)
  end;

(*
 * Structure for texture loads
 *)

  PD3DTextureLoad = ^TD3DTextureLoad;
  TD3DTextureLoad = packed record
    hDestTexture: TD3DTextureHandle;
    hSrcTexture: TD3DTextureHandle;
  end;

(*
 * Structure for picking
 *)

  PD3DPickRecord = ^TD3DPickRecord;
  TD3DPickRecord = packed record
    bOpcode: BYTE;
    bPad: BYTE;
    dwOffset: DWORD;
    dvZ: TD3DValue;
  end;

(*
 * The following defines the rendering states which can be set in the
 * execute buffer.
 *)

  PD3DShadeMode = ^TD3DShadeMode;
  TD3DShadeMode = (
    D3DSHADE_INVALID_0,
    D3DSHADE_FLAT,
    D3DSHADE_GOURAUD,
    D3DSHADE_PHONG);

  PD3DFillMode = ^TD3DFillMode;
  TD3DFillMode = (
    D3DFILL_INVALID_0,
    D3DFILL_POINT,
    D3DFILL_WIREFRAME,
    D3DFILL_SOLID);

  PD3DLinePattern = ^TD3DLinePattern;
  TD3DLinePattern = packed record
    wRepeatFactor: WORD;
    wLinePattern: WORD;
  end;

  PD3DTextureFilter = ^TD3DTextureFilter;
  TD3DTextureFilter = (
    D3DFILTER_INVALID_0,
    D3DFILTER_NEAREST,
    D3DFILTER_LINEAR,
    D3DFILTER_MIPNEAREST,
    D3DFILTER_MIPLINEAR,
    D3DFILTER_LINEARMIPNEAREST,
    D3DFILTER_LINEARMIPLINEAR);

  PD3DBlend = ^TD3DBlend;
  TD3DBlend = (
    D3DBLEND_INVALID_0,
    D3DBLEND_ZERO,
    D3DBLEND_ONE,
    D3DBLEND_SRCCOLOR,
    D3DBLEND_INVSRCCOLOR,
    D3DBLEND_SRCALPHA,
    D3DBLEND_INVSRCALPHA,
    D3DBLEND_DESTALPHA,
    D3DBLEND_INVDESTALPHA,
    D3DBLEND_DESTCOLOR,
    D3DBLEND_INVDESTCOLOR,
    D3DBLEND_SRCALPHASAT,
    D3DBLEND_BOTHSRCALPHA,
    D3DBLEND_BOTHINVSRCALPHA);

  PD3DTextureBlend = ^TD3DTextureBlend;
  TD3DTextureBlend = (
    D3DTBLEND_INVALID_0,
    D3DTBLEND_DECAL,
    D3DTBLEND_MODULATE,
    D3DTBLEND_DECALALPHA,
    D3DTBLEND_MODULATEALPHA,
    D3DTBLEND_DECALMASK,
    D3DTBLEND_MODULATEMASK,
    D3DTBLEND_COPY,
    D3DTBLEND_ADD);

  PD3DTextureAddress = ^TD3DTextureAddress;
  TD3DTextureAddress = (
    D3DTADDRESS_INVALID_0,
    D3DTADDRESS_WRAP,
    D3DTADDRESS_MIRROR,
    D3DTADDRESS_CLAMP,
    D3DTADDRESS_BORDER);

  PD3DCull = ^TD3DCull;
  TD3DCull = (
    D3DCULL_INVALID_0,
    D3DCULL_NONE,
    D3DCULL_CW,
    D3DCULL_CCW);

  PD3DCmpFunc = ^TD3DCmpFunc;
  TD3DCmpFunc = (
    D3DCMP_INVALID_0,
    D3DCMP_NEVER,
    D3DCMP_LESS,
    D3DCMP_EQUAL,
    D3DCMP_LESSEQUAL,
    D3DCMP_GREATER,
    D3DCMP_NOTEQUAL,
    D3DCMP_GREATEREQUAL,
    D3DCMP_ALWAYS);

  PD3DStencilOp = ^TD3DStencilOp;
  TD3DStencilOp = (
    D3DSTENCILOP_INVALID_0,
    D3DSTENCILOP_KEEP,
    D3DSTENCILOP_ZERO,
    D3DSTENCILOP_REPLACE,
    D3DSTENCILOP_INCRSAT,
    D3DSTENCILOP_DECRSAT,
    D3DSTENCILOP_INVERT,
    D3DSTENCILOP_INCR,
    D3DSTENCILOP_DECR);
    
  PD3DFogMode = ^TD3DFogMode;
  TD3DFogMode = (
    D3DFOG_NONE,
    D3DFOG_EXP,
    D3DFOG_EXP2,
    D3DFOG_LINEAR);

  PD3DZBufferType = ^TD3DZBufferType;
  TD3DZBufferType = (
    D3DZB_FALSE,
    D3DZB_TRUE,   // Z buffering
    D3DZB_USEW);  // W buffering

  PD3DAntialiasMode = ^TD3DAntialiasMode;
  TD3DAntialiasMode = (
    D3DANTIALIAS_NONE,
    D3DANTIALIAS_SORTDEPENDENT,
    D3DANTIALIAS_SORTINDEPENDENT);

// Vertex types supported by Direct3D
  PD3DVertexType = ^TD3DVertexType;
  TD3DVertexType = (
    D3DVT_INVALID_0,
    D3DVT_VERTEX,
    D3DVT_LVERTEX,
    D3DVT_TLVERTEX);

// Primitives supported by draw-primitive API
  PD3DPrimitiveType = ^TD3DPrimitiveType;
  TD3DPrimitiveType = (
    D3DPT_INVALID_0,
    D3DPT_POINTLIST,
    D3DPT_LINELIST,
    D3DPT_LINESTRIP,
    D3DPT_TRIANGLELIST,
    D3DPT_TRIANGLESTRIP,
    D3DPT_TRIANGLEFAN);

(*
 * Amount to add to a state to generate the override for that state.
 *)

const
  D3DSTATE_OVERRIDE_BIAS          = 256;

(*
 * A state which sets the override flag for the specified state type.
 *)

function D3DSTATE_OVERRIDE(StateType: DWORD) : DWORD;

type
  PD3DTransformStateType = ^TD3DTransformStateType;
  TD3DTransformStateType = DWORD;
const
  D3DTRANSFORMSTATE_WORLD         = 1;
  D3DTRANSFORMSTATE_VIEW          = 2;
  D3DTRANSFORMSTATE_PROJECTION    = 3;
  D3DTRANSFORMSTATE_WORLD1        = 4;  // 2nd matrix to blend
  D3DTRANSFORMSTATE_WORLD2        = 5;  // 3rd matrix to blend
  D3DTRANSFORMSTATE_WORLD3        = 6;  // 4th matrix to blend
  D3DTRANSFORMSTATE_TEXTURE0      = 16;
  D3DTRANSFORMSTATE_TEXTURE1      = 17;
  D3DTRANSFORMSTATE_TEXTURE2      = 18;
  D3DTRANSFORMSTATE_TEXTURE3      = 19;
  D3DTRANSFORMSTATE_TEXTURE4      = 20;
  D3DTRANSFORMSTATE_TEXTURE5      = 21;
  D3DTRANSFORMSTATE_TEXTURE6      = 22;
  D3DTRANSFORMSTATE_TEXTURE7      = 23;

type
  PD3DLightStateType = ^TD3DLightStateType;
  TD3DLightStateType = (
    D3DLIGHTSTATE_INVALID_0,
    D3DLIGHTSTATE_MATERIAL,
    D3DLIGHTSTATE_AMBIENT,
    D3DLIGHTSTATE_COLORMODEL,
    D3DLIGHTSTATE_FOGMODE,
    D3DLIGHTSTATE_FOGSTART,
    D3DLIGHTSTATE_FOGEND,
    D3DLIGHTSTATE_FOGDENSITY,
    D3DLIGHTSTATE_COLORVERTEX);

  PD3DRenderStateType = ^TD3DRenderStateType;
  TD3DRenderStateType = DWORD;
const
    D3DRENDERSTATE_ANTIALIAS          = 2;    (* D3DANTIALIASMODE *)
    D3DRENDERSTATE_TEXTUREPERSPECTIVE = 4;    (* TRUE for perspective correction *)
    D3DRENDERSTATE_ZENABLE            = 7;    (* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) *)
    D3DRENDERSTATE_FILLMODE           = 8;    (* D3DFILL_MODE        *)
    D3DRENDERSTATE_SHADEMODE          = 9;    (* D3DSHADEMODE *)
    D3DRENDERSTATE_LINEPATTERN        = 10;   (* D3DLINEPATTERN *)
    D3DRENDERSTATE_ZWRITEENABLE       = 14;   (* TRUE to enable z writes *)
    D3DRENDERSTATE_ALPHATESTENABLE    = 15;   (* TRUE to enable alpha tests *)
    D3DRENDERSTATE_LASTPIXEL          = 16;   (* TRUE for last-pixel on lines *)
    D3DRENDERSTATE_SRCBLEND           = 19;   (* D3DBLEND *)
    D3DRENDERSTATE_DESTBLEND          = 20;   (* D3DBLEND *)
    D3DRENDERSTATE_CULLMODE           = 22;   (* D3DCULL *)
    D3DRENDERSTATE_ZFUNC              = 23;   (* D3DCMPFUNC *)
    D3DRENDERSTATE_ALPHAREF           = 24;   (* D3DFIXED *)
    D3DRENDERSTATE_ALPHAFUNC          = 25;   (* D3DCMPFUNC *)
    D3DRENDERSTATE_DITHERENABLE       = 26;   (* TRUE to enable dithering *)
    D3DRENDERSTATE_ALPHABLENDENABLE   = 27;   (* TRUE to enable alpha blending *)
    D3DRENDERSTATE_FOGENABLE          = 28;   (* TRUE to enable fog blending *)
    D3DRENDERSTATE_SPECULARENABLE     = 29;   (* TRUE to enable specular *)
    D3DRENDERSTATE_ZVISIBLE           = 30;   (* TRUE to enable z checking *)
    D3DRENDERSTATE_STIPPLEDALPHA      = 33;   (* TRUE to enable stippled alpha (RGB device only) *)
    D3DRENDERSTATE_FOGCOLOR           = 34;   (* D3DCOLOR *)
    D3DRENDERSTATE_FOGTABLEMODE       = 35;   (* D3DFOGMODE *)
    D3DRENDERSTATE_FOGSTART           = 36;   (* Fog start (for both vertex and pixel fog) *)
    D3DRENDERSTATE_FOGEND             = 37;   (* Fog end      *)
    D3DRENDERSTATE_FOGDENSITY         = 38;   (* Fog density  *)
    D3DRENDERSTATE_EDGEANTIALIAS      = 40;   (* TRUE to enable edge antialiasing *)
    D3DRENDERSTATE_COLORKEYENABLE     = 41;   (* TRUE to enable source colorkeyed textures *)
    D3DRENDERSTATE_ZBIAS              = 47;   (* LONG Z bias *)
    D3DRENDERSTATE_RANGEFOGENABLE     = 48;   (* Enables range-based fog *)

    D3DRENDERSTATE_STENCILENABLE      = 52;   (* BOOL enable/disable stenciling *)
    D3DRENDERSTATE_STENCILFAIL        = 53;   (* D3DSTENCILOP to do if stencil test fails *)
    D3DRENDERSTATE_STENCILZFAIL       = 54;   (* D3DSTENCILOP to do if stencil test passes and Z test fails *)
    D3DRENDERSTATE_STENCILPASS        = 55;   (* D3DSTENCILOP to do if both stencil and Z tests pass *)
    D3DRENDERSTATE_STENCILFUNC        = 56;   (* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
    D3DRENDERSTATE_STENCILREF         = 57;   (* Reference value used in stencil test *)
    D3DRENDERSTATE_STENCILMASK        = 58;   (* Mask value used in stencil test *)
    D3DRENDERSTATE_STENCILWRITEMASK   = 59;   (* Write mask applied to values written to stencil buffer *)
    D3DRENDERSTATE_TEXTUREFACTOR      = 60;   (* D3DCOLOR used for multi-texture blend *)

    (*
     * 128 values [128; 255] are reserved for texture coordinate wrap flags.
     * These are constructed with the D3DWRAP_U and D3DWRAP_V macros. Using
     * a flags word preserves forward compatibility with texture coordinates
     * that are >2D.
     *)
    D3DRENDERSTATE_WRAP0              = 128;  (* wrap for 1st texture coord. set *)
    D3DRENDERSTATE_WRAP1              = 129;  (* wrap for 2nd texture coord. set *)
    D3DRENDERSTATE_WRAP2              = 130;  (* wrap for 3rd texture coord. set *)
    D3DRENDERSTATE_WRAP3              = 131;  (* wrap for 4th texture coord. set *)
    D3DRENDERSTATE_WRAP4              = 132;  (* wrap for 5th texture coord. set *)
    D3DRENDERSTATE_WRAP5              = 133;  (* wrap for 6th texture coord. set *)
    D3DRENDERSTATE_WRAP6              = 134;  (* wrap for 7th texture coord. set *)
    D3DRENDERSTATE_WRAP7              = 135;  (* wrap for 8th texture coord. set *)
    D3DRENDERSTATE_CLIPPING            = 136;
    D3DRENDERSTATE_LIGHTING            = 137;
    D3DRENDERSTATE_EXTENTS             = 138;
    D3DRENDERSTATE_AMBIENT             = 139;
    D3DRENDERSTATE_FOGVERTEXMODE       = 140;
    D3DRENDERSTATE_COLORVERTEX         = 141;
    D3DRENDERSTATE_LOCALVIEWER         = 142;
    D3DRENDERSTATE_NORMALIZENORMALS    = 143;
    D3DRENDERSTATE_COLORKEYBLENDENABLE = 144;
    D3DRENDERSTATE_DIFFUSEMATERIALSOURCE    = 145;
    D3DRENDERSTATE_SPECULARMATERIALSOURCE   = 146;
    D3DRENDERSTATE_AMBIENTMATERIALSOURCE    = 147;
    D3DRENDERSTATE_EMISSIVEMATERIALSOURCE   = 148;
    D3DRENDERSTATE_VERTEXBLEND              = 151;
    D3DRENDERSTATE_CLIPPLANEENABLE          = 152;

//
// retired renderstates - not supported for DX7 interfaces
//
    D3DRENDERSTATE_TEXTUREHANDLE      = 1;    (* Texture handle for legacy interfaces (Texture;Texture2) *)
    D3DRENDERSTATE_TEXTUREADDRESS     = 3;    (* D3DTEXTUREADDRESS  *)
    D3DRENDERSTATE_WRAPU              = 5;    (* TRUE for wrapping in u *)
    D3DRENDERSTATE_WRAPV              = 6;    (* TRUE for wrapping in v *)
    D3DRENDERSTATE_MONOENABLE         = 11;   (* TRUE to enable mono rasterization *)
    D3DRENDERSTATE_ROP2               = 12;   (* ROP2 *)
    D3DRENDERSTATE_PLANEMASK          = 13;   (* DWORD physical plane mask *)
    D3DRENDERSTATE_TEXTUREMAG         = 17;   (* D3DTEXTUREFILTER *)
    D3DRENDERSTATE_TEXTUREMIN         = 18;   (* D3DTEXTUREFILTER *)
    D3DRENDERSTATE_TEXTUREMAPBLEND    = 21;   (* D3DTEXTUREBLEND *)
    D3DRENDERSTATE_SUBPIXEL           = 31;   (* TRUE to enable subpixel correction *)
    D3DRENDERSTATE_SUBPIXELX          = 32;   (* TRUE to enable correction in X only *)
    D3DRENDERSTATE_STIPPLEENABLE      = 39;   (* TRUE to enable stippling *)
    D3DRENDERSTATE_BORDERCOLOR        = 43;   (* Border color for texturing w/border *)
    D3DRENDERSTATE_TEXTUREADDRESSU    = 44;   (* Texture addressing mode for U coordinate *)
    D3DRENDERSTATE_TEXTUREADDRESSV    = 45;   (* Texture addressing mode for V coordinate *)
    D3DRENDERSTATE_MIPMAPLODBIAS      = 46;   (* D3DVALUE Mipmap LOD bias *)
    D3DRENDERSTATE_ANISOTROPY         = 49;   (* Max. anisotropy. 1 = no anisotropy *)
    D3DRENDERSTATE_FLUSHBATCH         = 50;   (* Explicit flush for DP batching (DX5 Only) *)
    D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT=51; (* BOOL enable sort-independent transparency *)
    D3DRENDERSTATE_STIPPLEPATTERN00   = 64;   (* Stipple pattern 01...  *)
    D3DRENDERSTATE_STIPPLEPATTERN01   = 65;
    D3DRENDERSTATE_STIPPLEPATTERN02   = 66;
    D3DRENDERSTATE_STIPPLEPATTERN03   = 67;
    D3DRENDERSTATE_STIPPLEPATTERN04   = 68;
    D3DRENDERSTATE_STIPPLEPATTERN05   = 69;
    D3DRENDERSTATE_STIPPLEPATTERN06   = 70;
    D3DRENDERSTATE_STIPPLEPATTERN07   = 71;
    D3DRENDERSTATE_STIPPLEPATTERN08   = 72;
    D3DRENDERSTATE_STIPPLEPATTERN09   = 73;
    D3DRENDERSTATE_STIPPLEPATTERN10   = 74;
    D3DRENDERSTATE_STIPPLEPATTERN11   = 75;
    D3DRENDERSTATE_STIPPLEPATTERN12   = 76;
    D3DRENDERSTATE_STIPPLEPATTERN13   = 77;
    D3DRENDERSTATE_STIPPLEPATTERN14   = 78;
    D3DRENDERSTATE_STIPPLEPATTERN15   = 79;
    D3DRENDERSTATE_STIPPLEPATTERN16   = 80;
    D3DRENDERSTATE_STIPPLEPATTERN17   = 81;
    D3DRENDERSTATE_STIPPLEPATTERN18   = 82;
    D3DRENDERSTATE_STIPPLEPATTERN19   = 83;
    D3DRENDERSTATE_STIPPLEPATTERN20   = 84;
    D3DRENDERSTATE_STIPPLEPATTERN21   = 85;
    D3DRENDERSTATE_STIPPLEPATTERN22   = 86;
    D3DRENDERSTATE_STIPPLEPATTERN23   = 87;
    D3DRENDERSTATE_STIPPLEPATTERN24   = 88;
    D3DRENDERSTATE_STIPPLEPATTERN25   = 89;
    D3DRENDERSTATE_STIPPLEPATTERN26   = 90;
    D3DRENDERSTATE_STIPPLEPATTERN27   = 91;
    D3DRENDERSTATE_STIPPLEPATTERN28   = 92;
    D3DRENDERSTATE_STIPPLEPATTERN29   = 93;
    D3DRENDERSTATE_STIPPLEPATTERN30   = 94;
    D3DRENDERSTATE_STIPPLEPATTERN31   = 95;

//
// retired renderstate names - the values are still used under new naming conventions
//
    D3DRENDERSTATE_FOGTABLESTART      = 36;   (* Fog table start    *)
    D3DRENDERSTATE_FOGTABLEEND        = 37;   (* Fog table end      *)
    D3DRENDERSTATE_FOGTABLEDENSITY    = 38;   (* Fog table density  *)

type
// Values for material source
  PD3DMateralColorSource = ^TD3DMateralColorSource;
  TD3DMateralColorSource = (
    D3DMCS_MATERIAL,              // Color from material is used
    D3DMCS_COLOR1,                // Diffuse vertex color is used
    D3DMCS_COLOR2                 // Specular vertex color is used
  );

const
  // For back-compatibility with legacy compilations
  D3DRENDERSTATE_BLENDENABLE = D3DRENDERSTATE_ALPHABLENDENABLE;


// Bias to apply to the texture coordinate set to apply a wrap to.
   D3DRENDERSTATE_WRAPBIAS                = 128;

(* Flags to construct the WRAP render states *)
  D3DWRAP_U   = $00000001;
  D3DWRAP_V   = $00000002;

(* Flags to construct the WRAP render states for 1D thru 4D texture coordinates *)
  D3DWRAPCOORD_0   = $00000001;    // same as D3DWRAP_U
  D3DWRAPCOORD_1   = $00000002;    // same as D3DWRAP_V
  D3DWRAPCOORD_2   = $00000004;
  D3DWRAPCOORD_3   = $00000008;

function D3DRENDERSTATE_STIPPLEPATTERN(y: integer) : TD3DRenderStateType;

type
  PD3DState = ^TD3DState;
  TD3DState = packed record
    case Integer of
    0: (
      dtstTransformStateType: TD3DTransformStateType;
      dwArg: Array [ 0..0 ] of DWORD;
     );
    1: (
      dlstLightStateType: TD3DLightStateType;
      dvArg: Array [ 0..0 ] of TD3DValue;
     );
    2: (
      drstRenderStateType: TD3DRenderStateType;
     );
  end;

(*
 * Operation used to load matrices
 * hDstMat = hSrcMat
 *)
  PD3DMatrixLoad = ^TD3DMatrixLoad;
  TD3DMatrixLoad = packed record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix: TD3DMatrixHandle;    (* Source matrix *)
  end;

(*
 * Operation used to multiply matrices
 * hDstMat = hSrcMat1 * hSrcMat2
 *)
  PD3DMatrixMultiply = ^TD3DMatrixMultiply;
  TD3DMatrixMultiply = packed record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix1: TD3DMatrixHandle;   (* First source matrix *)
    hSrcMatrix2: TD3DMatrixHandle;   (* Second source matrix *)
  end;

(*
 * Operation used to transform and light vertices.
 *)
  PD3DProcessVertices = ^TD3DProcessVertices;
  TD3DProcessVertices = packed record
    dwFlags: DWORD;           (* Do we transform or light or just copy? *)
    wStart: WORD;             (* Index to first vertex in source *)
    wDest: WORD;              (* Index to first vertex in local buffer *)
    dwCount: DWORD;           (* Number of vertices to be processed *)
    dwReserved: DWORD;        (* Must be zero *)
  end;

const
  D3DPROCESSVERTICES_TRANSFORMLIGHT       = $00000000;
  D3DPROCESSVERTICES_TRANSFORM            = $00000001;
  D3DPROCESSVERTICES_COPY                 = $00000002;
  D3DPROCESSVERTICES_OPMASK               = $00000007;

  D3DPROCESSVERTICES_UPDATEEXTENTS        = $00000008;
  D3DPROCESSVERTICES_NOCOLOR              = $00000010;


(*
 * State enumerants for per-stage texture processing.
 *)
type
  PD3DTextureStageStateType = ^TD3DTextureStageStateType;
  TD3DTextureStageStateType = DWORD;
const
  D3DTSS_COLOROP        =  1; (* D3DTEXTUREOP - per-stage blending controls for color channels *)
  D3DTSS_COLORARG1      =  2; (* D3DTA_* (texture arg) *)
  D3DTSS_COLORARG2      =  3; (* D3DTA_* (texture arg) *)
  D3DTSS_ALPHAOP        =  4; (* D3DTEXTUREOP - per-stage blending controls for alpha channel *)
  D3DTSS_ALPHAARG1      =  5; (* D3DTA_* (texture arg) *)
  D3DTSS_ALPHAARG2      =  6; (* D3DTA_* (texture arg) *)
  D3DTSS_BUMPENVMAT00   =  7; (* D3DVALUE (bump mapping matrix) *)
  D3DTSS_BUMPENVMAT01   =  8; (* D3DVALUE (bump mapping matrix) *)
  D3DTSS_BUMPENVMAT10   =  9; (* D3DVALUE (bump mapping matrix) *)
  D3DTSS_BUMPENVMAT11   = 10; (* D3DVALUE (bump mapping matrix) *)
  D3DTSS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              