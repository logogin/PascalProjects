unit dsound ;

interface

uses OLE2, Windows, MMSystem ;

{*==========================================================================;
 *
 *  Copyright (C) 1995 Microsoft Corporation.  All Rights Reserved.
 *
 *  Conversion (version 0.8) to Delphi 2.0 by Blake Stone
 *
 *    email:     bstone@dkw.com
 *    home page: http://www.dkw.com/bstone
 *
 *  File:       dsound.h
 *  Content:    DirectSound include file
 *
 *=========================================================================}

{ The following are included, untranslated from the C declaration,
  for informational purposes only }

(*
#define _FACDS  0x878
#define MAKE_DSHRESULT( code )  MAKE_HRESULT( 1, _FACDS, code )

// DirectSound 279afa83-4981-11ce-a521-0020af0be560
DEFINE_GUID(IID_IDirectSound,0x279AFA83,0x4981,0x11CE,0xA5,0x21,0x00,0x20,0xAF,0x0B,0xE5,0x60);
// DirectSoundBuffer 279afa85-4981-11ce-a521-0020af0be560
DEFINE_GUID(IID_IDirectSoundBuffer,0x279AFA85,0x4981,0x11CE,0xA5,0x21,0x00,0x20,0xAF,0x0B,0xE5,0x60);
*)

{ Structures }

type
  IDirectSound = class ;
  IDirectSoundBuffer = class ;

  LPDSCAPS = ^DSCAPS ;
  DSCAPS = record
    dwSize: DWORD ;
    dwFlags: DWORD ;
    dwMinSecondarySampleRate: DWORD ;
    dwMaxSecondarySampleRate: DWORD ;
    dwPrimaryBuffers: DWORD ;
    dwMaxHwMixingAllBuffers: DWORD ;
    dwMaxHwMixingStaticBuffers: DWORD ;
    dwMaxHwMixingStreamingBuffers: DWORD ;
    dwFreeHwMixingAllBuffers: DWORD ;
    dwFreeHwMixingStaticBuffers: DWORD ;
    dwFreeHwMixingStreamingBuffers: DWORD ;
    dwMaxHw3DAllBuffers: DWORD ;
    dwMaxHw3DStaticBuffers: DWORD ;
    dwMaxHw3DStreamingBuffers: DWORD ;
    dwFreeHw3DAllBuffers: DWORD ;
    dwFreeHw3DStaticBuffers: DWORD ;
    dwFreeHw3DStreamingBuffers: DWORD ;
    dwTotalHwMemBytes: DWORD ;
    dwFreeHwMemBytes: DWORD ;
    dwMaxContigFreeHwMemBytes: DWORD ;
    dwUnlockTransferRateHwBuffers: DWORD ;
    dwPlayCpuOverheadSwBuffers: DWORD ;
    dwReserved1: DWORD ;
    dwReserved2: DWORD ;
  end ;

  LPDSBCAPS = ^DSBCAPS ;
  DSBCAPS = record
    dwSize: DWORD ;
    dwFlags: DWORD ;
    dwBufferBytes: DWORD ;
    dwUnlockTransferRate: DWORD ;
    dwPlayCpuOverhead: DWORD ;
  end ;

  LPDSBUFFERDESC = ^DSBUFFERDESC ;
  DSBUFFERDESC = record
    dwSize: DWORD ;
    dwFlags: DWORD ;
    dwBufferBytes: DWORD ;
    dwReserved: DWORD ;
    lpwfxFormat: PWaveFormatEx ;
  end ;

  LPDSENUMCALLBACK = function ( lpGUID: PGUID; lpstrDescription: PChar;
      lpstrModule: PChar; lpContext: Pointer ): BOOL ;

{ IDirectSound }

  IDirectSound = class ( IUnknown )
    function CreateSoundBuffer ( const lpDSBufferDesc: DSBUFFERDESC ;
        var lplpDirectSoundBuffer: IDirectSoundBuffer ;
        pUnkOuter: IUnknown ): HRESULT ; virtual ; stdcall ; abstract ;
    function GetCaps ( var lpDSCaps: DSCAPS ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function DuplicateSoundBuffer ( lpDsbOriginal: IDirectSoundBuffer ;
        var lplpDsbDuplicate: IDirectSoundBuffer ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function SetCooperativeLevel ( hwnd: HWND ; dwLevel: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Compact: HRESULT ; virtual ; stdcall ; abstract ;
    function GetSpeakerConfig ( var lpdwSpeakerConfig: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function SetSpeakerConfig ( dwSpeakerConfig: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Initialize ( lpGuid: PGUID ): HRESULT ; virtual ; stdcall ; abstract ;
  end ;

{ IDirectSoundBuffer }

  IDirectSoundBuffer = class ( IUnknown )
    function GetCaps ( var lpDSBufferCaps: DSBCAPS ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function GetCurrentPosition ( var lpdwCurrentPlayCursor: DWORD ;
        var lpdwCurrentWriteCursor: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function GetFormat ( var lpwfxFormat: TWaveFormatEx ; dwSizeAllocated: DWORD ;
        var lpdwSizeWritten: DWORD ): HRESULT ; virtual ; stdcall ; abstract ;
    function GetVolume ( var lplVolume: LongInt ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function GetPan ( var lplPan: LongInt ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function GetFrequency ( var lpdwFrequency: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function GetStatus ( var lpdwStatus: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Initialize ( lpDirectSound: IDirectSound ;
        const lpDSBufferDesc: DSBUFFERDESC ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Lock ( dwWriteCursor: DWORD ; dwWriteBytes: DWORD ;
        var lplpvAudioPtr1: Pointer ; var lpdwAudioBytes1: DWORD ;
        var lplpvAudioPtr2: Pointer ; var lpdwAudioBytes2: DWORD ;
        dwFlags: DWORD ): HRESULT ; virtual ; stdcall ; abstract ;
    function Play ( dwReserved1: DWORD ; dwReserved2: DWORD ;
        dwFlags: DWORD ): HRESULT ; virtual ; stdcall ; abstract ;
    function SetCurrentPosition ( dwNewPosition: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function SetFormat ( const lpwfxFormat: TWaveFormatEx ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function SetVolume ( lVolume: LongInt ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function SetPan ( lPan: LongInt ): HRESULT ; virtual ; stdcall ; abstract ;
    function SetFrequency ( dwFrequency: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Stop: HRESULT ; virtual ; stdcall ; abstract ;
    function Unlock ( lpvAudioPtr1: Pointer ; dwAudioBytes1: DWORD ;
        lpvAudioPtr2:Pointer ; dwAudioBytes2: DWORD ): HRESULT ;
        virtual ; stdcall ; abstract ;
    function Restore: HRESULT ; virtual ; stdcall ; abstract ;
  end ;

{ Return Codes }

const
  DS_OK                           = 0 ;

{ The call failed because resources (such as a priority level)
  were already being used by another caller. }
  DSERR_ALLOCATED                 = $88780000 + 10 ;

{ The control (vol,pan,etc.) requested by the caller is not available. }
  DSERR_CONTROLUNAVAIL            = $88780000 + 30 ;

{ An invalid parameter was passed to the returning function }
  DSERR_INVALIDPARAM              = E_INVALIDARG ;

{ This call is not valid for the current state of this object }
  DSERR_INVALIDCALL               = $88780000 + 50 ;

{ An undetermined error occured inside the DSound subsystem }
  DSERR_GENERIC                   = E_FAIL ;

{ The caller does not have the priority level required for the function to
  succeed. }
  DSERR_PRIOLEVELNEEDED           = $88780000 + 70 ;

{ The DSound subsystem couldn't allocate sufficient memory to complete the
  caller's request. }
  DSERR_OUTOFMEMORY               = E_OUTOFMEMORY ;

{ The specified WAVE format is not supported }
  DSERR_BADFORMAT                 = $88780000 + 100 ;

{ The function called is not supported at this time }
  DSERR_UNSUPPORTED               = E_NOTIMPL ;

{ No sound driver is available for use }
  DSERR_NODRIVER                  = $88780000 + 120 ;

{ This object is already initialized }
  DSERR_ALREADYINITIALIZED        = $88780000 + 130 ;

{ This object does not support aggregation }
  DSERR_NOAGGREGATION             = CLASS_E_NOAGGREGATION ;

{ The buffer memory has been lost, and must be Restored. }
  DSERR_BUFFERLOST                = $88780000 + 150 ;

{ Another app has a higher priority level, preventing this call from
  succeeding. }
  DSERR_OTHERAPPHASPRIO           = $88780000 + 160 ;

{ Flags }

  DSCAPS_PRIMARYMONO          = $00000001 ;
  DSCAPS_PRIMARYSTEREO        = $00000002 ;
  DSCAPS_PRIMARY8BIT          = $00000004 ;
  DSCAPS_PRIMARY16BIT         = $00000008 ;
  DSCAPS_CONTINUOUSRATE       = $00000010 ;
  DSCAPS_EMULDRIVER           = $00000020 ;
  DSCAPS_CERTIFIED            = $00000040 ;
  DSCAPS_SECONDARYMONO        = $00000100 ;
  DSCAPS_SECONDARYSTEREO      = $00000200 ;
  DSCAPS_SECONDARY8BIT        = $00000400 ;
  DSCAPS_SECONDARY16BIT       = $00000800 ;

  DSBPLAY_LOOPING             = $00000001 ;

  DSBSTATUS_PLAYING           = $00000001 ;
  DSBSTATUS_BUFFERLOST        = $00000002 ;
  DSBSTATUS_LOOPING           = $00000004 ;

  DSBLOCK_FROMWRITECURSOR     = $00000001 ;

  DSSCL_NORMAL                = 1 ;
  DSSCL_PRIORITY              = 2 ;
  DSSCL_EXCLUSIVE             = 3 ;
  DSSCL_WRITEPRIMARY          = 4 ;

  DSBCAPS_PRIMARYBUFFER       = $00000001 ;
  DSBCAPS_STATIC              = $00000002 ;
  DSBCAPS_LOCHARDWARE         = $00000004 ;
  DSBCAPS_LOCSOFTWARE         = $00000008 ;
  DSBCAPS_CTRLFREQUENCY       = $00000020 ;
  DSBCAPS_CTRLPAN             = $00000040 ;
  DSBCAPS_CTRLVOLUME          = $00000080 ;
  DSBCAPS_CTRLDEFAULT         = $000000E0 ; { Pan + volume + frequency. }
  DSBCAPS_CTRLALL             = $000000E0 ; { All control capabilities }

  DSSPEAKER_HEADPHONE         = 1 ;
  DSSPEAKER_MONO              = 2 ;
  DSSPEAKER_QUAD              = 3 ;
  DSSPEAKER_STEREO            = 4 ;
  DSSPEAKER_SURROUND          = 5 ;

function DirectSoundCreate ( lpGUID: PGUID; var lplpDS: IDirectSound;
    pUnkOuter: IUnknown ): HRESULT ; stdcall ;
function DirectSoundEnumerate ( lpCallback: LPDSENUMCALLBACK;
    lpContext: Pointer ): HRESULT ; stdcall ;

implementation

function DirectSoundCreate ; external 'DSOUND' ;
function DirectSoundEnumerate ; external 'DSOUND' name 'DirectSoundEnumerateA' ;

end.

