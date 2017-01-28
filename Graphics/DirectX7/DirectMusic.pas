(*==========================================================================;
 *
 *  Copyright (C) 1995-1997 Microsoft Corporation.  All Rights Reserved.
 *
 *  Files:      dls1.h dls2.h dmdls.h dmerror.h dmksctrl.h
                dmusicc.h dmusici.h dmusicf.h dmusbuff.h
 *  Content:    DirectMusic, DirectSetup
 *
 *  DirectX 7.0 Delphi adaptation by Erik Unger
 *
 *  Modyfied: 04-Jan-2000
 *
 *  Download: http://www.delphi-jedi.org/DelphiGraphics/
 *  E-Mail: Erik.Unger@gmx.at
 *
 ***************************************************************************)

{$MINENUMSIZE 4}
{$ALIGN ON}

unit DirectMusic;

interface

uses
  Windows,
  MMSystem,
  ActiveX,
  DirectSound;

function MAKE_HRESULT(sev,fac,code: DWORD) : HResult;

type
  mmioFOURCC = array [0..3] of Char;


(*==========================================================================;
//
//  dls1.h
//
//
//  Description:
//
//  Interface defines and structures for the Instrument Collection Form
//  RIFF DLS.
//
//
//  Written by Sonic Foundry 1996.  Released for public use.
//
//=========================================================================*)

(*//////////////////////////////////////////////////////////////////////////
//
//
// Layout of an instrument collection:
//
//
// RIFF [] 'DLS ' [dlid,colh,INSTLIST,WAVEPOOL,INFOLIST]
//
// INSTLIST
// LIST [] 'lins'
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//
// RGNLIST
// LIST [] 'lrgn'
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//
// ARTLIST
// LIST [] 'lart'
//         'art1' level 1 Articulation connection graph
//         'art2' level 2 Articulation connection graph
//         '3rd1' Possible 3rd party articulation structure 1
//         '3rd2' Possible 3rd party articulation structure 2 .... and so on
//
// WAVEPOOL
// ptbl [] [pool table]
// LIST [] 'wvpl'
//               [path],
//               [path],
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//
// INFOLIST
// LIST [] 'INFO'
//               'icmt' 'One of those crazy comments.'
//               'icop' 'Copyright (C) 1996 Sonic Foundry'
//
////////////////////////////////////////////////////////////////////////(*)

(*/////////////////////////////////////////////////////////////////////////
// FOURCC's used in the DLS file
////////////////////////////////////////////////////////////////////////(*)

const
  FOURCC_DLS   : mmioFOURCC = ('D','L','S',' ');
  FOURCC_DLID  : mmioFOURCC = ('d','l','i','d');
  FOURCC_COLH  : mmioFOURCC = ('c','o','l','h');
  FOURCC_WVPL  : mmioFOURCC = ('w','v','p','l');
  FOURCC_PTBL  : mmioFOURCC = ('p','t','b','l');
  FOURCC_PATH  : mmioFOURCC = ('p','a','t','h');
  FOURCC_wave  : mmioFOURCC = ('w','a','v','e');
  FOURCC_LINS  : mmioFOURCC = ('l','i','n','s');
  FOURCC_INS   : mmioFOURCC = ('i','n','s',' ');
  FOURCC_INSH  : mmioFOURCC = ('i','n','s','h');
  FOURCC_LRGN  : mmioFOURCC = ('l','r','g','n');
  FOURCC_RGN   : mmioFOURCC = ('r','g','n',' ');
  FOURCC_RGNH  : mmioFOURCC = ('r','g','n','h');
  FOURCC_LART  : mmioFOURCC = ('l','a','r','t');
  FOURCC_ART1  : mmioFOURCC = ('a','r','t','1');
  FOURCC_WLNK  : mmioFOURCC = ('w','l','n','k');
  FOURCC_WSMP  : mmioFOURCC = ('w','s','m','p');
  FOURCC_VERS  : mmioFOURCC = ('v','e','r','s');

(*/////////////////////////////////////////////////////////////////////////
// Articulation connection graph definitions
////////////////////////////////////////////////////////////////////////(*)

(* Generic Sources *)
  CONN_SRC_NONE              = $0000;
  CONN_SRC_LFO               = $0001;
  CONN_SRC_KEYONVELOCITY     = $0002;
  CONN_SRC_KEYNUMBER         = $0003;
  CONN_SRC_EG1               = $0004;
  CONN_SRC_EG2               = $0005;
  CONN_SRC_PITCHWHEEL        = $0006;

(* Midi Controllers 0-127 *)
  CONN_SRC_CC1               = $0081;
  CONN_SRC_CC7               = $0087;
  CONN_SRC_CC10              = $008a;
  CONN_SRC_CC11              = $008b;

(* Generic Destinations *)
  CONN_DST_NONE              = $0000;
  CONN_DST_ATTENUATION       = $0001;
  CONN_DST_PITCH             = $0003;
  CONN_DST_PAN               = $0004;

(* LFO Destinations *)
  CONN_DST_LFO_FREQUENCY     = $0104;
  CONN_DST_LFO_STARTDELAY    = $0105;

(* EG1 Destinations *)
  CONN_DST_EG1_ATTACKTIME    = $0206;
  CONN_DST_EG1_DECAYTIME     = $0207;
  CONN_DST_EG1_RELEASETIME   = $0209;
  CONN_DST_EG1_SUSTAINLEVEL  = $020a;

(* EG2 Destinations *)
  CONN_DST_EG2_ATTACKTIME    = $030a;
  CONN_DST_EG2_DECAYTIME     = $030b;
  CONN_DST_EG2_RELEASETIME   = $030d;
  CONN_DST_EG2_SUSTAINLEVEL  = $030e;

  CONN_TRN_NONE              = $0000;
  CONN_TRN_CONCAVE           = $0001;

type
  PDLSId = ^TDLSId;
  TDLSId = packed record
    ulData1 : ULONG;
    usData2 : Word;
    usData3 : Word;
    abData4 : array [0..7] of BYTE;
  end;

  PDLSVersion = ^TDLSVersion;
  TDLSVersion = packed record
    dwVersionMS,
    dwVersionLS : DWORD;
  end;

  PConnection = ^TConnection;
  TConnection = packed record
    usSource : Word;
    usControl : Word;
    SuDestination : Word;
    usTransform :  Word;
    lScale : LongInt;
  end;

(* Level 1 Articulation Data *)

  PConnectionList = ^TConnectionList;
  TConnectionList = packed record
    cbSize : ULONG;            (* size of the connection list structure *)
    cConnections : ULONG;      (* count of connections in the list *)
  end;

(*/////////////////////////////////////////////////////////////////////////
// Generic type defines for regions and instruments
////////////////////////////////////////////////////////////////////////(*)

  PRGNRange = ^TRGNRange;
  TRGNRange = packed record
    usLow : Word;
    usHigh : Word;
  end;

const
  F_INSTRUMENT_DRUMS      = $80000000;

type
  PMIDILocale = ^TMIDILocale;
  TMIDILocale = packed record
    ulBank : ULONG;
    ulInstrument : ULONG;
  end;

(*/////////////////////////////////////////////////////////////////////////
// Header structures found in an DLS file for collection, instruments, and
// regions.
////////////////////////////////////////////////////////////////////////(*)

const
  F_RGN_OPTION_SELFNONEXCLUSIVE  = $0001;

type
  PRGNHeader = ^TRGNHeader;
  TRGNHeader = packed record
    RangeKey : TRGNRange;          (* Key range  *)
    RangeVelocity : TRGNRange;     (* Velocity Range  *)
    fusOptions : Word   ;          (* Synthesis options for this range *)
    usKeyGroup : Word   ;          (* Key grouping for non simultaneous play *)
                                   (* 0 = no group, 1 up is group *)
                                   (* for Level 1 only groups 1-15 are allowed *)
  end;

  PInstHeader = ^TInstHeader;
  TInstHeader = packed record
    cRegions : ULONG;                (* Count of regions in this instrument *)
    Locale : TMIDILocale;            (* Intended MIDI locale of this instrument *)
  end;

  PDLSHeader = ^TDLSHeader;
  TDLSHeader = packed record
    cInstruments : ULONG;
  end;

(*////////////////////////////////////////////////////////////////////////////
// definitions for the Wave link structure
///////////////////////////////////////////////////////////////////////////(*)

(* ****  For level 1 only WAVELINK_CHANNEL_MONO is valid  **** *)
(* ulChannel allows for up to 32 channels of audio with each bit position *)
(* specifiying a channel of playback *)

const
  WAVELINK_CHANNEL_LEFT    = $0001;
  WAVELINK_CHANNEL_RIGHT   = $0002;

  F_WAVELINK_PHASE_MASTER  = $0001;

type
  PWaveLink = ^TWaveLink;
  TWaveLink = packed record  (* any paths or links are stored right after struct *)
    fusOptions :   Word;     (* options flags for this wave *)
    usPhaseGroup : Word;     (* Phase grouping for locking channels *)
    ulChannel :    ULONG;    (* channel placement *)
    ulTableIndex : ULONG;    (* index into the wave pool table, 0 based *)
  end;

const
  POOL_CUE_NULL  = $ffffffff;

type
  PPoolCUE = ^TPoolCUE;
  TPoolCUE = packed record
    ulOffset : ULONG;
  end;

  PPoolTable = ^TPoolTable;
  TPoolTable = packed record
    cbSize : ULONG;             (* size of the pool table structure *)
    cCues :  ULONG;             (* count of cues in the list *)
  end;

(*////////////////////////////////////////////////////////////////////////////
// Structures for the "wsmp" chunk
///////////////////////////////////////////////////////////////////////////(*)

const
  F_WSMP_NO_TRUNCATION     = $0001;
  F_WSMP_NO_COMPRESSION    = $0002;

type
  PWSMPL = ^TWSMPL;
  TWSMPL = packed record
    cbSize :        ULONG;
    usUnityNote :   Word;       (* MIDI Unity Playback Note *)
    sFineTune :     SmallInt;   (* Fine Tune in log tuning *)
    lAttenuation :  Integer;    (* Overall Attenuation to be applied to data *)
    fulOptions :    ULONG;      (* Flag options  *)
    cSampleLoops :  ULONG;      (* Count of Sample loops, 0 loops is one shot *)
  end;


(* This loop type is a normal forward playing loop which is continually *)
(* played until the envelope reaches an off threshold in the release *)
(* portion of the volume envelope *)

const
  WLOOP_TYPE_FORWARD  = 0;

type
  TWLoop = packed record
    cbSize :   ULONG;
    ulType :   ULONG;           (* Loop Type *)
    ulStart :  ULONG;           (* Start of loop in samples *)
    ulLength : ULONG;           (* Length of loop in samples *)
  end;

(*******************************************************************************

dls2.h

Description:

Interface defines and structures for the DLS2 extensions of DLS.


  Written by Microsoft 1998.  Released for public use.

*******************************************************************************)

(*
  FOURCC's used in the DLS2 file, in addition to DLS1 chunks
*)
const
  FOURCC_RGN2  : mmioFOURCC = ('r','g','n','2');
  FOURCC_LAR2  : mmioFOURCC = ('l','a','r','2');
  FOURCC_ART2  : mmioFOURCC = ('a','r','t','2');
  FOURCC_CDL   : mmioFOURCC = ('c','d','l',' ');
//  FOURCC_DLID  : mmioFOURCC = ('d','l','i','d');

(*
  Articulation connection graph definitions. These are in addition to
  the definitions in the DLS1 header.
*)

const
(* Generic Sources (in addition to DLS1 sources. *)
  CONN_SRC_POLYPRESSURE		  = $0007;	(* Polyphonic Pressure *)
  CONN_SRC_CHANNELPRESSURE	= $0008;	(* Channel Pressure *)
  CONN_SRC_VIBRATO		      = $0009;	(* Vibrato LFO *)
  CONN_SRC_MONOPRESSURE     = $000a; (* MIDI Mono pressure *)


(* Midi Controllers *)
  CONN_SRC_CC91			    = $00db;	(* Reverb Send *)
  CONN_SRC_CC93			    = $00dd;	(* Chorus Send *)


(* Generic Destinations *)
  CONN_DST_GAIN		    	= $0001;	(* Same as CONN_DST_ ATTENUATION *)
  CONN_DST_KEYNUMBER 		= $0005;	(* Key Number Generator *)

(* Audio Channel Output Destinations *)
  CONN_DST_LEFT			    = $0010;	(* Left Channel Send *)
  CONN_DST_RIGHT		   	= $0011;	(* Right Channel Send *)
  CONN_DST_CENTER			  = $0012;	(* Center Channel Send *)
  CONN_DST_LEFTREAR			= $0013;	(* Left Rear Channel Send *)
  CONN_DST_RIGHTREAR		= $0014;	(* Right Rear Channel Send *)
  CONN_DST_LFE_CHANNEL	= $0015;	(* LFE Channel Send *)
  CONN_DST_CHORUS			  = $0080;	(* Chorus Send *)
  CONN_DST_REVERB			  = $0081;	(* Reverb Send *)

(* Vibrato LFO Destinations *)
  CONN_DST_VIB_FREQUENCY		= $0114;	(* Vibrato Frequency *)
  CONN_DST_VIB_STARTDELAY	  = $0115;	(* Vibrato Start Delay *)

(* EG1 Destinations *)
  CONN_DST_EG1_DELAYTIME		= $020B;	(* EG1 Delay Time *)
  CONN_DST_EG1_HOLDTIME	  	= $020C;	(* EG1 Hold Time *)


(*	EG2 Destinations *)
  CONN_DST_EG2_DELAYTIME		= $030F;	(* EG2 Delay Time *)
  CONN_DST_EG2_HOLDTIME	  	= $0310;	(* EG2 Hold Time *)


(* Filter Destinations *)
  CONN_DST_FILTER_CUTOFF		= $0500;	(* Filter Cutoff Frequency *)
  CONN_DST_FILTER_Q		    	= $0501;	(* Filter Resonance *)


(* Transforms *)
  CONN_TRN_CONVEX			= $0002;	(* Convex Transform *)
  CONN_TRN_SWITCH			= $0003;	(* Switch Transform *)


(*	Conditional chunk operators *)
  DLS_CDL_AND			       = $0001;	(* X = X & Y *)
  DLS_CDL_OR			       = $0002;	(* X = X | Y *)
  DLS_CDL_XOR			       = $0003;	(* X = X ^ Y *)
  DLS_CDL_ADD		   	     = $0004;	(* X = X + Y *)
  DLS_CDL_SUBTRACT   	   = $0005;	(* X = X - Y *)
  DLS_CDL_MULTIPLY	     = $0006;	(* X = X * Y *)
  DLS_CDL_DIVIDE		     = $0007;	(* X = X / Y *)
  DLS_CDL_LOGICAL_AND	   = $0008;	(* X = X && Y *)
  DLS_CDL_LOGICAL_OR	   = $0009;	(* X = X || Y *)
  DLS_CDL_LT			       = $000A;	(* X = (X < Y) *)
  DLS_CDL_LE			       = $000B;	(* X = (X <= Y) *)
  DLS_CDL_GT	    		   = $000C;	(* X = (X > Y) *)
  DLS_CDL_GE		    	   = $000D;	(* X = (X >= Y) *)
  DLS_CDL_EQ		    	   = $000E;	(* X = (X == Y) *)
  DLS_CDL_NOT	   		     = $000F;	(* X = !X *)
  DLS_CDL_CONST	    	   = $0010;	(* 32-bit constant *)
  DLS_CDL_QUERY	    	   = $0011;	(* 32-bit value returned from query *)
  DLS_CDL_QUERYSUPPORTED = $0012;	(* Test to see if DLSID Query is supported *)

(*
Loop and release
*)

  WLOOP_TYPE_RELEASE  = 2;

(*
DLSID queries for <cdl-ck>
*)

  DLSID_GMInHardware : TGUID =        '{178f2f24-c364-11d1-a760-0000f875ac12}';
  DLSID_GSInHardware : TGUID =        '{178f2f25-c364-11d1-a760-0000f875ac12}';
  DLSID_XGInHardware : TGUID =        '{178f2f26-c364-11d1-a760-0000f875ac12}';
  DLSID_SupportsDLS1 : TGUID =        '{178f2f27-c364-11d1-a760-0000f875ac12}';
  DLSID_SupportsDLS2 : TGUID =        '{f14599e5-4689-11d2-afa6-00aa0024d8b6}';
  DLSID_SampleMemorySize : TGUID =    '{178f2f28-c364-11d1-a760-0000f875ac12}';
  DLSID_ManufacturersID : TGUID =     '{b03e1181-8095-11d2-a1ef-00600833dbd8}';
  DLSID_ProductID : TGUID =           '{b03e1182-8095-11d2-a1ef-00600833dbd8}';
  DLSID_SamplePlaybackRate : TGUID =  '{2a91f713-a4bf-11d2-bbdf-00600833dbd8}';

(************************************************************************
*                                                                       *
*   dmdls.h -- DLS download definitions for DirectMusic API's           *
*                                                                       *
*   Copyright (c) 1998, Microsoft Corp. All rights reserved.            *
*                                                                       *
************************************************************************)

type
  TPCent =   LongInt;  (* Pitch cents *)
  TGCent =   LongInt;  (* Gain cents *)
  TTCent =   LongInt;  (* Time cents *)
  TPercent = LongInt;  (* Per.. cent! *)

  PReference_Time = ^TReference_Time;
  TReference_Time = LongLong;

  TFourCC = DWORD;   (* a four character code *)

function MAKEFOURCC (ch0, ch1, ch2, ch3: Char) : TFourCC;

type
  TDMus_DownloadInfor = packed record
    dwDLType:                DWORD;      (* Instrument or Wave *)
    dwDLId:                  DWORD;      (* Unique identifier to tag this download. *)
    dwNumOffsetTableEntries: DWORD;      (* Number of index in the offset address table. *)
    cbSize:                  DWORD;      (* Total size of this memory chunk. *)
  end;

const
  DMUS_DOWNLOADINFO_INSTRUMENT   = 1;
  DMUS_DOWNLOADINFO_WAVE         = 2;
  DMUS_DOWNLOADINFO_INSTRUMENT2  = 3;   (* New version for better DLS2 support. *)

  DMUS_DEFAULT_SIZE_OFFSETTABLE  = 1;

(* Flags for DMUS_INSTRUMENT's ulFlags member *)

  DMUS_INSTRUMENT_GM_INSTRUMENT  = 1 shl 0;

type
  TDMus_OffsetTable = packed record
    ulOffsetTable : array [0..DMUS_DEFAULT_SIZE_OFFSETTABLE-1] of ULONG;
  end;

  TDMus_Instrument = packed record
    ulPatch:          ULONG;
    ulFirstRegionIdx: ULONG;
    ulGlobalArtIdx:   ULONG;                 (* If zero the instrument does not have an articulation *)
    ulFirstExtCkIdx:  ULONG;                 (* If zero no 3rd party entenstion chunks associated with the instrument *)
    ulCopyrightIdx:   ULONG;                 (* If zero no Copyright information associated with the instrument *)
    ulFlags:          ULONG;
  end;

  TDMus_Region = packed record
    RangeKey:         TRGNRange;
    RangeVelocity:    TRGNRange;
    fusOptions:       Word;
    usKeyGroup:       Word;
    ulRegionArtIdx:   ULONG;                 (* If zero the region does not have an articulation *)
    ulNextRegionIdx:  ULONG;                 (* If zero no more regions *)
    ulFirstExtCkIdx:  ULONG;                 (* If zero no 3rd party entenstion chunks associated with the region *)
    WaveLink:         TWaveLink;
    WSMP:             TWSMPL;                (*  If WSMP.cSampleLoops > 1 then a WLOOP is included *)
    WLOOP:            array [0..0] of TWLoop;
  end;

  TDMus_LFOParams = packed record
    pcFrequency:   TPCent;
    tcDelay:       TTCent;
    gcVolumeScale: TGCent;
    pcPitchScale:  TPCent;
    gcMWToVolume:  TGCent;
    pcMWToPitch:   TPCent;
  end;

  TDMus_VEGParams = packed record
    tcAttack:      TTCent;
    tcDecay:       TTCent;
    ptSustain:     TPercent;
    tcRelease:     TTCent;
    tcVel2Attack:  TTCent;
    tcKey2Decay:   TTCent;
  end;

  TDMus_PEGParams = packed record
    tcAttack:      TTCent;
    tcDecay:       TTCent;
    ptSustain:     TPercent;
    tcRelease:     TTCent;
    tcVel2Attack:  TTCent;
    tcKey2Decay:   TTCent;
    pcRange:       TPCent;
  end;

  TDMus_MSCParams = packed record
    ptDefaultPan: TPercent;
  end;

  TDMus_ArticParams = packed record
    LFO:      TDMus_LFOParams;
    VolEG:    TDMus_VEGParams;
    PitchEG:  TDMus_PEGParams;
    Misc:     TDMus_MSCParams;
  end;

  TDMus_Articulation = packed record
    ulArt1Idx:       ULONG;                  (* If zero no DLS Level 1 articulation chunk *)
    ulFirstExtCkIdx: ULONG;                  (* If zero no 3rd party entenstion chunks associated with the articulation *)
  end;

const
  DMUS_MIN_DATA_SIZE = 4;

(*  The actual number is determined by cbSize of struct _DMUS_EXTENSIONCHUNK *)

type
  DMus_ExtensionChunk = packed record
    cbSize:                      ULONG;           (*  Size of extension chunk  *)
    ulNextExtCkIdx:              ULONG;           (*  If zero no more 3rd party entenstion chunks *)
    ExtCkID:                     TFourCC;
    byExtCk: array [0..DMUS_MIN_DATA_SIZE-1] of BYTE;  (*  The actual number that follows is determined by cbSize *)
  end;

(*  The actual number is determined by cbSize of struct _DMUS_COPYRIGHT *)

  TDmus_Copyright = packed record
    cbSize:                          ULONG;              (*  Size of copyright information *)
    byCopyright: array [0..DMUS_MIN_DATA_SIZE-1] of BYTE;               (*  The actual number that follows is determined by cbSize *)
  end;

  TDMus_WaveData = packed record
    cbSize:                     ULONG;           
    byData: array [0..DMUS_MIN_DATA_SIZE-1] of BYTE;
  end;

  TDMus_Wave = packed record
    ulFirstExtCkIdx: ULONG;              (* If zero no 3rd party entenstion chunks associated with the wave *)
    ulCopyrightIdx:  ULONG;              (* If zero no Copyright information associated with the wave *)
    ulWaveDataIdx:   ULONG;              (* Location of actual wave data. *)
///    WaveformatEx:    TWaveFormatEx;
  end;

  PDMus_NoteRange = ^TDMus_NoteRange;
  TDMus_NoteRange = packed record
    dwLowNote:  DWORD;           (* Sets the low note for the range of MIDI note events to which the instrument responds.*)
    dwHighNote: DWORD;           (* Sets the high note for the range of MIDI note events to which the instrument responds.*)
  end;

(************************************************************************
*                                                                       *
*   dmerror.h -- Error code returned by DirectMusic API's               *
*                                                                       *
*   Copyright (c) 1998, Microsoft Corp. All rights reserved.            *
*                                                                       *
************************************************************************)

const
  FACILITY_DIRECTMUSIC      = $878;       (* Shared with DirectSound *)
  DMUS_ERRBASE              = $1000;      (* Make error codes human readable in hex *)

  MAKE_DMHRESULTSUCCESS = (0 shl 31) or (FACILITY_DIRECTMUSIC shl 16) or DMUS_ERRBASE;
  MAKE_DMHRESULTERROR =   (1 shl 31) or (FACILITY_DIRECTMUSIC shl 16) or DMUS_ERRBASE;


(* DMUS_S_PARTIALLOAD
 *
 * The object could only load partially. This can happen if some components are
 * not registered properly, such as embedded tracks and tools.
 *)
  DMUS_S_PARTIALLOAD               = MAKE_DMHRESULTSUCCESS + $091;

(* DMUS_S_PARTIALDOWNLOAD
 *
 * This code indicates that a band download was only successful in reaching
 * some, but not all, of the referenced ports. Some samples may not play
 * correctly.
 *)
  DMUS_S_PARTIALDOWNLOAD          = MAKE_DMHRESULTSUCCESS + $092;

(* DMUS_S_REQUEUE
 *
 * Return value from IDirectMusicTool::ProcessPMsg() which indicates to the
 * performance that it should cue the PMsg again automatically.
 *)
  DMUS_S_REQUEUE                   = MAKE_DMHRESULTSUCCESS + $200;

(* DMUS_S_FREE
 *
 * Return value from IDirectMusicTool::ProcessPMsg() which indicates to the
 * performance that it should free the PMsg automatically.
 *)
  DMUS_S_FREE                      = MAKE_DMHRESULTSUCCESS + $201;

(* DMUS_S_END
 *
 * Return value from IDirectMusicTrack::Play() which indicates to the
 * segment that the track has no more data after mtEnd.
 *)
  DMUS_S_END                       = MAKE_DMHRESULTSUCCESS + $202;

(* DMUS_S_STRING_TRUNCATED
 *
 * Returned string has been truncated to fit the buffer size.
 *)
  DMUS_S_STRING_TRUNCATED          = MAKE_DMHRESULTSUCCESS + $210;

(* DMUS_S_LAST_TOOL
 *
 * Returned from IDirectMusicGraph::StampPMsg(), this indicates that the PMsg
 * is already stamped with the last tool in the graph. The returned PMsg's
 * tool pointer is now NULL.
 *)
  DMUS_S_LAST_TOOL                 = MAKE_DMHRESULTSUCCESS + $211;

(* DMUS_S_OVER_CHORD
 *
 * Returned from IDirectMusicPerformance::MusicToMIDI(), this indicates 
 * that no note has been calculated because the music value has the note 
 * at a position higher than the top note of the chord. This applies only
 * to DMUS_PLAYMODE_NORMALCHORD play mode. This success code indicates
 * that the caller should not do anything with the note. It is not meant
 * to be played against this chord.
 *)
  DMUS_S_OVER_CHORD                = MAKE_DMHRESULTSUCCESS + $212;

(* DMUS_S_UP_OCTAVE
 *
 * Returned from IDirectMusicPerformance::MIDIToMusic(),  and
 * IDirectMusicPerformance::MusicToMIDI(), this indicates 
 * that the note conversion generated a note value that is below 0, 
 * so it has been bumped up one or more octaves to be in the proper
 * MIDI range of 0 through 127. 
 * Note that this is valid for MIDIToMusic() when using play modes
 * DMUS_PLAYMODE_FIXEDTOCHORD and DMUS_PLAYMODE_FIXEDTOKEY, both of
 * which store MIDI values in wMusicValue. With MusicToMIDI(), it is
 * valid for all play modes.
 * Ofcourse, DMUS_PLAYMODE_FIXED will never return this success code.
 *)
  DMUS_S_UP_OCTAVE                 = MAKE_DMHRESULTSUCCESS + $213;

(* DMUS_S_DOWN_OCTAVE
 *
 * Returned from IDirectMusicPerformance::MIDIToMusic(),  and
 * IDirectMusicPerformance::MusicToMIDI(), this indicates
 * that the note conversion generated a note value that is above 127, 
 * so it has been bumped down one or more octaves to be in the proper
 * MIDI range of 0 through 127. 
 * Note that this is valid for MIDIToMusic() when using play modes
 * DMUS_PLAYMODE_FIXEDTOCHORD and DMUS_PLAYMODE_FIXEDTOKEY, both of
 * which store MIDI values in wMusicValue. With MusicToMIDI(), it is
 * valid for all play modes.
 * Ofcourse, DMUS_PLAYMODE_FIXED will never return this success code.
 *)
  DMUS_S_DOWN_OCTAVE               = MAKE_DMHRESULTSUCCESS + $214;

(* DMUS_S_NOBUFFERCONTROL
 *
 * Although the audio output from the port will be routed to the
 * same device as the given DirectSound buffer, buffer controls
 * such as pan and volume will not affect the output.
 *
 *)
  DMUS_S_NOBUFFERCONTROL          = MAKE_DMHRESULTSUCCESS + $215;

(* DMUS_E_DRIVER_FAILED
 *
 * An unexpected error was returned from a device driver, indicating
 * possible failure of the driver or hardware.
 *)
  DMUS_E_DRIVER_FAILED            = MAKE_DMHRESULTERROR + $0101;

(* DMUS_E_PORTS_OPEN
 *
 * The requested operation cannot be performed while there are 
 * instantiated ports in any process in the system.
 *)
  DMUS_E_PORTS_OPEN               = MAKE_DMHRESULTERROR + $0102;

(* DMUS_E_DEVICE_IN_USE
 *
 * The requested device is already in use (possibly by a non-DirectMusic
 * client) and cannot be opened again.
 *)
  DMUS_E_DEVICE_IN_USE            = MAKE_DMHRESULTERROR + $0103;

(* DMUS_E_INSUFFICIENTBUFFER
 *
 * Buffer is not large enough for requested operation.
 *)
  DMUS_E_INSUFFICIENTBUFFER       = MAKE_DMHRESULTERROR + $0104;

(* DMUS_E_BUFFERNOTSET
 *
 * No buffer was prepared for the download data.
 *)
  DMUS_E_BUFFERNOTSET             = MAKE_DMHRESULTERROR + $0105;

(* DMUS_E_BUFFERNOTAVAILABLE
 *
 * Download failed due to inability to access or create download buffer.
 *)
  DMUS_E_BUFFERNOTAVAILABLE       = MAKE_DMHRESULTERROR + $0106;

(* DMUS_E_NOTADLSCOL
 *
 * Error parsing DLS collection. File is corrupt.
 *)
  DMUS_E_NOTADLSCOL               = MAKE_DMHRESULTERROR + $0108;

(* DMUS_E_INVALIDOFFSET
 *
 * Wave chunks in DLS collection file are at incorrect offsets.
 *)
  DMUS_E_INVALIDOFFSET            = MAKE_DMHRESULTERROR + $0109;

(* DMUS_E_ALREADY_LOADED
 *
 * Second attempt to load a DLS collection that is currently open.
 *)
  DMUS_E_ALREADY_LOADED           = MAKE_DMHRESULTERROR + $0111;

(* DMUS_E_INVALIDPOS
 *
 * Error reading wave data from DLS collection. Indicates bad file.
 *)
  DMUS_E_INVALIDPOS               = MAKE_DMHRESULTERROR + $0113;

(* DMUS_E_INVALIDPATCH
 *
 * There is no instrument in the collection that matches patch number.
 *)
  DMUS_E_INVALIDPATCH             = MAKE_DMHRESULTERROR + $0114;

(* DMUS_E_CANNOTSEEK
 *
 * The IStream* doesn't support Seek().
 *)
  DMUS_E_CANNOTSEEK               = MAKE_DMHRESULTERROR + $0115;

(* DMUS_E_CANNOTWRITE
 *
 * The IStream* doesn't support Write().
 *)
  DMUS_E_CANNOTWRITE              = MAKE_DMHRESULTERROR + $0116;

(* DMUS_E_CHUNKNOTFOUND
 *
 * The RIFF parser doesn't contain a required chunk while parsing file.
 *)
  DMUS_E_CHUNKNOTFOUND            = MAKE_DMHRESULTERROR + $0117;

(* DMUS_E_INVALID_DOWNLOADID
 *
 * Invalid download id was used in the process of creating a download buffer.
 *)
  DMUS_E_INVALID_DOWNLOADID       = MAKE_DMHRESULTERROR + $0119;

(* DMUS_E_NOT_DOWNLOADED_TO_PORT
 *
 * Tried to unload an object that was not downloaded or previously unloaded.
 *)
  DMUS_E_NOT_DOWNLOADED_TO_PORT   = MAKE_DMHRESULTERROR + $0120;

(* DMUS_E_ALREADY_DOWNLOADED
 *
 * Buffer was already downloaded to synth.
 *)
  DMUS_E_ALREADY_DOWNLOADED       = MAKE_DMHRESULTERROR + $0121;

(* DMUS_E_UNKNOWN_PROPERTY
 *
 * The specified property item was not recognized by the target object.
 *)
  DMUS_E_UNKNOWN_PROPERTY         = MAKE_DMHRESULTERROR + $0122;

(* DMUS_E_SET_UNSUPPORTED
 *
 * The specified property item may not be set on the target object.
 *)
  DMUS_E_SET_UNSUPPORTED          = MAKE_DMHRESULTERROR + $0123;

(* DMUS_E_GET_UNSUPPORTED
 *
 * The specified property item may not be retrieved from the target object.
 *)
  DMUS_E_GET_UNSUPPORTED          = MAKE_DMHRESULTERROR + $0124;

(* DMUS_E_NOTMONO
 *
 * Wave chunk has more than one interleaved channel. DLS format requires MONO.
 *)
  DMUS_E_NOTMONO                  = MAKE_DMHRESULTERROR + $0125;

(* DMUS_E_BADARTICULATION
 *
 * Invalid articulation chunk in DLS collection.
 *)
  DMUS_E_BADARTICULATION          = MAKE_DMHRESULTERROR + $0126;

(* DMUS_E_BADINSTRUMENT
 *
 * Invalid instrument chunk in DLS collection.
 *)
  DMUS_E_BADINSTRUMENT            = MAKE_DMHRESULTERROR + $0127;

(* DMUS_E_BADWAVELINK
 *
 * Wavelink chunk in DLS collection points to invalid wave.
 *)
  DMUS_E_BADWAVELINK              = MAKE_DMHRESULTERROR + $0128;

(* DMUS_E_NOARTICULATION
 *
 * Articulation missing from instrument in DLS collection.
 *)
  DMUS_E_NOARTICULATION           = MAKE_DMHRESULTERROR + $0129;

(* DMUS_E_NOTPCM
 *
 * Downoaded DLS wave is not in PCM format.
*)
  DMUS_E_NOTPCM                   = MAKE_DMHRESULTERROR + $012A;

(* DMUS_E_BADWAVE
 *
 * Bad wave chunk in DLS collection
 *)
  DMUS_E_BADWAVE                  = MAKE_DMHRESULTERROR + $012B;

(* DMUS_E_BADOFFSETTABLE
 *
 * Offset Table for download buffer has errors. 
 *)
  DMUS_E_BADOFFSETTABLE           = MAKE_DMHRESULTERROR + $012C;

(* DMUS_E_UNKNOWNDOWNLOAD
 *
 * Attempted to download unknown data type.
 *)
  DMUS_E_UNKNOWNDOWNLOAD          = MAKE_DMHRESULTERROR + $012D;

(* DMUS_E_NOSYNTHSINK
 *
 * The operation could not be completed because no sink was connected to
 * the synthesizer.
 *)
  DMUS_E_NOSYNTHSINK              = MAKE_DMHRESULTERROR + $012E;

(* DMUS_E_ALREADYOPEN
 *
 * An attempt was made to open the software synthesizer while it was already
 * open.
 * ASSERT?
 *)
  DMUS_E_ALREADYOPEN              = MAKE_DMHRESULTERROR + $012F;

(* DMUS_E_ALREADYCLOSE
 *
 * An attempt was made to close the software synthesizer while it was already
 * open.
 * ASSERT?
 *)
  DMUS_E_ALREADYCLOSED            = MAKE_DMHRESULTERROR + $0130;

(* DMUS_E_SYNTHNOTCONFIGURED
 *
 * The operation could not be completed because the software synth has not
 * yet been fully configured.
 * ASSERT?
 *)
  DMUS_E_SYNTHNOTCONFIGURED       = MAKE_DMHRESULTERROR + $0131;

(* DMUS_E_SYNTHACTIVE
 *
 * The operation cannot be carried out while the synthesizer is active.
 *)
  DMUS_E_SYNTHACTIVE              = MAKE_DMHRESULTERROR + $0132;

(* DMUS_E_CANNOTREAD
 *
 * An error occurred while attempting to read from the IStream* object.
 *)
  DMUS_E_CANNOTREAD               = MAKE_DMHRESULTERROR + $0133;

(* DMUS_E_DMUSIC_RELEASED
 *
 * The operation cannot be performed because the final instance of the
 * DirectMusic object was released. Ports cannot be used after final 
 * release of the DirectMusic object.
 *)
  DMUS_E_DMUSIC_RELEASED          = MAKE_DMHRESULTERROR + $0134;

(* DMUS_E_BUFFER_EMPTY
 *
 * There was no data in the referenced buffer.
 *)
  DMUS_E_BUFFER_EMPTY             = MAKE_DMHRESULTERROR + $0135;

(* DMUS_E_BUFFER_FULL
 *
 * There is insufficient space to insert the given event into the buffer.
 *)
  DMUS_E_BUFFER_FULL              = MAKE_DMHRESULTERROR + $0136;

(* DMUS_E_PORT_NOT_CAPTURE
 *
 * The given operation could not be carried out because the port is a
 * capture port.
 *)
  DMUS_E_PORT_NOT_CAPTURE         = MAKE_DMHRESULTERROR + $0137;

(* DMUS_E_PORT_NOT_RENDER
 *
 * The given operation could not be carried out because the port is a
 * render port.
 *)
  DMUS_E_PORT_NOT_RENDER          = MAKE_DMHRESULTERROR + $0138;

(* DMUS_E_DSOUND_NOT_SET
 *
 * The port could not be created because no DirectSound has been specified.
 * Specify a DirectSound interface via the IDirectMusic::SetDirectSound
 * method; pass NULL to have DirectMusic manage usage of DirectSound.
 *)
  DMUS_E_DSOUND_NOT_SET           = MAKE_DMHRESULTERROR + $0139;

(* DMUS_E_ALREADY_ACTIVATED
 *
 * The operation cannot be carried out while the port is active.
 *)
  DMUS_E_ALREADY_ACTIVATED        = MAKE_DMHRESULTERROR + $013A;

(* DMUS_E_INVALIDBUFFER
 *
 * Invalid DirectSound buffer was handed to port.
 *)
  DMUS_E_INVALIDBUFFER            = MAKE_DMHRESULTERROR + $013B;

(* DMUS_E_WAVEFORMATNOTSUPPORTED
 *
 * Invalid buffer format was handed to the synth sink.
 *)
  DMUS_E_WAVEFORMATNOTSUPPORTED   = MAKE_DMHRESULTERROR + $013C;

(* DMUS_E_SYNTHINACTIVE
 *
 * The operation cannot be carried out while the synthesizer is inactive.
 *)
  DMUS_E_SYNTHINACTIVE            = MAKE_DMHRESULTERROR + $013D;

(* DMUS_E_DSOUND_ALREADY_SET
 *
 * IDirectMusic::SetDirectSound has already been called. It may not be
 * changed while in use.
 *)
  DMUS_E_DSOUND_ALREADY_SET       = MAKE_DMHRESULTERROR + $013E;

(* DMUS_E_INVALID_EVENT
 *
 * The given event is invalid (either it is not a valid MIDI message
 * or it makes use of running status). The event cannot be packed
 * into the buffer.
 *)
  DMUS_E_INVALID_EVENT            = MAKE_DMHRESULTERROR + $013F;

(* DMUS_E_UNSUPPORTED_STREAM
 *
 * The IStream* object does not contain data supported by the loading object.
 *)
  DMUS_E_UNSUPPORTED_STREAM       = MAKE_DMHRESULTERROR + $0150;

(* DMUS_E_ALREADY_INITED
 *
 * The object has already been initialized.
 *)
  DMUS_E_ALREADY_INITED           = MAKE_DMHRESULTERROR + $0151;

(* DMUS_E_INVALID_BAND
 *
 * The file does not contain a valid band.
 *)
  DMUS_E_INVALID_BAND             = MAKE_DMHRESULTERROR + $0152;

(* DMUS_E_TRACK_HDR_NOT_FIRST_CK
 *
 * The IStream* object's data does not have a track header as the first chunk,
 * and therefore can not be read by the segment object.
 *)
  DMUS_E_TRACK_HDR_NOT_FIRST_CK   = MAKE_DMHRESULTERROR + $0155;

(* DMUS_E_TOOL_HDR_NOT_FIRST_CK
 *
 * The IStream* object's data does not have a tool header as the first chunk,
 * and therefore can not be read by the graph object.
 *)
  DMUS_E_TOOL_HDR_NOT_FIRST_CK    = MAKE_DMHRESULTERROR + $0156;

(* DMUS_E_INVALID_TRACK_HDR
 *
 * The IStream* object's data contains an invalid track header (ckid is 0 and
 * fccType is NULL,) and therefore can not be read by the segment object.
 *)
  DMUS_E_INVALID_TRACK_HDR        = MAKE_DMHRESULTERROR + $0157;

(* DMUS_E_INVALID_TOOL_HDR
 *
 * The IStream* object's data contains an invalid tool header (ckid is 0 and
 * fccType is NULL,) and therefore can not be read by the graph object.
 *)
  DMUS_E_INVALID_TOOL_HDR         = MAKE_DMHRESULTERROR + $0158;

(* DMUS_E_ALL_TOOLS_FAILED
 *
 * The graph object was unable to load all tools from the IStream* object data.
 * This may be due to errors in the stream, or the tools being incorrectly
 * registered on the client.
 *)
  DMUS_E_ALL_TOOLS_FAILED         = MAKE_DMHRESULTERROR + $0159;

(* DMUS_E_ALL_TRACKS_FAILED
 *
 * The segment object was unable to load all tracks from the IStream* object data.
 * This may be due to errors in the stream, or the tracks being incorrectly
 * registered on the client.
 *)
  DMUS_E_ALL_TRACKS_FAILED        = MAKE_DMHRESULTERROR + $0160;

(* DMUS_E_NOT_FOUND
 *
 * The requested item was not contained by the object.
 *)
  DMUS_E_NOT_FOUND                = MAKE_DMHRESULTERROR + $0161;

(* DMUS_E_NOT_INIT
 *
 * A required object is not initialized or failed to initialize.
 *)
  DMUS_E_NOT_INIT                 = MAKE_DMHRESULTERROR + $0162;

(* DMUS_E_TYPE_DISABLED
 *
 * The requested parameter type is currently disabled. Parameter types may
 * be enabled and disabled by certain calls to SetParam().
 *)
  DMUS_E_TYPE_DISABLED            = MAKE_DMHRESULTERROR + $0163;

(* DMUS_E_TYPE_UNSUPPORTED
 *
 * The requested parameter type is not supported on the object.
 *)
  DMUS_E_TYPE_UNSUPPORTED         = MAKE_DMHRESULTERROR + $0164;

(* DMUS_E_TIME_PAST
 *
 * The time is in the past, and the operation can not succeed.
 *)
  DMUS_E_TIME_PAST                = MAKE_DMHRESULTERROR + $0165;

(* DMUS_E_TRACK_NOT_FOUND
 *
 * The requested track is not contained by the segment.
 *)
  DMUS_E_TRACK_NOT_FOUND        = MAKE_DMHRESULTERROR + $0166;

(* DMUS_E_NO_MASTER_CLOCK
 *
 * There is no master clock in the performance. Be sure to call
 * IDirectMusicPerformance::Init().
 *)
  DMUS_E_NO_MASTER_CLOCK          = MAKE_DMHRESULTERROR + $0170;

(* DMUS_E_LOADER_NOCLASSID
 *
 * The class id field is required and missing in the DMUS_OBJECTDESC.
 *)
  DMUS_E_LOADER_NOCLASSID         = MAKE_DMHRESULTERROR + $0180;

(* DMUS_E_LOADER_BADPATH
 *
 * The requested file path is invalid.
 *)
  DMUS_E_LOADER_BADPATH           = MAKE_DMHRESULTERROR + $0181;

(* DMUS_E_LOADER_FAILEDOPEN
 *
 * File open failed - either file doesn't exist or is locked.
 *)
  DMUS_E_LOADER_FAILEDOPEN        = MAKE_DMHRESULTERROR + $0182;

(* DMUS_E_LOADER_FORMATNOTSUPPORTED
 *
 * Search data type is not supported.
 *)
  DMUS_E_LOADER_FORMATNOTSUPPORTED    = MAKE_DMHRESULTERROR + $0183;

(* DMUS_E_LOADER_FAILEDCREATE
 *
 * Unable to find or create object.
 *)
  DMUS_E_LOADER_FAILEDCREATE      = MAKE_DMHRESULTERROR + $0184;

(* DMUS_E_LOADER_OBJECTNOTFOUND
 *
 * Object was not found.
 *)
  DMUS_E_LOADER_OBJECTNOTFOUND    = MAKE_DMHRESULTERROR + $0185;

(* DMUS_E_LOADER_NOFILENAME
 *
 * The file name is missing from the DMUS_OBJECTDESC.
 *)
  DMUS_E_LOADER_NOFILENAME	    = MAKE_DMHRESULTERROR + $0186;

(* DMUS_E_INVALIDFILE
 *
 * The file requested is not a valid file.
 *)
  DMUS_E_INVALIDFILE              = MAKE_DMHRESULTERROR + $0200;

(* DMUS_E_ALREADY_EXISTS
 *
 * The tool is already contained in the graph. Create a new instance.
 *)
  DMUS_E_ALREADY_EXISTS           = MAKE_DMHRESULTERROR + $0201;

(* DMUS_E_OUT_OF_RANGE
 *
 * Value is out of range, for instance the requested length is longer than
 * the segment.
 *)
  DMUS_E_OUT_OF_RANGE             = MAKE_DMHRESULTERROR + $0202;

(* DMUS_E_SEGMENT_INIT_FAILED
 *
 * Segment initialization failed, most likely due to a critical memory situation.
 *)
  DMUS_E_SEGMENT_INIT_FAILED      = MAKE_DMHRESULTERROR + $0203;

(* DMUS_E_ALREADY_SENT
 *
 * The DMUS_PMSG has already been sent to the performance object via
 * IDirectMusicPerformance::SendPMsg().
 *)
  DMUS_E_ALREADY_SENT             = MAKE_DMHRESULTERROR + $0204;

(* DMUS_E_CANNOT_FREE
 *
 * The DMUS_PMSG was either not allocated by the performance via
 * IDirectMusicPerformance::AllocPMsg(), or it was already freed via
 * IDirectMusicPerformance::FreePMsg().
 *)
  DMUS_E_CANNOT_FREE              = MAKE_DMHRESULTERROR + $0205;

(* DMUS_E_CANNOT_OPEN_PORT
 *
 * The default system port could not be opened.
 *)
  DMUS_E_CANNOT_OPEN_PORT         = MAKE_DMHRESULTERROR + $0206;

(* DMUS_E_CONNOT_CONVERT
 *
 * A call to MIDIToMusic() or MusicToMIDI() resulted in an error because
 * the requested conversion could not happen. This usually occurs when the
 * provided DMUS_CHORD_KEY structure has an invalid chord or scale pattern.
 *)
  DMUS_E_CONNOT_CONVERT           = MAKE_DMHRESULTERROR + $0207;

(* DMUS_E_DESCEND_CHUNK_FAIL
 *
 * DMUS_E_DESCEND_CHUNK_FAIL is returned when the end of the file
 * was reached before the desired chunk was found.
 *)
  DMUS_E_DESCEND_CHUNK_FAIL       = MAKE_DMHRESULTERROR + $0210;

  
(************************************************************************
*                                                                       *
*   dmksctrl.h -- Definition of IKsControl                              *
*                                                                       *
*   Copyright (c) 1998, Microsoft Corp. All rights reserved.            *
*                                                                       *
*                                                                       *
*   This header file contains the definition of IKsControl, which       *
*   duplicates definitions from ks.h and ksproxy.h. Your code should    *
*   include ks.h and ksproxy.h directly if you have them (they are      *
*   provided in the Windows 98 DDK and will be in the Windows NT 5      *
*   SDK).                                                               *
*                                                                       *
************************************************************************)

(*
 * Warning: This will prevent the rest of ks.h from being pulled in if ks.h is
 * included after dmksctrl.h. Make sure you do not include both headers                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            