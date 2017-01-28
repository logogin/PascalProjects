(*==========================================================================;
 *
 *  Copyright (C) 1994-1997 Microsoft Corporation.  All Rights Reserved.
 *
 *  Files:	D3DRMDef.h D3DRMObj.h D3DRM.h D3DRMWin.h RMXFGUID.h RMXFTmpl.h
 *  Content:	Direct3D Retained Mode include files
 *
 *  DirectX 7.0 Delphi adaptation by Erik Unger
 *
 *  Modified: 30-Apr-2000
 *
 *  Download: http://www.delphi-jedi.org/DelphiGraphics/
 *  E-Mail: Erik.Unger@gmx.at
 *
 *
 ***************************************************************************)

unit Direct3DRM;

interface

{$MINENUMSIZE 4}
{$ALIGN ON}

uses
  Windows,
  DirectDraw,
  Direct3D;

var
  D3DRMDLL : HMODULE = 0;

(*==========================================================================;
 *
 *  Copyright (C) 1995-1997 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3drmdef.h
 *  Content:    Direct3DRM include file
 *
 ***************************************************************************)

type
  PD3DRMVector4D = ^TD3DRMVector4D;
  TD3DRMVector4D = packed record
    x, y, z, w: TD3DValue;
  end;

  PD3DRMMatrix4D = ^TD3DRMMatrix4D;
  TD3DRMMatrix4D = array [0..3, 0..3] of TD3DValue;

  PD3DRMQuaternion = ^TD3DRMQuaternion;
  TD3DRMQuaternion = packed record
    s: TD3DValue;
    v: TD3DVector;
  end;

  PD3DRMRay = ^TD3DRMRay;
  TD3DRMRay = packed record
    dvDir: TD3DVector;
    dvPos: TD3DVector;
  end;

  PD3DRMBox = ^TD3DRMBox;
  TD3DRMBox = packed record
    min, max: TD3DVector;
  end;

  TD3DRMWrapCallback = procedure (var lpD3DVector: TD3DVector;
      var lpU, lpV: Integer; var lpD3DRMVA, lpD3DRMVB: TD3DVector; lpArg:
      Pointer); stdcall; // unused ?

  PD3DRMLightType = ^TD3DRMLightType; // is it 16 or 32 bit ?
  TD3DRMLightType = (
    D3DRMLIGHT_AMBIENT,
    D3DRMLIGHT_POINT,
    D3DRMLIGHT_SPOT,
    D3DRMLIGHT_DIRECTIONAL,
    D3DRMLIGHT_PARALLELPOINT
  );

  PD3DRMShadeMode = ^TD3DRMShadeMode;
  TD3DRMShadeMode = WORD;

const
  D3DRMSHADE_FLAT = 0;
  D3DRMSHADE_GOURAUD = 1;
  D3DRMSHADE_PHONG = 2;
  D3DRMSHADE_MASK = 7;
  D3DRMSHADE_MAX = 8;

type
  PD3DRMLightMode = ^TD3DRMLightMode;
  TD3DRMLightMode = WORD;

const
  D3DRMLIGHT_OFF  = 0 * D3DRMSHADE_MAX;
  D3DRMLIGHT_ON   = 1 * D3DRMSHADE_MAX;
  D3DRMLIGHT_MASK = 7 * D3DRMSHADE_MAX;
  D3DRMLIGHT_MAX  = 8 * D3DRMSHADE_MAX;

type
  PD3DRMFillMode = ^TD3DRMFillMode;
  TD3DRMFillMode = WORD;

const
  D3DRMFILL_POINTS    = 0 * D3DRMLIGHT_MAX;
  D3DRMFILL_WIREFRAME = 1 * D3DRMLIGHT_MAX;
  D3DRMFILL_SOLID     = 2 * D3DRMLIGHT_MAX;
  D3DRMFILL_MASK      = 7 * D3DRMLIGHT_MAX;
  D3DRMFILL_MAX       = 8 * D3DRMLIGHT_MAX;

type
  PD3DRMRenderQuality = ^TD3DRMRenderQuality;
  TD3DRMRenderQuality = DWORD;

const
  D3DRMRENDER_WIREFRAME   =
      (D3DRMSHADE_FLAT + D3DRMLIGHT_OFF + D3DRMFILL_WIREFRAME);
  D3DRMRENDER_UNLITFLAT   =
      (D3DRMSHADE_FLAT + D3DRMLIGHT_OFF + D3DRMFILL_SOLID);
  D3DRMRENDER_FLAT        =
      (D3DRMSHADE_FLAT + D3DRMLIGHT_ON + D3DRMFILL_SOLID);
  D3DRMRENDER_GOURAUD     =
      (D3DRMSHADE_GOURAUD + D3DRMLIGHT_ON + D3DRMFILL_SOLID);
  D3DRMRENDER_PHONG       =
      (D3DRMSHADE_PHONG + D3DRMLIGHT_ON + D3DRMFILL_SOLID);

  D3DRMRENDERMODE_BLENDEDTRANSPARENCY	=  1;
  D3DRMRENDERMODE_SORTEDTRANSPARENCY	=  2;
  D3DRMRENDERMODE_LIGHTINMODELSPACE     =  8;
  D3DRMRENDERMODE_VIEWDEPENDENTSPECULAR = 16;

type
  PD3DRMTextureQuality = ^TD3DRMTextureQuality;
  TD3DRMTextureQuality = (
    D3DRMTEXTURE_NEAREST,               (* choose nearest texel *)
    D3DRMTEXTURE_LINEAR,                (* interpolate 4 texels *)
    D3DRMTEXTURE_MIPNEAREST,            (* nearest texel in nearest mipmap  *)
    D3DRMTEXTURE_MIPLINEAR,             (* interpolate 2 texels from 2 mipmaps *)
    D3DRMTEXTURE_LINEARMIPNEAREST,      (* interpolate 4 texels in nearest mipmap *)
    D3DRMTEXTURE_LINEARMIPLINEAR        (* interpolate 8 texels from 2 mipmaps *)
  );

const
(*
 * Texture flags
 *)
  D3DRMTEXTURE_FORCERESIDENT          = $00000001; (* texture should be kept in video memory *)
  D3DRMTEXTURE_STATIC                 = $00000002; (* texture will not change *)
  D3DRMTEXTURE_DOWNSAMPLEPOINT        = $00000004; (* point filtering should be used when downsampling *)
  D3DRMTEXTURE_DOWNSAMPLEBILINEAR     = $00000008; (* bilinear filtering should be used when downsampling *)
  D3DRMTEXTURE_DOWNSAMPLEREDUCEDEPTH  = $00000010; (* reduce bit depth when downsampling *)
  D3DRMTEXTURE_DOWNSAMPLENONE         = $00000020; (* texture should never be downsampled *)
  D3DRMTEXTURE_CHANGEDPIXELS          = $00000040; (* pixels have changed *)
  D3DRMTEXTURE_CHANGEDPALETTE         = $00000080; (* palette has changed *)
  D3DRMTEXTURE_INVALIDATEONLY         = $00000100; (* dirty regions are invalid *)

(*
 * Shadow flags
 *)
   D3DRMSHADOW_TRUEALPHA               = $00000001; (* shadow should render without artifacts when true alpha is on *)

type
  PD3DRMCombineType = ^TD3DRMCombineType;
  TD3DRMCombineType = (
    D3DRMCOMBINE_REPLACE,
    D3DRMCOMBINE_BEFORE,
    D3DRMCOMBINE_AFTER
  );

  PD3DRMColorModel = ^TD3DRMColorModel;
  TD3DRMColorModel = TD3DColorModel;

  PD3DRMPaletteFlags = ^TD3DRMPaletteFlags;
  TD3DRMPaletteFlags = (
    D3DRMPALETTE_FREE,                  (* renderer may use this entry freely *)
    D3DRMPALETTE_READONLY,              (* fixed but may be used by renderer *)
    D3DRMPALETTE_RESERVED               (* may not be used by renderer *)
  );

  PD3DRMPaletteEntry = ^TD3DRMPaletteEntry;
  TD3DRMPaletteEntry = packed record
    red: Byte;          (* 0 .. 255 *)
    green: Byte;        (* 0 .. 255 *)
    blue: Byte;         (* 0 .. 255 *)
    flags: Byte;        (* one of D3DRMPALETTEFLAGS *)
  end;

  PD3DRMImage = ^TD3DRMImage;
  TD3DRMImage = packed record
    width, height: Integer;    (* width and height in pixels *)
    aspectx, aspecty: Integer; (* aspect ratio for non-square pixels *)
    depth: Integer;            (* bits per pixel *)
    rgb: Integer;              (* if false, pixels are indices into a
                                   palette otherwise, pixels encode
                                   RGB values. *)
    bytes_per_line: Integer;   (* number of bytes of memory for a
                                   scanline. This must be a multiple
                                   of 4. *)
    buffer1: Pointer;          (* memory to render into (first buffer). *)
    buffer2: Pointer;          (* second rendering buffer for double
                                   buffering, set to NULL for single
                                   buffering. *)
    red_mask: DWORD;
    green_mask: DWORD;
    blue_mask: DWORD;
    alpha_mask: DWORD;        (* if rgb is true, these are masks for
                                   the red, green and blue parts of a
                                   pixel.  Otherwise, these are masks
                                   for the significant bits of the
                                   red, green and blue elements in the
                                   palette.  For instance, most SVGA
                                   displays use 64 intensities of red,
                                   green and blue, so the masks should
                                   all be set to = $fc. *)
    palette_size: Integer;     (* number of entries in palette *)
    palette: PD3DRMPaletteEntry; (* description of the palette (only if
                                   rgb is false).  Must be (1<<depth)
                                   elements. *)
  end;

  PD3DRMWrapType = ^TD3DRMWrapType;
  TD3DRMWrapType = (
    D3DRMWRAP_FLAT,
    D3DRMWRAP_CYLINDER,
    D3DRMWRAP_SPHERE,
    D3DRMWRAP_CHROME,
    D3DRMWRAP_SHEET,
    D3DRMWRAP_BOX
  );

const
  D3DRMWIREFRAME_CULL             = 1; (* cull backfaces *)
  D3DRMWIREFRAME_HIDDENLINE       = 2; (* lines are obscured by closer objects *)

type
(*
 * Do not use righthanded perspective in Viewport2::SetProjection().
 * Set up righthanded mode by using IDirect3DRM3::SetOptions().
 *)
  PD3DRMProjectionType = ^TD3DRMProjectionType;
  TD3DRMProjectionType = (
    D3DRMPROJECT_PERSPECTIVE,
    D3DRMPROJECT_ORTHOGRAPHIC,
    D3DRMPROJECT_RIGHTHANDPERSPECTIVE, (* Only valid pre-DX6 *)
    D3DRMPROJECT_RIGHTHANDORTHOGRAPHIC (* Only valid pre-DX6 *)
  );

const
  D3DRMOPTIONS_LEFTHANDED  = 00000001; (* Default *)
  D3DRMOPTIONS_RIGHTHANDED = 00000002;

type
  PD3DRMXOFFormat = ^TD3DRMXOFFormat;
  TD3DRMXOFFormat = (
    D3DRMXOF_BINARY,
    D3DRMXOF_COMPRESSED,
    D3DRMXOF_TEXT
  );

  TD3DRMSaveOptions = DWORD;
const
  D3DRMXOFSAVE_NORMALS = 1;
  D3DRMXOFSAVE_TEXTURECOORDINATES = 2;
  D3DRMXOFSAVE_MATERIALS = 4;
  D3DRMXOFSAVE_TEXTURENAMES = 8;
  D3DRMXOFSAVE_ALL = 15;
  D3DRMXOFSAVE_TEMPLATES = 16;
  D3DRMXOFSAVE_TEXTURETOPOLOGY = 32;

type
  PD3DRMColorSource = ^TD3DRMColorSource;
  TD3DRMColorSource = (
    D3DRMCOLOR_FROMFACE,
    D3DRMCOLOR_FROMVERTEX
  );

  PD3DRMFrameConstraint = ^TD3DRMFrameConstraint;
  TD3DRMFrameConstraint = (
    D3DRMCONSTRAIN_Z,           (* use only X and Y rotations *)
    D3DRMCONSTRAIN_Y,           (* use only X and Z rotations *)
    D3DRMCONSTRAIN_X            (* use only Y and Z rotations *)
  );

  PD3DRMMaterialMode = ^TD3DRMMaterialMode;
  TD3DRMMaterialMode = (
    D3DRMMATERIAL_FROMMESH,
    D3DRMMATERIAL_FROMPARENT,
    D3DRMMATERIAL_FROMFRAME
  );

  PD3DRMFogMode = ^TD3DRMFogMode;
  TD3DRMFogMode = (
    D3DRMFOG_LINEAR,            (* linear between start and end *)
    D3DRMFOG_EXPONENTIAL,       (* density * exp(-distance) *)
    D3DRMFOG_EXPONENTIALSQUARED (* density * exp(-distance*distance) *)
  );

  PD3DRMZBufferMode = ^TD3DRMZBufferMode;
  TD3DRMZBufferMode = (
    D3DRMZBUFFER_FROMPARENT,    (* default *)
    D3DRMZBUFFER_ENABLE,        (* enable zbuffering *)
    D3DRMZBUFFER_DISABLE        (* disable zbuffering *)
  );

  PD3DRMSortMode = ^TD3DRMSortMode;
  TD3DRMSortMode = (
    D3DRMSORT_FROMPARENT,       (* default *)
    D3DRMSORT_NONE,             (* don't sort child frames *)
    D3DRMSORT_FRONTTOBACK,      (* sort child frames front-to-back *)
    D3DRMSORT_BACKTOFRONT       (* sort child frames back-to-front *)
  );

  TD3DRMMaterialOverride = packed record
    dwSize : DWORD;       (* Size of this structure *)
    dwFlags : DWORD;      (* Indicate which fields are valid *)
    dcDiffuse : TD3DColorValue;    (* RGBA *)
    dcAmbient : TD3DColorValue;    (* RGB *)
    dcEmissive : TD3DColorValue;   (* RGB *)
    dcSpecular : TD3DColorValue;   (* RGB *)
    dvPower : TD3DValue;
    lpD3DRMTex : IUnknown;
  end;

const
  D3DRMMATERIALOVERRIDE_DIFFUSE_ALPHAONLY     = $00000001;
  D3DRMMATERIALOVERRIDE_DIFFUSE_RGBONLY       = $00000002;
  D3DRMMATERIALOVERRIDE_DIFFUSE               = $00000003;
  D3DRMMATERIALOVERRIDE_AMBIENT               = $00000004;
  D3DRMMATERIALOVERRIDE_EMISSIVE              = $00000008;
  D3DRMMATERIALOVERRIDE_SPECULAR              = $00000010;
  D3DRMMATERIALOVERRIDE_POWER                 = $00000020;
  D3DRMMATERIALOVERRIDE_TEXTURE               = $00000040;
  D3DRMMATERIALOVERRIDE_DIFFUSE_ALPHAMULTIPLY = $00000080;
  D3DRMMATERIALOVERRIDE_ALL                   = $000000FF;

  D3DRMFPTF_ALPHA                           = $00000001;
  D3DRMFPTF_NOALPHA                         = $00000002;
  D3DRMFPTF_PALETTIZED                      = $00000004;
  D3DRMFPTF_NOTPALETTIZED                   = $00000008;

  D3DRMSTATECHANGE_UPDATEONLY               = $000000001;
  D3DRMSTATECHANGE_VOLATILE                 = $000000002;
  D3DRMSTATECHANGE_NONVOLATILE              = $000000004;
  D3DRMSTATECHANGE_RENDER                   = $000000020;
  D3DRMSTATECHANGE_LIGHT                    = $000000040;

(*
 * Values for flags in RM3::CreateDeviceFromSurface
 *)
  D3DRMDEVICE_NOZBUFFER           = $00000001;

(*
 * Values for flags in Object2::SetClientData
 *)
  D3DRMCLIENTDATA_NONE            = $00000001;
  D3DRMCLIENTDATA_LOCALFREE       = $00000002;
  D3DRMCLIENTDATA_IUNKNOWN        = $00000004;

(*
 * Values for flags in Frame2::AddMoveCallback.
 *)
  D3DRMCALLBACK_PREORDER		= 0;
  D3DRMCALLBACK_POSTORDER		= 1;

(*
 * Values for flags in MeshBuilder2::RayPick.
 *)
  D3DRMRAYPICK_ONLYBOUNDINGBOXES	= 1;
  D3DRMRAYPICK_IGNOREFURTHERPRIMITIVES	= 2;
  D3DRMRAYPICK_INTERPOLATEUV		= 4;
  D3DRMRAYPICK_INTERPOLATECOLOR		= 8;
  D3DRMRAYPICK_INTERPOLATENORMAL        = $10;

(*
 * Values for flags in MeshBuilder3::AddFacesIndexed.
 *)
  D3DRMADDFACES_VERTICESONLY             = 1;

(*
 * Values for flags in MeshBuilder2::GenerateNormals.
 *)
  D3DRMGENERATENORMALS_PRECOMPACT	= 1;
  D3DRMGENERATENORMALS_USECREASEANGLE	= 2;

(*
 * Values for MeshBuilder3::GetParentMesh
 *)
  D3DRMMESHBUILDER_DIRECTPARENT          = 1;
  D3DRMMESHBUILDER_ROOTMESH              = 2;

(*
 * Flags for MeshBuilder3::Enable
 *)
  D3DRMMESHBUILDER_RENDERENABLE   = $00000001;
  D3DRMMESHBUILDER_PICKENABLE     = $00000002;

(*
 * Flags for Object2::GetAge when used with MeshBuilders
 *)
  D3DRMMESHBUILDERAGE_GEOMETRY    = $00000001;
  D3DRMMESHBUILDERAGE_MATERIALS   = $00000002;
  D3DRMMESHBUILDERAGE_TEXTURES    = $00000004;

(*
 * Format flags for MeshBuilder3::AddTriangles.
 *)
  D3DRMFVF_TYPE                   = $00000001;
  D3DRMFVF_NORMAL                 = $00000002;
  D3DRMFVF_COLOR                  = $00000004;
  D3DRMFVF_TEXTURECOORDS          = $00000008;

  D3DRMVERTEX_STRIP               = $00000001;
  D3DRMVERTEX_FAN                 = $00000002;
  D3DRMVERTEX_LIST                = $00000004;

(*
 * Values for flags in Viewport2::Clear2
 *)
  D3DRMCLEAR_TARGET               = $00000001;
  D3DRMCLEAR_ZBUFFER              = $00000002;
  D3DRMCLEAR_DIRTYRECTS           = $00000004;
  D3DRMCLEAR_ALL                  = (D3DRMCLEAR_TARGET or
                                         D3DRMCLEAR_ZBUFFER or
                                         D3DRMCLEAR_DIRTYRECTS);

(*
 * Values for flags in Frame3::SetSceneFogMethod
 *)
  D3DRMFOGMETHOD_VERTEX          = $00000001;
  D3DRMFOGMETHOD_TABLE           = $00000002;
  D3DRMFOGMETHOD_ANY             = $00000004;

(*
 * Values for flags in Frame3::SetTraversalOptions
 *)
  D3DRMFRAME_RENDERENABLE        = $00000001;
  D3DRMFRAME_PICKENABLE          = $00000002;

type
  TD3DRMAnimationOptions = DWORD;

const
  D3DRMANIMATION_OPEN = $01;
  D3DRMANIMATION_CLOSED = $02;
  D3DRMANIMATION_LINEARPOSITION = $04;
  D3DRMANIMATION_SPLINEPOSITION = $08;
  D3DRMANIMATION_SCALEANDROTATION = $00000010;
  D3DRMANIMATION_POSITION = $00000020;

type
  TD3DRMInterpolationOptions = DWORD;
const
  D3DRMINTERPOLATION_OPEN = $01;
  D3DRMINTERPOLATION_CLOSED = $02;
  D3DRMINTERPOLATION_NEAREST = $0100;
  D3DRMINTERPOLATION_LINEAR = $04;
  D3DRMINTERPOLATION_SPLINE = $08;
  D3DRMINTERPOLATION_VERTEXCOLOR = $40;
  D3DRMINTERPOLATION_SLERPNORMALS = $80;

type
  TD3DRMLoadOptions = DWORD;

const
  D3DRMLOAD_FROMFILE  = $00;
  D3DRMLOAD_FROMRESOURCE = $01;
  D3DRMLOAD_FROMMEMORY = $02;
  D3DRMLOAD_FROMSTREAM = $04;
  D3DRMLOAD_FROMURL = $08;

  D3DRMLOAD_BYNAME = $10;
  D3DRMLOAD_BYPOSITION = $20;
  D3DRMLOAD_BYGUID = $40;
  D3DRMLOAD_FIRST = $80;

  D3DRMLOAD_INSTANCEBYREFERENCE = $100;
  D3DRMLOAD_INSTANCEBYCOPYING = $200;

  D3DRMLOAD_ASYNCHRONOUS = $400;

type
  PD3DRMLoadResource = ^TD3DRMLoadResource;
  TD3DRMLoadResource = packed record
    hModule: HMODULE;
    lpName: PAnsiChar;
    lpType: PAnsiChar;
  end;

  PD3DRMLoadMemory = ^TD3DRMLoadMemory;
  TD3DRMLoadMemory = packed record
    lpMemory: Pointer;
    dwSize: DWORD;
  end;

const
  D3DRMPMESHSTATUS_VALID = $01;
  D3DRMPMESHSTATUS_INTERRUPTED = $02;
  D3DRMPMESHSTATUS_BASEMESHCOMPLETE = $04;
  D3DRMPMESHSTATUS_COMPLETE = $08;
  D3DRMPMESHSTATUS_RENDERABLE = $10;

  D3DRMPMESHEVENT_BASEMESH = $01;
  D3DRMPMESHEVENT_COMPLETE = $02;

type
  PD3DRMPMeshLoadStatus = ^TD3DRMPMeshLoadStatus;
  TD3DRMPMeshLoadStatus = packed record
    dwSize,            // Size of this structure
    dwPMeshSize,       // Total Size (bytes)
    dwBaseMeshSize,    // Total Size of the Base Mesh
    dwBytesLoaded,     // Total bytes loaded
    dwVerticesLoaded,  // Number of vertices loaded
    dwFacesLoaded : DWORD;     // Number of faces loaded
    dwLoadResult : HResult;    // Result of the load operation
    dwFlags : DWORD;
  end;

  PD3DRMUserVisualReason = ^TD3DRMUserVisualReason;
  TD3DRMUserVisualReason = (
    D3DRMUSERVISUAL_CANSEE,
    D3DRMUSERVISUAL_RENDER
  );

  PD3DRMAnimationKey = ^TD3DRMAnimationKey;
  TD3DRMAnimationKey = packed record
    dwSize : DWORD;
    dwKeyType : DWORD;
    dvTime : TD3DValue;
    dwID : DWORD;
    case integer of
      0 : (dqRotateKey : TD3DRMQuaternion);
      1 : (dvScaleKey : TD3DVector);
      2 : (dvPositionKey : TD3DVector);
      3 : (dvK : array [0..3] of TD3DValue);
    end;

procedure D3DRMAnimationGetRotateKey
    (var rmKey: TD3DRMAnimationKey; var rmQuat: TD3DRMQuaternion);

procedure D3DRMAnimationGetScaleKey
    (var rmKey: TD3DRMAnimationKey; var dvVec: TD3DVector);

procedure D3DRMAnimationGetPositionKey
    (var rmKey: TD3DRMAnimationKey; var dvVec: TD3DVector);

procedure D3DRMAnimatioSetRotateKey
    (var rmKey: TD3DRMAnimationKey; var rmQuat: TD3DRMQuaternion);

procedure D3DRMAnimationSetScaleKey
    (var rmKey: TD3DRMAnimationKey; var dvVec: TD3DVector);

procedure D3DRMAnimationSetPositionKey
    (var rmKey: TD3DRMAnimationKey; var dvVec: TD3DVector);

const
  D3DRMANIMATION_ROTATEKEY = 01;
  D3DRMANIMATION_SCALEKEY = 02;
  D3DRMANIMATION_POSITIONKEY = 03;

type
  TD3DRMMapping = DWORD;
  PD3DRMMappingFlag = ^TD3DRMMappingFlag;
  TD3DRMMappingFlag = DWORD;

const
  D3DRMMAP_WRAPU = 1;
  D3DRMMAP_WRAPV = 2;
  D3DRMMAP_PERSPCORRECT = 4;

type
  PD3DRMVertex = ^TD3DRMVertex;
  TD3DRMVertex = packed record
    position: TD3DVector;
    normal: TD3DVector;
    tu, tv: TD3DValue;
    color: TD3DColor;
  end;

  TD3DRMGroupIndex = LongInt; (* group indexes begin a 0 *)

const
  D3DRMGROUP_ALLGROUPS = -1;

var
(*
 * Create a color from three components in the range 0-1 inclusive.
 *)
  D3DRMCreateColorRGB : function (red, green, blue: TD3DValue) : TD3DColor;
      stdcall;

(*
 * Create a color from four components in the range 0-1 inclusive.
 *)
  D3DRMCreateColorRGBA : function (red, green, blue, alpha: TD3DValue)
      : TD3DColor; stdcall;

(*
 * Get the red component of a color.
 *)
  D3DRMColorGetRed : function (d3drmc: TD3DColor) : TD3DValue; stdcall;

(*
 * Get the green component of a color.
 *)
  D3DRMColorGetGreen : function (d3drmc: TD3DColor) : TD3DValue; stdcall;

(*
 * Get the blue component of a color.
 *)
  D3DRMColorGetBlue : function (d3drmc: TD3DColor) : TD3DValue; stdcall;

(*
 * Get the alpha component of a color.
 *)
  D3DRMColorGetAlpha : function (d3drmc: TD3DColor) : TD3DValue; stdcall;

(*
 * Add two vectors.  Returns its first argument.
 *)
  D3DRMVectorAdd : function (var d, s1, s2: TD3DVector) : PD3DVector; stdcall;

(*
 * Subtract two vectors.  Returns its first argument.
 *)
  D3DRMVectorSubtract : function (var d, s1, s2: TD3DVector) : PD3DVector;
      stdcall;

(*
 * Reflect a ray about a given normal.  Returns its first argument.
 *)
  D3DRMVectorReflect : function (var d, ray, norm: TD3DVector) : PD3DVector;
      stdcall;

(*
 * Calculate the vector cross product.  Returns its first argument.
 *)
  D3DRMVectorCrossProduct : function (var d, s1, s2: TD3DVector) : PD3DVector;
      stdcall;

(*
 * Return the vector dot product.
 *)
  D3DRMVectorDotProduct : function (var s1, s2: TD3DVector) : TD3DValue;
      stdcall;

(*
 * Scale a vector so that its modulus is 1.  Returns its argument or
 * NULL if there was an error (e.g. a zero vector was passed).
 *)
  D3DRMVectorNormalize : function (var lpv: TD3DVector) : PD3DVector; stdcall;

(*
 * Return the length of a vector (e.g. sqrt(x*x + y*y + z*z)).
 *)
  D3DRMVectorModulus : function (var v: TD3DVector) : TD3DValue; stdcall;

(*
 * Set the rotation part of a matrix to be a rotation of theta radians
 * around the given axis.
 *)
  D3DRMVectorRotate : function (var r, v, axis: TD3DVector; theta: TD3DValue) :
      PD3DVector; stdcall;

(*
 * Scale a vector uniformly in all three axes
 *)
  D3DRMVectorScale : function (var d, s: TD3DVector; factor: TD3DValue) :
      PD3DVector; stdcall;

(*
 * Return a random unit vector
 *)
  D3DRMVectorRandom : function (var d: TD3DVector) : PD3DVector; stdcall;

(*
 * Returns a unit quaternion that represents a rotation of theta radians
 * around the given axis.
 *)

  D3DRMQuaternionFromRotation : function (var quat: TD3DRMQuaternion;
      var v: TD3DVector; theta: TD3DValue) : PD3DRMQuaternion; stdcall;

(*
 * Calculate the product of two quaternions
 *)
  D3DRMQuaternionMultiply : function (var q, a, b: TD3DRMQuaternion) :
      PD3DRMQuaternion; stdcall;

(*
 * Interpolate between two quaternions
 *)
  D3DRMQuaternionSlerp : function (var q, a, b: TD3DRMQuaternion;
      alpha: TD3DValue) : PD3DRMQuaternion; stdcall;

(*
 * Calculate the matrix for the rotation that a unit quaternion represents
 *)
  D3DRMMatrixFromQuaternion : procedure (dmMat: TD3DRMMatrix4D; var lpDqQuat:
      TD3DRMQuaternion); stdcall;

(*
 * Calculate the quaternion that corresponds to a rotation matrix
 *)
  D3DRMQuaternionFromMatrix : function (var lpQuat: TD3DRMQuaternion;
      Mat: TD3DRMMatrix4D) : PD3DRMQuaternion; stdcall;

(*==========================================================================;
 *
 *  Copyright (C) 1995-1997 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3drmobj.h
 *  Content:    Direct3DRM include file
 *
 ***************************************************************************)

(*
 * Direct3DRM Object classes
 *)

const
  CLSID_CDirect3DRMDevice: TGUID =
      (D1:$4fa3568e;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMViewport: TGUID =
      (D1:$4fa3568f;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMFrame: TGUID =
      (D1:$4fa35690;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMMesh: TGUID =
      (D1:$4fa35691;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMMeshBuilder: TGUID =
      (D1:$4fa35692;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMFace: TGUID =
      (D1:$4fa35693;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMLight: TGUID =
      (D1:$4fa35694;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMTexture: TGUID =
      (D1:$4fa35695;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMWrap: TGUID =
      (D1:$4fa35696;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMMaterial: TGUID =
      (D1:$4fa35697;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMAnimation: TGUID =
      (D1:$4fa35698;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMAnimationSet: TGUID =
      (D1:$4fa35699;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMUserVisual: TGUID =
      (D1:$4fa3569a;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMShadow: TGUID =
      (D1:$4fa3569b;D2:$623f;D3:$11cf;D4:($ac,$4a,$00,$00,$c0,$38,$25,$a1));
  CLSID_CDirect3DRMViewportInterpolator: TGUID =
      (D1:$0de9eaa1;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMFrameInterpolator: TGUID =
      (D1:$0de9eaa2;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMMeshInterpolator: TGUID =
      (D1:$0de9eaa3;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMLightInterpolator: TGUID =
      (D1:$0de9eaa6;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMMaterialInterpolator: TGUID =
      (D1:$0de9eaa7;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMTextureInterpolator: TGUID =
      (D1:$0de9eaa8;D2:$3b84;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMProgressiveMesh: TGUID =
      (D1:$4516ec40;D2:$8f20;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  CLSID_CDirect3DRMClippedVisual: TGUID =
      (D1:$5434e72d;D2:$6d66;D3:$11d1;D4:($bb,$0b,$00,$00,$f8,$75,$86,$5a));



type
  IDirect3DRMObject = interface;
  IDirect3DRMDevice = interface;
  IDirect3DRMDevice2 = interface;
  IDirect3DRMDevice3 = interface;
  IDirect3DRMViewport = interface;
  IDirect3DRMViewport2 = interface;
  IDirect3DRMFrame = interface;
  IDirect3DRMFrame2 = interface;
  IDirect3DRMFrame3 = interface;
  IDirect3DRMVisual = interface;
  IDirect3DRMMesh = interface;
  IDirect3DRMMeshBuilder = interface;
  IDirect3DRMMeshBuilder2 = interface;
  IDirect3DRMMeshBuilder3 = interface;
  IDirect3DRMFace = interface;
  IDirect3DRMFace2 = interface;
  IDirect3DRMLight = interface;
  IDirect3DRMTexture = interface;
  IDirect3DRMTexture2 = interface;
  IDirect3DRMTexture3 = interface;
  IDirect3DRMWrap = interface;
  IDirect3DRMMaterial = interface;
  IDirect3DRMMaterial2 = interface;
  IDirect3DRMAnimation = interface;
  IDirect3DRMAnimation2 = interface;
  IDirect3DRMAnimationSet = interface;
  IDirect3DRMAnimationSet2 = interface;
  IDirect3DRMArray = interface;
  IDirect3DRMObjectArray = interface;
  IDirect3DRMDeviceArray = interface;
  IDirect3DRMViewportArray = interface;
  IDirect3DRMFrameArray = interface;
  IDirect3DRMVisualArray = interface;
  IDirect3DRMLightArray = interface;
  IDirect3DRMPickedArray = interface;
  IDirect3DRMFaceArray = interface;
  IDirect3DRMAnimationArray = interface;
  IDirect3DRMUserVisual = interface;
  IDirect3DRMShadow = interface;
  IDirect3DRMShadow2 = interface;
  IDirect3DRMInterpolator = interface;
  IDirect3DRMProgressiveMesh = interface;
  IDirect3DRMPicked2Array = interface;
  IDirect3DRMClippedVisual = interface;

(*
 * Direct3DRM Object interfaces
 *)
  IID_IDirect3DRMObject =          IDirect3DRMObject;
  IID_IDirect3DRMDevice =          IDirect3DRMDevice;
  IID_IDirect3DRMDevice2 =         IDirect3DRMDevice2;
  IID_IDirect3DRMDevice3 =         IDirect3DRMDevice3;
  IID_IDirect3DRMViewport =        IDirect3DRMViewport;
  IID_IDirect3DRMViewport2 =       IDirect3DRMViewport2;
  IID_IDirect3DRMFrame =           IDirect3DRMFrame;
  IID_IDirect3DRMFrame2 =          IDirect3DRMFrame2;
  IID_IDirect3DRMFrame3 =          IDirect3DRMFrame3;
  IID_IDirect3DRMVisual =          IDirect3DRMVisual;
  IID_IDirect3DRMMesh =            IDirect3DRMMesh;
  IID_IDirect3DRMMeshBuilder =     IDirect3DRMMeshBuilder;
  IID_IDirect3DRMMeshBuilder2 =    IDirect3DRMMeshBuilder2;
  IID_IDirect3DRMMeshBuilder3 =    IDirect3DRMMeshBuilder3;
  IID_IDirect3DRMFace =            IDirect3DRMFace;
  IID_IDirect3DRMFace2 =           IDirect3DRMFace2;
  IID_IDirect3DRMLight =           IDirect3DRMLight;
  IID_IDirect3DRMTexture =         IDirect3DRMTexture;
  IID_IDirect3DRMTexture2 =        IDirect3DRMTexture2;
  IID_IDirect3DRMTexture3 =        IDirect3DRMTexture3;
  IID_IDirect3DRMWrap =            IDirect3DRMWrap;
  IID_IDirect3DRMMaterial =        IDirect3DRMMaterial;
  IID_IDirect3DRMMaterial2 =       IDirect3DRMMaterial2;
  IID_IDirect3DRMAnimation =       IDirect3DRMAnimation;
  IID_IDirect3DRMAnimation2 =      IDirect3DRMAnimation2;
  IID_IDirect3DRMAnimationSet =    IDirect3DRMAnimationSet;
  IID_IDirect3DRMAnimationSet2 =   IDirect3DRMAnimationSet2;
  IID_IDirect3DRMObjectArray =     IDirect3DRMObjectArray;
  IID_IDirect3DRMDeviceArray =     IDirect3DRMDeviceArray;
  IID_IDirect3DRMViewportArray =   IDirect3DRMViewportArray;
  IID_IDirect3DRMFrameArray =      IDirect3DRMFrameArray;
  IID_IDirect3DRMVisualArray =     IDirect3DRMVisualArray;
  IID_IDirect3DRMLightArray =      IDirect3DRMLightArray;
  IID_IDirect3DRMPickedArray =     IDirect3DRMPickedArray;
  IID_IDirect3DRMFaceArray =       IDirect3DRMFaceArray;
  IID_IDirect3DRMAnimationArray =  IDirect3DRMAnimationArray;
  IID_IDirect3DRMUserVisual =      IDirect3DRMUserVisual;
  IID_IDirect3DRMShadow =          IDirect3DRMShadow;
  IID_IDirect3DRMShadow2 =         IDirect3DRMShadow2;
  IID_IDirect3DRMInterpolator =    IDirect3DRMInterpolator;
  IID_IDirect3DRMProgressiveMesh = IDirect3DRMProgressiveMesh;
  IID_IDirect3DRMPicked2Array =    IDirect3DRMPicked2Array;
  IID_IDirect3DRMClippedVisual =   IDirect3DRMClippedVisual;





  PIDirect3DRMFaceArray = ^IDirect3DRMFaceArray;

  TD3DRMObjectCallback = procedure (lpD3DRMobj: IDirect3DRMObject;
      lpArg: Pointer); cdecl;
  TD3DRMFrameMoveCallback = procedure (lpD3DRMFrame: IDirect3DRMFrame;
      lpArg: Pointer; delta: TD3DValue); cdecl;
  TD3DRMFrame3MoveCallback = procedure (lpD3DRMFrame: IDirect3DRMFrame3;
      lpArg: Pointer; delta: TD3DValue); cdecl;
  TD3DRMUpdateCallback = procedure (lpobj: IDirect3DRMDevice; lpArg: Pointer;
      iRectCount: Integer; const d3dRectUpdate: TD3DRect); cdecl;
  TD3DRMDevice3UpdateCallback = procedure (lpobj: IDirect3DRMDevice3;
      lpArg: Pointer; iRectCount: Integer; const d3dRectUpdate: TD3DRect);cdecl;
  TD3DRMUserVisualCallback = function (lpD3DRMUV: IDirect3DRMUserVisual;
      lpArg: Pointer; lpD3DRMUVreason: TD3DRMUserVisualReason;
      lpD3DRMDev: IDirect3DRMDevice;
      lpD3DRMview: IDirect3DRMViewport) : Integer; cdecl;
  TD3DRMLoadTextureCallback = function (tex_name: PAnsiChar; lpArg: Pointer;
      out lpD3DRMTex: IDirect3DRMTexture) : HResult; cdecl;
  TD3DRMLoadTexture3Callback = function (tex_name: PAnsiChar; lpArg: Pointer;
      out lpD3DRMTex: IDirect3DRMTexture3) : HResult; cdecl;
  TD3DRMLoadCallback = procedure (lpObject: IDirect3DRMObject;
      const ObjectGuid: TGUID; lpArg: Pointer); cdecl;
  TD3DRMDownSampleCallback = function (lpDirect3DRMTexture: IDirect3DRMTexture3;
      pArg: pointer; pDDSSrc, pDDSDst: IDirectDrawSurface) : HResult; cdecl;
  TD3DRMValidationCallback = function (lpDirect3DRMTexture: IDirect3DRMTexture3;
      pArg: pointer; dwFlags, DWcRects: DWORD; const pRects: TRect) : HResult; cdecl;

  PD3DRMPickDesc = ^TD3DRMPickDesc;
  TD3DRMPickDesc = packed record
    ulFaceIdx: DWORD;
    lGroupIdx: LongInt;
    vPosition: TD3DVector;
  end;

  PD3DRMPickDesc2 = ^TD3DRMPickDesc2;
  TD3DRMPickDesc2 = packed record
    ulFaceIdx: DWORD;
    lGroupIdx: LongInt;
    dvPosition: TD3DVector;
    tu, tv: TD3DValue;
    dvNormal: TD3DVector;
    dcColor: TD3DColor;
  end;

(*
 * Base class
 *)
{$IFDEF D2COM}
  IDirect3DRMObject = class (IUnknown)
{$ELSE}
  IDirect3DRMObject = interface (IUnknown)
    ['{eb16cb00-d271-11ce-ac48-0000c03825a1}']
{$ENDIF}
    (*
     * The methods for IDirect3DRMObject
     *)
    function Clone (pUnkOuter: IUnknown; riid: TGUID;
        var ppvObj: Pointer) : HResult; stdcall;
    function AddDestroyCallback (lpCallback: TD3DRMObjectCallback;
        lpArg: Pointer) : HResult; stdcall;
    function DeleteDestroyCallback (d3drmObjProc: TD3DRMObjectCallback;
        lpArg: Pointer) : HResult; stdcall;
    function SetAppData (ulData: DWORD) : HResult; stdcall;
    function GetAppData: DWORD; stdcall;
    function SetName (lpName: PAnsiChar) : HResult; stdcall;
    function GetName (var lpdwSize: DWORD; lpName: PAnsiChar) : HResult; stdcall;
    function GetClassName (var lpdwSize: DWORD; lpName: PAnsiChar) : HResult; stdcall;
  end;

  IDirect3DRMVisual = interface (IDirect3DRMObject)
  end;

  IDirect3DRMDevice = interface (IDirect3DRMObject)
    ['{e9e19280-6e05-11cf-ac4a-0000c03825a1}']
    (*
     * IDirect3DRMDevice methods
     *)
    function Init (width: LongInt; height: LongInt) : HResult; stdcall;
    function InitFromD3D (lpD3D: IDirect3D; lpD3DIMDev: IDirect3DDevice) : HResult; stdcall;
    function InitFromClipper (lpDDClipper: IDirectDrawClipper; lpGUID: PGUID;
        width: Integer; height: Integer) : HResult; stdcall;
    function Update: HResult; stdcall;
    function AddUpdateCallback (d3drmUpdateProc: TD3DRMUpdateCallback;
        arg: Pointer) : HResult; stdcall;
    function DeleteUpdateCallback (d3drmUpdateProc: TD3DRMUpdateCallback;
        arg: Pointer) : HResult; stdcall;
    function SetBufferCount (dwCount: DWORD) : HResult; stdcall;
    function GetBufferCount: DWORD; stdcall;
    function SetDither (bDither: BOOL) : HResult; stdcall;
    function SetShades (ulShades: DWORD) : HResult; stdcall;
    function SetQuality (rqQuality: TD3DRMRenderQuality) : HResult; stdcall;
    function SetTextureQuality (tqTextureQuality: TD3DRMTextureQuality) : HResult; stdcall;
    function GetViewports (out lplpViewports: IDirect3DRMViewportArray) : HResult; stdcall;
    function GetDither: BOOL; stdcall;
    function GetShades: DWORD; stdcall;
    function GetHeight: DWORD; stdcall;
    function GetWidth: DWORD; stdcall;
    function GetTrianglesDrawn: DWORD; stdcall;
    function GetWireframeOptions: DWORD; stdcall;
    function GetQuality: TD3DRMRenderQuality; stdcall;
    function GetColorModel: TD3DColorModel; stdcall;
    function GetTextureQuality: TD3DRMTextureQuality; stdcall;
    function GetDirect3DDevice (out lplpD3DDevice: IDirect3DDevice) : HResult; stdcall;
  end;

  IDirect3DRMDevice2 = interface (IDirect3DRMDevice)
    ['{4516ec78-8f20-11d0-9b6d-0000c0781bc3}']
    (*
     * IDirect3DRMDevice2 methods
     *)
    function InitFromD3D2(lpD3D: IDirect3D2; lpD3DIMDev: IDirect3DDevice2) : HResult; stdcall;
    function InitFromSurface(const lpGUID: TGUID; lpDD: IDirectDraw; lpDDSBack: IDirectDrawSurface) : HResult; stdcall;
    function SetRenderMode(dwFlags: DWORD ) : HResult; stdcall;
    function GetRenderMode : DWORD; stdcall;
    function GetDirect3DDevice2(out lplpD3DDevice: IDirect3DDevice2) : HResult; stdcall;
  end;

  IDirect3DRMDevice3 = interface (IDirect3DRMObject)
    ['{549f498b-bfeb-11d1-8ed8-00a0c967a482}']
    (*
     * IDirect3DRMDevice methods
     *)
    function Init (width: LongInt; height: LongInt) : HResult; stdcall;
    function InitFromD3D (lpD3D: IDirect3D2; lpD3DIMDev: IDirect3DDevice2) : HResult; stdcall;
    function InitFromClipper (lpDDClipper: IDirectDrawClipper; lpGUID: PGUID;
        width: Integer; height: Integer) : HResult; stdcall;
    function Update: HResult; stdcall;
    function AddUpdateCallback (d3drmUpdateProc: TD3DRMDevice3UpdateCallback;
        arg: Pointer) : HResult; stdcall;
    function DeleteUpdateCallback (d3drmUpdateProc: TD3DRMDevice3UpdateCallback;
        arg: Pointer) : HResult; stdcall;
    function SetBufferCount (dwCount: DWORD) : HResult; stdcall;
    function GetBufferCount: DWORD; stdcall;
    function SetDither (bDither: BOOL) : HResult; stdcall;
    function SetShades (ulShades: DWORD) : HResult; stdcall;
    function SetQuality (rqQuality: TD3DRMRenderQuality) : HResult; stdcall;
    function SetTextureQuality (tqTextureQuality: TD3DRMTextureQuality) : HResult; stdcall;
    function GetViewports (out lplpViewports: IDirect3DRMViewportArray) : HResult; stdcall;
    function GetDither: BOOL; stdcall;
    function GetShades: DWORD; stdcall;
    function GetHeight: DWORD; stdcall;
    function GetWidth: DWORD; stdcall;
    function GetTrianglesDrawn: DWORD; stdcall;
    function GetWireframeOptions: DWORD; stdcall;
    function GetQuality: TD3DRMRenderQuality; stdcall;
    function GetColorModel: TD3DColorModel; stdcall;
    function GetTextureQuality: TD3DRMTextureQuality; stdcall;
    function GetDirect3DDevice (out lplpD3DDevice: IDirect3DDevice) : HResult; stdcall;
    (*
     * IDirect3DRMDevice2 methods
     *)
    function InitFromD3D2(lpD3D: IDirect3D2; lpD3DIMDev: IDirect3DDevice2) : HResult; stdcall;
    function InitFromSurface(const lpGUID: TGUID; lpDD: IDirectDraw;
	    lpDDSBack: IDirectDrawSurface) : HResult; stdcall;
    function SetRenderMode(dwFlags: DWORD ) : HResult; stdcall;
    function GetRenderMode : DWORD; stdcall;
    function GetDirect3DDevice2(out lplpD3DDevice: IDirect3DDevice2) : HResult; stdcall;
    (*
     * IDirect3DRMDevice3 methods
     *)
    function FindPreferredTextureFormat (dwBitDepths, dwFlags: DWORD;
        out lpDDPF: TDDPixelFormat) : HResult; stdcall;
    function RenderStateChange (dwStateNum, dwVal, dwFlags: DWORD) : HResult; stdcall;

    function LightStateChange (drsType: TD3DLightStateType; // defined different in header and help
        dwVal, dwFlags: DWORD) : HResult; stdcall;
    function GetStateChangeOptions (dwStateClass, dwStateNum: DWORD;
        var pdwFlags: DWORD) : HResult; stdcall;
    function SetStateChangeOptions ( dwStateClass, dwStateNum, dwFlags: DWORD) : HResult; stdcall;
  end;

  IDirect3DRMViewport = interface (IDirect3DRMObject)
    ['{eb16cb02-d271-11ce-ac48-0000c03825a1}']
    (*
     * IDirect3DRMViewport methods
     *)
    function Init (lpD3DRMDevice: IDirect3DRMDevice;
        lpD3DRMFrameCamera: IDirect3DRMFrame; xpos, ypos,
        width, height: DWORD) : HResult; stdcall;
    function Clear: HResult; stdcall;
    function Render (lpD3DRMFrame: IDirect3DRMFrame) : HResult; stdcall;
    function SetFront (rvFront: TD3DValue) : HResult; stdcall;
    function SetBack (rvBack: TD3DValue) : HResult; stdcall;
    function SetField (rvField: TD3DValue) : HResult; stdcall;
    function SetUniformScaling (bScale: BOOL) : HResult; stdcall;
    function SetCamera (lpCamera: IDirect3DRMFrame) : HResult; stdcall;
    function SetProjection (rptType: TD3DRMProjectionType) : HResult; stdcall;
    function Transform (out lprvDst: TD3DRMVector4D; const lprvSrc: TD3DVector) : HResult; stdcall;
    function InverseTransform (out lprvDst: TD3DVector;
        const lprvSrc: TD3DRMVector4D) : HResult; stdcall;
    function Configure (lX, lY: LongInt; dwWidth, dwHeight: DWORD) : HResult; stdcall;
    function ForceUpdate (dwX1, dwY1, dwX2, dwY2: DWORD) : HResult; stdcall;
    function SetPlane (rvLeft, rvRight, rvBottom, rvTop: TD3DValue) : HResult; stdcall;
    function GetCamera (out lpCamera: IDirect3DRMFrame) : HResult; stdcall;
    function GetDevice (out lpD3DRMDevice: IDirect3DRMDevice) : HResult; stdcall;
    function GetPlane (out lpd3dvLeft, lpd3dvRight, lpd3dvBottom, lpd3dvTop:
        TD3DValue) : HResult; stdcall;
    function Pick (lX, lY: LongInt; var lplpVisuals: IDirect3DRMPickedArray) : HResult; stdcall;
    function GetUniformScaling: BOOL;  stdcall;
    function GetX: LongInt; stdcall;
    function GetY: LongInt; stdcall;
    function GetWidth: DWORD; stdcall;
    function GetHeight: DWORD; stdcall;
    function GetField: TD3DValue; stdcall;
    function GetBack: TD3DValue; stdcall;
    function GetFront: TD3DValue; stdcall;
    function GetProjection: TD3DRMProjectionType; stdcall;
    function GetDirect3DViewport (out lplpD3DViewport: IDirect3DViewport) : HResult; stdcall;
  end;

  IDirect3DRMViewport2 = interface (IDirect3DRMObject)
    ['{4a1b1be6-bfed-11d1-8ed8-00a0c967a482}']
    (*
     * IDirect3DRMViewport2 methods
     *)
    function Init (lpD3DRMDevice: IDirect3DRMDevice3;
        lpD3DRMFrameCamera: IDirect3DRMFrame3; xpos, ypos,
        width, height: DWORD) : HResult; stdcall;
    function Clear (dwFlags: DWORD): HResult; stdcall;
    function Render (lpD3DRMFrame: IDirect3DRMFrame3) : HResult; stdcall;
    function SetFront (rvFront: TD3DValue) : HResult; stdcall;
    function SetBack (rvBack: TD3DValue) : HResult; stdcall;
    function SetField (rvField: TD3DValue) : HResult; stdcall;
    function SetUniformScaling (bScale: BOOL) : HResult; stdcall;
    function SetCamera (lpCamera: IDirect3DRMFrame3) : HResult; stdcall;
    function SetProjection (rptType: TD3DRMProjectionType) : HResult; stdcall;
    function Transform (out lprvDst: TD3DRMVector4D; const lprvSrc: TD3DVector) : HResult; stdcall;
    function InverseTransform (out lprvDst: TD3DVector;
        const lprvSrc: TD3DRMVector4D) : HResult; stdcall;
    function Configure (lX, lY: LongInt; dwWidth, dwHeight: DWORD) : HResult; stdcall;
    function ForceUpdate (dwX1, dwY1, dwX2, dwY2: DWORD) : HResult; stdcall;
    function SetPlane (rvLeft, rvRight, rvBottom, rvTop: TD3DValue) : HResult; stdcall;
    function GetCamera (out lpCamera: IDirect3DRMFrame3) : H                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   