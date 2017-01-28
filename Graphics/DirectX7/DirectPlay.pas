unit DirectPlay;

(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dplay.h dplobby.h
 *  Content:    DirectPlay include files
 *
 *  DirectX 7 Delphi adaptation by Erik Unger
 *
 *  Modified: 13-Jan-2000
 *
 *  Download: http://www.delphi-jedi.org/DelphiGraphics/
 *  E-Mail: Erik.Unger@gmx.at
 *
 ***************************************************************************)

interface

{$MINENUMSIZE 4}
{$ALIGN ON}

uses
  Windows;

var
  DPlayDLL : HMODULE = 0;

(*==========================================================================;
 *
 *  Copyright (C) 1994-1997 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dplay.h
 *  Content:    DirectPlay include file
 *
 ***************************************************************************)

function DPErrorString(Value: HResult) : string;

type
{$IFDEF UNICODE}
  PCharAW = PWideChar;
{$ELSE}
  PCharAW = PAnsiChar;
{$ENDIF}

const
// {D1EB6D20-8923-11d0-9D97-00A0C90A43CB}
  CLSID_DirectPlay: TGUID =
      (D1:$d1eb6d20;D2:$8923;D3:$11d0;D4:($9d,$97,$00,$a0,$c9,$a,$43,$cb));

(*
 * GUIDS used by Service Providers shipped with DirectPlay
 * Use these to identify Service Provider returned by EnumConnections
 *)

// GUID for IPX service provider
// {685BC400-9D2C-11cf-A9CD-00AA006886E3}
  DPSPGUID_IPX: TGUID =
      (D1:$685bc400;D2:$9d2c;D3:$11cf;D4:($a9,$cd,$00,$aa,$00,$68,$86,$e3));

// GUID for TCP/IP service provider
// 36E95EE0-8577-11cf-960C-0080C7534E82
  DPSPGUID_TCPIP: TGUID =
      (D1:$36E95EE0;D2:$8577;D3:$11cf;D4:($96,$0c,$00,$80,$c7,$53,$4e,$82));

// GUID for Serial service provider
// {0F1D6860-88D9-11cf-9C4E-00A0C905425E}
  DPSPGUID_SERIAL: TGUID =
      (D1:$f1d6860;D2:$88d9;D3:$11cf;D4:($9c,$4e,$00,$a0,$c9,$05,$42,$5e));

// GUID for Modem service provider
// {44EAA760-CB68-11cf-9C4E-00A0C905425E}
  DPSPGUID_MODEM: TGUID =
      (D1:$44eaa760;D2:$cb68;D3:$11cf;D4:($9c,$4e,$00,$a0,$c9,$05,$42,$5e));


(****************************************************************************
 *
 * DirectPlay Structures
 *
 * Various structures used to invoke DirectPlay.
 *
 ****************************************************************************)

type
(*
 * TDPID
 * DirectPlay player and group ID
 *)
  TDPID = DWORD;
  PDPID = ^TDPID;


const
(*
 * DPID that system messages come from
 *)
  DPID_SYSMSG = 0;

(*
 * DPID representing all players in the session
 *)
  DPID_ALLPLAYERS = 0;

(*
 * DPID representing the server player
 *)
  DPID_SERVERPLAYER = 1;

(*
 * DPID representing the maximum ID in the range of DPID's reserved for
 * use by DirectPlay.
 *)
  DPID_RESERVEDRANGE = 100;

(*
 * The player ID is unknown (used with e.g. DPSESSION_NOMESSAGEID)
 *)
  DPID_UNKNOWN = $FFFFFFFF;

type
(*
 * DPCAPS
 * Used to obtain the capabilities of a DirectPlay object
 *)
  PDPCaps = ^TDPCaps;
  TDPCaps = packed record
    dwSize: DWORD;              // Size of structure, in bytes
    dwFlags: DWORD;             // DPCAPS_xxx flags
    dwMaxBufferSize: DWORD;     // Maximum message size, in bytes,  for this service provider
    dwMaxQueueSize: DWORD;      // Obsolete.
    dwMaxPlayers: DWORD;        // Maximum players/groups (local + remote)
    dwHundredBaud: DWORD;       // Bandwidth in 100 bits per second units;
                                // i.e. 24 is 2400, 96 is 9600, etc.
    dwLatency: DWORD;           // Estimated latency; 0 = unknown
    dwMaxLocalPlayers: DWORD;   // Maximum # of locally created players allowed
    dwHeaderLength: DWORD;      // Maximum header length, in bytes, on messages
                                // added by the service provider
    dwTimeout: DWORD;           // Service provider's suggested timeout value
                                // This is how long DirectPlay will wait for
                                // responses to system messages
  end;

const
(*
 * This DirectPlay object is the session host.  If the host exits the
 * session, another application will become the host and receive a
 * DPSYS_HOST system message.
 *)
  DPCAPS_ISHOST = $00000002;

(*
 * The service provider bound to this DirectPlay object can optimize
 * group messaging.
 *)
  DPCAPS_GROUPOPTIMIZED = $00000008;

(*
 * The service provider bound to this DirectPlay object can optimize
 * keep alives (see DPSESSION_KEEPALIVE)
 *)
  DPCAPS_KEEPALIVEOPTIMIZED = $00000010;

(*
 * The service provider bound to this DirectPlay object can optimize
 * guaranteed message delivery.
 *)
  DPCAPS_GUARANTEEDOPTIMIZED = $00000020;

(*
 * This DirectPlay object supports guaranteed message delivery.
 *)
  DPCAPS_GUARANTEEDSUPPORTED = $00000040;

(*
 * This DirectPlay object supports digital signing of messages.
 *)
  DPCAPS_SIGNINGSUPPORTED = $00000080;

(*
 * This DirectPlay object supports encryption of messages.
 *)
  DPCAPS_ENCRYPTIONSUPPORTED = $00000100;

(*
 * This DirectPlay player was created on this machine
 *)
  DPPLAYERCAPS_LOCAL = $00000800;

(*
 * Current Open settings supports all forms of Cancel
 *)
  DPCAPS_ASYNCCANCELSUPPORTED = $00001000;

(*
 * Current Open settings supports CancelAll, but not Cancel
 *)
  DPCAPS_ASYNCCANCELALLSUPPORTED = $00002000;

(*
 * Current Open settings supports Send Timeouts for sends
 *)
  DPCAPS_SENDTIMEOUTSUPPORTED = $00004000;

(*
 * Current Open settings supports send priority
 *)
  DPCAPS_SENDPRIORITYSUPPORTED = $00008000;

(*
 * Current Open settings supports DPSEND_ASYNC flag
 *)
  DPCAPS_ASYNCSUPPORTED = $00010000;

type
(*
 * TDPSessionDesc2
 * Used to describe the properties of a DirectPlay
 * session instance
 *)
  PDPSessionDesc2 = ^TDPSessionDesc2;
  TDPSessionDesc2 = packed record
    dwSize: DWORD;             // Size of structure
    dwFlags: DWORD;            // DPSESSION_xxx flags
    guidInstance: TGUID;       // ID for the session instance
    guidApplication: TGUID;    // GUID of the DirectPlay application.
                               // GUID_NULL for all applications.
    dwMaxPlayers: DWORD;       // Maximum # players allowed in session
    dwCurrentPlayers: DWORD;   // Current # players in session (read only)
    case integer of
      0 : (
    lpszSessionName: PCharAW;  // Name of the session
    lpszPassword: PCharAW;     // Password of the session (optional)
    dwReserved1: DWORD;        // Reserved for future MS use.
    dwReserved2: DWORD;
    dwUser1: DWORD;            // For use by the application
    dwUser2: DWORD;
    dwUser3: DWORD;
    dwUser4: DWORD;
      );
      1 : (
    lpszSessionNameA: PAnsiChar;   // Name of the session
    lpszPasswordA: PAnsiChar       // Password of the session (optional)
      );
      2 : (
    lpszSessionNameW: PWideChar;
    lpszPasswordW: PWideChar
      );
  end;

const
(*
 * Applications cannot create new players in this session.
 *)
  DPSESSION_NEWPLAYERSDISABLED = $00000001;

(*
 * If the DirectPlay object that created the session, the host,
 * quits, then the host will attempt to migrate to another
 * DirectPlay object so that new players can continue to be created
 * and new applications can join the session.
 *)
  DPSESSION_MIGRATEHOST = $00000004;

(*
 * This flag tells DirectPlay not to set the idPlayerTo and idPlayerFrom
 * fields in player messages.  This cuts two DWORD's off the message
 * overhead.
 *)
  DPSESSION_NOMESSAGEID = $00000008;

(*
 * This flag tells DirectPlay to not allow any new applications to
 * join the session.  Applications already in the session can still
 * create new players.
 *)
  DPSESSION_JOINDISABLED = $00000020;

(*
 * This flag tells DirectPlay to detect when remote players 
 * exit abnormally (e.g. their computer or modem gets unplugged)
 *)
  DPSESSION_KEEPALIVE = $00000040;

(*
 * This flag tells DirectPlay not to send a message to all players
 * when a players remote data changes
 *)
  DPSESSION_NODATAMESSAGES = $00000080;

(*
 * This flag indicates that the session belongs to a secure server
 * and needs user authentication
 *)
  DPSESSION_SECURESERVER = $00000100;

(*
 * This flag indicates that the session is private and requirs a password
 * for EnumSessions as well as Open.
 *)
  DPSESSION_PRIVATE = $00000200;

(*
 * This flag indicates that the session requires a password for joining.
 *)
  DPSESSION_PASSWORDREQUIRED = $00000400;

(*
 * This flag tells DirectPlay to route all messages through the server
 *)
  DPSESSION_MULTICASTSERVER = $00000800;

(*
 * This flag tells DirectPlay to only download information about the
 * DPPLAYER_SERVERPLAYER.
 *)
  DPSESSION_CLIENTSERVER = $00001000;

(*
 * This flag tells DirectPlay to use the protocol built into dplay
 * for reliability and statistics all the time.  When this bit is
 * set, only other sessions with this bit set can join or be joined.
 *)
  DPSESSION_DIRECTPLAYPROTOCOL = $00002000;

(*
 * This flag tells DirectPlay that preserving order of received
 * packets is not important, when using reliable delivery.  This
 * will allow messages to be indicated out of order if preceding
 * messages have not yet arrived.  Otherwise DPLAY will wait for
 * earlier messages before delivering later reliable messages.
 *)
  DPSESSION_NOPRESERVEORDER = $00004000;

  
(*
 * This flag tells DirectPlay to optimize communication for latency
 *)
  DPSESSION_OPTIMIZELATENCY = $00008000;

type
(*
 * TDPName
 * Used to hold the name of a DirectPlay entity
 * like a player or a group
 *)
  PDPName = ^TDPName;
  TDPName = packed record
    dwSize: DWORD;    // Size of structure
    dwFlags: DWORD;   // Not used. Must be zero.
    case Integer of
      0 : (
    lpszShortName : PCharAW; // The short or friendly name
    lpszLongName : PCharAW;  // The long or formal name
      );
      1 : (
    lpszShortNameA : PAnsiChar;
    lpszLongNameA : PAnsiChar;
      );
      2 : (
    lpszShortNameW : PWideChar;
    lpszLongNameW : PWideChar;
      );
  end;

(*
 * TDPCredentials
 * Used to hold the user name and password of a DirectPlay user
 *)

  PDPCredentials = ^TDPCredentials;
  TDPCredentials = packed record
    dwSize: DWORD;    // Size of structure
    dwFlags: DWORD;   // Not used. Must be zero.
    case Integer of
      0 : (
    lpszUsername: PCharAW;   // User name of the account
    lpszPassword: PCharAW;   // Password of the account
    lpszDomain:   PCharAW;   // Domain name of the account
      );
      1 : (
    lpszUsernameA: PAnsiChar;   // User name of the account
    lpszPasswordA: PAnsiChar;   // Password of the account
    lpszDomainA:   PAnsiChar;   // Domain name of the account
      );
      2 : (
    lpszUsernameW: PWideChar;   // User name of the account
    lpszPasswordW: PWideChar;   // Password of the account
    lpszDomainW:   PWideChar;   // Domain name of the account
      );
  end;

(*
 * TDPSecurityDesc
 * Used to describe the security properties of a DirectPlay
 * session instance
 *)
  PDPSecurityDesc = ^TDPSecurityDesc;
  TDPSecurityDesc = packed record
    dwSize: DWORD;                  // Size of structure
    dwFlags: DWORD;                 // Not used. Must be zero.
    case Integer of
      0 : (
    lpszSSPIProvider : PCharAW;  // SSPI provider name
    lpszCAPIProvider : PCharAW;  // CAPI provider name
    dwCAPIProviderType: DWORD;      // Crypto Service Provider type
    dwEncryptionAlgorithm: DWORD;   // Encryption Algorithm type
      );
      1 : (
    lpszSSPIProviderA : PAnsiChar;  // SSPI provider name
    lpszCAPIProviderA : PAnsiChar;  // CAPI provider name
      );
      2 : (
    lpszSSPIProviderW : PWideChar;  // SSPI provider name
    lpszCAPIProviderW : PWideChar;  // CAPI provider name
      );
  end;

(*
 * DPACCOUNTDESC
 * Used to describe a user membership account
 *)

  PDPAccountDesc = ^TDPAccountDesc;
  TDPAccountDesc = packed record
    dwSize: DWORD;    // Size of structure
    dwFlags: DWORD;   // Not used. Must be zero.
    case Integer of
      0 : (lpszAccountID : PCharAW);  // Account identifier
      1 : (lpszAccountIDA : PAnsiChar); 
      2 : (lpszAccountIDW : PWideChar);
  end;

(*
 * TDPLConnection
 * Used to hold all in the informaion needed to connect
 * an application to a session or create a session
 *)
  PDPLConnection = ^TDPLConnection;
  TDPLConnection = packed record
    dwSize: DWORD;                     // Size of this structure
    dwFlags: DWORD;                    // Flags specific to this structure
    lpSessionDesc: PDPSessionDesc2;    // Pointer to session desc to use on connect
    lpPlayerName: PDPName;             // Pointer to Player name structure
    guidSP: TGUID;                     // GUID of the DPlay SP to use
    lpAddress: Pointer;                // Address for service provider
    dwAddressSize: DWORD;              // Size of address data
  end;

(*
 * TDPChat
 * Used to hold the a DirectPlay chat message
 *)
  PDPChat = ^TDPChat;
  TDPChat = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    case Integer of
      0 : (lpszMessage : PCharAW);  // Message string
      1 : (lpszMessageA : PAnsiChar);
      2 : (lpszMessageW : PWideChar);
  end;

(*
 * TSGBuffer
 * Scatter Gather Buffer used for SendEx
 *)
  PSGBuffer = ^TSGBuffer;
  TSGBuffer = packed record
    len: UINT;
    pData: PUCHAR;
  end;

(****************************************************************************
 *
 * Prototypes for DirectPlay callback functions
 *
 ****************************************************************************)

(*
 * Callback for IDirectPlay2::EnumSessions
 *)
  TDPEnumSessionsCallback2 = function(lpThisSD: PDPSessionDesc2;
      var lpdwTimeOut: DWORD; dwFlags: DWORD; lpContext: Pointer) : BOOL; stdcall;

const
(*
 * This flag is set on the EnumSessions callback dwFlags parameter when
 * the time out has occurred. There will be no session data for this
 * callback. If *lpdwTimeOut is set to a non-zero value and the
 * EnumSessionsCallback function returns TRUE then EnumSessions will
 * continue waiting until the next timeout occurs. Timeouts are in
 * milliseconds.
 *)
  DPESC_TIMEDOUT = $00000001;

type
(*
 * Callback for IDirectPlay2.EnumPlayers
 *              IDirectPlay2.EnumGroups
 *              IDirectPlay2.EnumGroupPlayers
 *)
  TDPEnumPlayersCallback2 = function(DPID: TDPID; dwPlayerType: DWORD;
      const lpName: TDPName; dwFlags: DWORD; lpContext: Pointer) : BOOL; stdcall;


(*
 * ANSI callback for DirectPlayEnumerate
 * This callback prototype will be used if compiling
 * for ANSI strings
 *)
  TDPEnumDPCallbackA = function(const lpguidSP: TGUID; lpSPName: PAnsiChar;
      dwMajorVersion: DWORD; dwMinorVersion: DWORD; lpContext: Pointer) : BOOL; stdcall;

(*
 * Unicode callback for DirectPlayEnumerate
 * This callback prototype will be used if compiling
 * for Unicode strings
 *)
  TDPEnumDPCallbackW = function(const lpguidSP: TGUID; lpSPName: PWideChar;
      dwMajorVersion: DWORD; dwMinorVersion: DWORD; lpContext: Pointer) : BOOL; stdcall;

(*
 * Callback for DirectPlayEnumerate
 *)
{$IFDEF UNICODE}
  TDPEnumDPCallback = TDPEnumDPCallbackW;
{$ELSE}
  TDPEnumDPCallback = TDPEnumDPCallbackA;
{$ENDIF}

(*
 * Callback for IDirectPlay3(A/W).EnumConnections
 *)
  TDPEnumConnectionsCallback = function(const lpguidSP: TGUID;
      lpConnection: Pointer; dwConnectionSize: DWORD; const lpName: TDPName;
      dwFlags: DWORD; lpContext: Pointer) : BOOL; stdcall;

(*
 * API's
 *)

var
  DirectPlayEnumerate : function (lpEnumDPCallback: TDPEnumDPCallback;
      lpContext: Pointer) : HResult; stdcall;
  DirectPlayEnumerateA : function (lpEnumDPCallback: TDPEnumDPCallbackA;
      lpContext: Pointer) : HResult; stdcall;
  DirectPlayEnumerateW : function (lpEnumDPCallback: TDPEnumDPCallbackW;
      lpContext: Pointer) : HResult; stdcall;


(****************************************************************************
 *
 * IDirectPlay2 (and IDirectPlay2A) Interface
 *
 ****************************************************************************)

type
  IDirectPlay2AW = interface (IUnknown)
    (*** IDirectPlay2 methods ***)
    function AddPlayerToGroup(idGroup: TDPID; idPlayer: TDPID) : HResult; stdcall;
    function Close: HResult; stdcall;
    function CreateGroup(out lpidGroup: TDPID; lpGroupName: PDPName;
        lpData: Pointer; dwDataSize: DWORD; dwFlags: DWORD) : HResult; stdcall;
    function CreatePlayer(out lpidPlayer: TDPID; pPlayerName: PDPName;
        hEvent: THandle; lpData: Pointer; dwDataSize: DWORD; dwFlags: DWORD) : HResult; stdcall;
    function DeletePlayerFromGroup(idGroup: TDPID; idPlayer: TDPID) : HResult; stdcall;
    function DestroyGroup(idGroup: TDPID) : HResult; stdcall;
    function DestroyPlayer(idPlayer: TDPID) : HResult; stdcall;
    function EnumGroupPlayers(idGroup: TDPID; lpguidInstance: PGUID;
        lpEnumPlayersCallback2: TDPEnumPlayersCallback2; lpContext: Pointer;
        dwFlags: DWORD) : HResult; stdcall;
    function EnumGroups(lpguidInstance: PGUID; lpEnumPlayersCallback2:
        TDPEnumPlayersCallback2; lpContext: Pointer; dwFlags: DWORD) : HResult; stdcall;
    function EnumPlayers(lpguidInstance: PGUID; lpEnumPlayersCallback2:
        TDPEnumPlayersCallback2; lpContext: Pointer; dwFlags: DWORD) : HResult; stdcall;
    function EnumSessions(const lpsd: TDPSessionDesc2; dwTimeout: DWORD;
        lpEnumSessionsCallback2: TDPEnumSessionsCallback2; lpContext: Pointer;
        dwFlags: DWORD) : HResult; stdcall;
    function GetCaps(var lpDPCaps: TDPCaps; dwFlags: DWORD) : HResult; stdcall;
    function GetGroupData(idGroup: TDPID; lpData: Pointer; var lpdwDataSize: DWORD;
        dwFlags: DWORD) : HResult; stdcall;
    function GetGroupName(idGroup: TDPID; lpData: Pointer; var lpdwDataSize: DWORD) :
        HResult; stdcall;
    function GetMessageCount(idPlayer: TDPID; var lpdwCount: DWORD) : HResult; stdcall;
    function GetPlayerAddress(idPlayer: TDPID; lpAddress: Pointer;
        var lpdwAddressSize: DWORD) : HResult; stdcall;
    function GetPlayerCaps(idPlayer: TDPID; var lpPlayerCaps: TDPCaps;
        dwFlags: DWORD) : HResult; stdcall;
    function GetPlayerData(idPlayer: TDPID; lpData: Pointer; var lpdwDataSize: DWORD;
        dwFlags: DWORD) : HResult; stdcall;
    function GetPlayerName(idPlayer: TDPID; lpData: Pointer; var lpdwDataSize: DWORD) : HResult; stdcall;
    function GetSessionDesc(lpData: Pointer; var lpdwDataSize: DWORD) : HResult; stdcall;
    function Initialize(const lpGUID: TGUID) : HResult; stdcall;
    function Open(var lpsd: TDPSessionDesc2; dwFlags: DWORD) : HResult; stdcall;
    function Receive(var lpidFrom: TDPID; var lpidTo: TDPID; dwFlags: DWORD;
        lpData: Pointer; var lpdwDataSize: DWORD) : HResult; stdcall;
    function Send(idFrom: TDPID; lpidTo: TDPID; dwFlags: DWORD; var lpData;
        lpdwDataSize: DWORD) : HResult; stdcall;
    function SetGroupData(idGroup: TDPID; lpData: Pointer; dwDataSize: DWORD;
        dwFlags: DWORD) : HResult; stdcall;
    function SetGroupName(idGroup: TDPID; lpGroupName: PDPName;
        dwFlags: DWORD) : HResult; stdcall;
    function SetPlayerData(idPlayer: TDPID; lpData: Pointer; dwDataSize: DWORD;
        dwFlags: DWORD) : HResult; stdcall;
    function SetPlayerName(idPlayer: TDPID; lpPlayerName: PDPName;
        dwFlags: DWORD) : HResult; stdcall;
    function SetSessionDesc(var lpSessDesc: TDPSessionDesc2; dwFlags: DWORD) :
        HResult; stdcall;
  end;

  IDirectPlay2W = interface (IDirectPlay2AW)
    ['{2B74F7C0-9154-11CF-A9CD-00AA006886E3}']
  end;
  IDirectPlay2A = interface (IDirectPlay2AW)
    ['{9d460580-a822-11cf-960c-0080c7534e82}']
  end;

{$IFDEF UNICODE}
  IDirectPlay2 = IDirectPlay2W;
{$ELSE}
  IDirectPlay2 = IDirectPlay2A;
{$ENDIF}

(****************************************************************************
 *
 * IDirectPlay3 (and IDirectPlay3A) Interface
 *
 ****************************************************************************)

  IDirectPlay3AW = interface (IDirectPlay2AW)
    (*** IDirectPlay3 methods ***)
    function AddGroupToGroup(idParentGroup: TDPID; idGroup: TDPID) : HResult; stdcall;
    function CreateGroupInGroup(idParentGroup: TDPID; var lpidGroup: TDPID;
        lpGroupName: PDPName; lpData: Pointer; dwDataSize: DWORD;
        dwFlags: DWORD) : HResult; stdcall;
    function DeleteGroupFromGroup(idParentGroup: TDPID; idGroup: TDPID) : HResult; stdcall;
    function EnumConnections(lpguidApplication: PGUID;
        lpEnumCallback: TDPEnumConnectionsCallback; lpContext: Pointer;
        dwFlags: DWORD) : HResult; stdcall;
    function EnumGroupsInGroup(idGroup: TDPID; lpguidInstance: PGUID;
        lpEnumPlayersCallback2: TDPEnumPlayersCallback2; lpContext: Pointer;
        dwFlags: DWORD) : HResult; stdcall;
    function GetGroupConnectionSettings(dwFlags: DWORD; idGroup: TDPID;
        lpData: Pointer; var lpdwDataSize: DWORD) : HResult; stdcall;
    function InitializeConnection(lpConnection: Pointer; dwFlags: DWORD) : HResult; stdcall;
    function SecureOpen(var lpsd: TDPSessionDesc2; dwFlags: DWORD;
        var lpSecurity: TDPSecurityDesc; var lpCredentials: TDPCredentials) : HResult; stdcall;
    function SendChatMessage(idFrom: TDPID; idTo: TDPID; dwFlags: DWORD;
        var lpChatMessage: TDPChat) : HResult; stdcall;
    function SetGroupConnectionSettings(dwFlags: DWORD; idGroup: TDPID;
        var lpConnection: TDPLConnection) : HResult; stdcall;
    function StartSession(dwFlags: DWORD; idGroup: TDPID) : HResult; stdcall;
    function GetGroupFlags(idGroup: TDPID; out lpdwFlags: DWORD) : HResult; stdcall;
    function GetGroupParent(idGroup: TDPID; out lpidParent: TDPID) : HResult; stdcall;
    function GetPlayerAccount(idPlayer: TDPID; dwFlags: DWORD; var lpData;
        var lpdwDataSize: DWORD) : HResult; stdcall;
    function GetPlayerFlags(idPlayer: TDPID; out lpdwFlags: DWORD) : HResult; stdcall;
  end;


  IDirectPlay3W = interface (IDirectPlay3AW)
    ['{133EFE40-32DC-11D0-9CFB-00A0C90A43CB}']
  end;
  IDirectPlay3A = interface (IDirectPlay3AW)
    ['{133efe41-32dc-11d0-9cfb-00a0c90a43cb}']
  end;

{$IFDEF UNICODE}
  IDirectPlay3 = IDirectPlay3W;
{$ELSE}
  IDirectPlay3 = IDirectPlay3A;
{$ENDIF}


(****************************************************************************
 *
 * IDirectPlay4 (and IDirectPlay4A) Interface
 *
 ****************************************************************************)

  IDirectPlay4AW = interface (IDirectPlay3AW)
    (*** IDirectPlay4 methods ***)
    function GetGroupOwner(idGroup: TDPID; out idOwner: TDPID) : HResult; stdcall;
    function SetGroupOwner(idGroup: TDPID; idOwner: TDPID) : HResult; stdcall;
    function SendEx(idFrom: TDPID; idTo: TDPID; dwFlags: DWORD; lpData: Pointer;
        dwDataSize: DWORD; dwPriority: DWORD; dwTimeout: DWORD;
        lpContext: Pointer; lpdwMsgId: PDWORD) : HResult; stdcall;
    function GetMessageQueue(idFrom: TDPID; idTo: TDPID; dwFlags: DWORD;
        lpdwNumMsgs: PDWORD; lpdwNumBytes: PDWORD) : HResult; stdcall;
    function CancelMessage(dwMessageID: DWORD; dwFlags: DWORD) : HResult; stdcall;
    function CancelPriority(dwMinPriority: DWORD; dwMaxPriority: DWORD; dwFlags: DWORD) : HResult; stdcall;
  end;


  IDirectPlay4W = interface (IDirectPlay4AW)
    ['{0ab1c530-4745-11D1-a7a1-0000f803abfc}']
  end;
  IDirectPlay4A = interface (IDirectPlay4AW)
    ['{0ab1c531-4745-11D1-a7a1-0000f803abfc}']
  end;

{$IFDEF UNICODE}
  IDirectPlay4 = IDirectPlay4W;
{$ELSE}
  IDirectPlay4 = IDirectPlay4A;
{$ENDIF}


const
(****************************************************************************
 *
 * EnumConnections API flags
 *
 ****************************************************************************)

(*
 * Enumerate Service Providers
 *)
  DPCONNECTION_DIRECTPLAY = $00000001;

(*
 * Enumerate Lobby Providers
 *)
  DPCONNECTION_DIRECTPLAYLOBBY = $00000002;

(****************************************************************************
 *
 * EnumPlayers API flags
 *
 ****************************************************************************)

(*
 * Enumerate all players in the current session
 *)
  DPENUMPLAYERS_ALL = $00000000;
  DPENUMGROUPS_ALL = DPENUMPLAYERS_ALL;

(*
 * Enumerate only local (created by this application) players
 * or groups
 *)
  DPENUMPLAYERS_LOCAL = $00000008;
  DPENUMGROUPS_LOCAL = DPENUMPLAYERS_LOCAL;

(*
 * Enumerate only remote (non-local) players
 * or groups
 *)
  DPENUMPLAYERS_REMOTE = $00000010;
  DPENUMGROUPS_REMOTE = DPENUMPLAYERS_REMOTE;

(*
 * Enumerate groups along with the players
 *)
  DPENUMPLAYERS_GROUP = $00000020;

(*
 * Enumerate players or groups in another session 
 * (must supply lpguidInstance)
 *)
  DPENUMPLAYERS_SESSION = $00000080;
  DPENUMGROUPS_SESSION = DPENUMPLAYERS_SESSION;

(*
 * Enumerate server players
 *)
  DPENUMPLAYERS_SERVERPLAYER = $00000100;

(*
 * Enumerate spectator players
 *)
  DPENUMPLAYERS_SPECTATOR = $00000200;

(*
 * Enumerate shortcut groups
 *)
  DPENUMGROUPS_SHORTCUT = $00000400;

(*
 * Enumerate staging area groups
 *)
  DPENUMGROUPS_STAGINGAREA = $00000800;

(*
 * Enumerate hidden groups
 *)
  DPENUMGROUPS_HIDDEN = $00001000;

(*
 * Enumerate the group's owner
 *)
  DPENUMPLAYERS_OWNER = $00002000;

(****************************************************************************
 *
 * CreatePlayer API flags
 *
 ****************************************************************************)

(*
 * This flag indicates that this player should be designated
 * the server player. The app should specify this at CreatePlayer.
 *)
  DPPLAYER_SERVERPLAYER = DPENUMPLAYERS_SERVERPLAYER;

(*
 * This flag indicates that this player should be designated
 * a spectator. The app should specify this at CreatePlayer.
 *)
  DPPLAYER_SPECTATOR = DPENUMPLAYERS_SPECTATOR;

(*
 * This flag indicates that this player was created locally.
 * (returned from GetPlayerFlags)
 *)
  DPPLAYER_LOCAL = DPENUMPLAYERS_LOCAL;

(*
 * This flag indicates that this player is the group's owner
 * (Only returned in EnumGroupPlayers)
 *)
  DPPLAYER_OWNER = DPENUMPLAYERS_OWNER;

(****************************************************************************
 *
 * CreateGroup API flags
 *
 ****************************************************************************)

(*
 * This flag indicates that the StartSession can be called on the group.
 * The app should specify this at CreateGroup, or CreateGroupInGroup.
 *)
  DPGROUP_STAGINGAREA = DPENUMGROUPS_STAGINGAREA;

(*
 * This flag indicates that this group was created locally.
 * (returned from GetGroupFlags)
 *)
  DPGROUP_LOCAL = DPENUMGROUPS_LOCAL;

(*
 * This flag indicates that this group was created hidden.
 *)
  DPGROUP_HIDDEN = DPENUMGROUPS_HIDDEN;

(****************************************************************************
 *
 * EnumSessions API flags
 *
 ****************************************************************************)

(*
 * Enumerate sessions which can be joined
 *)
  DPENUMSESSIONS_AVAILABLE = $00000001;

(*
 * Enumerate all sessions even if they can't be joined.
 *)
  DPENUMSESSIONS_ALL = $00000002;

(*
 * Start an asynchronous enum sessions
 *)
  DPENUMSESSIONS_ASYNC = $00000010;

(*
 * Stop an asynchronous enum sessions
 *)
  DPENUMSESSIONS_STOPASYNC = $00000020;

(*
 * Enumerate sessions even if they require a password
 *)
  DPENUMSESSIONS_PASSWORDREQUIRED = $00000040;

(*
 * Return status about progress of enumeration instead of
 * showing any status dialogs.
 *)
  DPENUMSESSIONS_RETURNSTATUS = $00000080;

(****************************************************************************
 *
 * GetCaps and GetPlayerCaps API flags
 *
 ****************************************************************************)

(*
 * The latency returned should be for guaranteed message sending.
 * Default is non-guaranteed messaging.
 *)
  DPGETCAPS_GUARANTEED = $00000001;

(****************************************************************************
 *
 * GetGroupData, GetPlayerData API flags
 * Remote and local Group/Player data is maintained separately.
 * Default is DPGET_REMOTE.
 *
 ****************************************************************************)

(*
 * Get the remote data (set by any DirectPlay object in
 * the session using DPSET_REMOTE)
 *)
  DPGET_REMOTE = $00000000;

(*
 * Get the local data (set by this DirectPlay object 
 * using DPSET_LOCAL)
 *)
  DPGET_LOCAL = $00000001;

(****************************************************************************
 *
 * Open API flags
 *
 ****************************************************************************)

(*
 * Join the session that is described by the DPSESSIONDESC2 structure
 *)
  DPOPEN_JOIN = $00000001;

(*
 * Create a new session as described by the DPSESSIONDESC2 structure
 *)
  DPOPEN_CREATE = $00000002;

(*
 * Return status about progress of open instead of showing
 * any status dialogs.
 *)
  DPOPEN_RETURNSTATUS = DPENUMSESSIONS_RETURNSTATUS;

(****************************************************************************
 *
 * DPLCONNECTION flags
 *
 ****************************************************************************)

(*
 * This application should create a new session as
 * described by the DPSESIONDESC structure
 *)
  DPLCONNECTION_CREATESESSION = DPOPEN_CREATE;

(*
 * This application should join the session described by
 * the DPSESIONDESC structure with the lpAddress data
 *)
  DPLCONNECTION_JOINSESSION = DPOPEN_JOIN;

(****************************************************************************
 *
 * Receive API flags
 * Default is DPRECEIVE_ALL
 *
 ****************************************************************************)

(*
 * Get the first message in the queue
 *)
  DPRECEIVE_ALL = $00000001;

(*
 * Get the first message in the queue directed to a specific player 
 *)
  DPRECEIVE_TOPLAYER = $00000002;

(*
 * Get the first message in the queue from a specific player
 *)
  DPRECEIVE_FROMPLAYER = $00000004;

(*
 * Get the message but don't remove it from the queue
 *)
  DPRECEIVE_PEEK = $00000008;

(****************************************************************************
 *
 * Send API flags
 *
 ****************************************************************************)

(*
 * Send the message using a guaranteed send method.
 * Default is non-guaranteed.
 *)
  DPSEND_GUARANTEED = $00000001;

(*
 * This flag is obsolete. It is ignored by DirectPlay
 *)
  DPSEND_HIGHPRIORITY = $00000002;

(*
 * This flag is obsolete. It is ignored by DirectPlay
 *)
  DPSEND_OPENSTREAM = $00000008;

(*
 * This flag is obsolete. It is ignored by DirectPlay
 *)
  DPSEND_CLOSESTREAM = $00000010;

(*
 * Send the message digitally signed to ensure authenticity.
 *)
  DPSEND_SIGNED = $00000020;

(*
 * Send the message with encryption to ensure privacy.
 *)
  DPSEND_ENCRYPTED = $00000040;

(*
 * The message is a lobby system message
 *)
  DPSEND_LOBBYSYSTEMMESSAGE = $00000080;

(*
 * andyco - added this so we can make addforward async.
 * needs to be sanitized when we add / expose full async
 * support.  8/3/97.
 *)
  DPSEND_ASYNC = $00000200;

(*
 * When a message is completed, don't tell me.
 * by default the application is notified with a system message.
 *)
  DPSEND_NOSENDCOMPLETEMSG = $00000400;


(*
 * Maximum priority for sends available to applications
 *)
  DPSEND_MAX_PRI = $0000FFFF;
  DPSEND_MAX_PRIORITY = DPSEND_MAX_PRI;

(****************************************************************************
 *
 * SetGroupData, SetGroupName, SetPlayerData, SetPlayerName,
 * SetSessionDesc API flags.
 * Default is DPSET_REMOTE.
 *
 ****************************************************************************)

(* 
 * Propagate the data to all players in the session
 *)
  DPSET_REMOTE = $00000000;

(*
 * Do not propagate the data to other players
 *)
  DPSET_LOCAL = $00000001;

(*
 * Used with DPSET_REMOTE, use guaranteed message send to
 * propagate the data
 *)
  DPSET_GUARANTEED = $00000002;

(****************************************************************************
 *
 * GetMessageQueue API flags.
 * Default is DPMESSAGEQUEUE_SEND
 *
 ****************************************************************************)

(*
 * Get Send Queue - requires Service Provider Support
 *)
  DPMESSAGEQUEUE_SEND = $00000001;

(*
 * Get Receive Queue
 *)
  DPMESSAGEQUEUE_RECEIVE = $00000002;

(****************************************************************************
 *
 * Connect API flags
 *
 ****************************************************************************)

(*
 * Start an asynchronous connect which returns status codes
 *)
  DPCONNECT_RETURNSTATUS = DPENUMSESSIONS_RETURNSTATUS;

(****************************************************************************
 *
 * DirectPlay system messages and message data structures
 *
 * All system message come 'From' player DPID_SYSMSG.  To determine what type 
 * of message it is, cast the lpData from Receive to TDPMsg_Generic and check
 * the dwType member against one of the following DPSYS_xxx constants. Once
 * a match is found, cast the lpData to the corresponding of the DPMSG_xxx
 * structures to access the data of the message.
 *
 ****************************************************************************)

(*
 * A new player or group has been created in the session
 * Use TDPMsg_CreatePlayerOrGroup.  Check dwPlayerType to see if it
 * is a player or a group.
 *)
  DPSYS_CREATEPLAYERORGROUP = $0003;

(*
 * A player has been deleted from the session
 * Use TDPMsg_DestroyPlayerOrGroup
 *)
  DPSYS_DESTROYPLAYERORGROUP = $0005;

(*
 * A player has been added to a group
 * Use DPMSG_ADDPLAYERTOGROUP
 *)
  DPSYS_ADDPLAYERTOGROUP = $0007;

(*
 * A player has been removed from a group
 * Use DPMSG_DELETEPLAYERFROMGROUP
 *)
  DPSYS_DELETEPLAYERFROMGROUP = $0021;

(*
 * This DirectPlay object lost its connection with all the
 * other players in the session.
 * Use DPMSG_SESSIONLOST.
 *)
  DPSYS_SESSIONLOST = $0031;

(*
 * The current host has left the session.
 * This DirectPlay object is now the host.
 * Use DPMSG_HOST.
 *)
  DPSYS_HOST = $0101;

(*
 * The remote data associated with a player or
 * group has changed. Check dwPlayerType to see
 * if it is a player or a group
 * Use DPMSG_SETPLAYERORGROUPDATA
 *)
  DPSYS_SETPLAYERORGROUPDATA = $0102;

(*
 * The name of a player or group has changed.
 * Check dwPlayerType to see if it is a player
 * or a group.
 * Use TDPMsg_SetPlayerOrGroupName
 *)
  DPSYS_SETPLAYERORGROUPNAME = $0103;

(*
 * The session description has changed.
 * Use DPMSG_SETSESSIONDESC
 *)
  DPSYS_SETSESSIONDESC = $0104;

(*
 * A group has been added to a group
 * Use TDPMsg_AddGroupToGroup
 *)
  DPSYS_ADDGROUPTOGROUP = $0105;

(*
 * A group has been removed from a group
 * Use DPMsg_DeleteGroupFromGroup
 *)
  DPSYS_DELETEGROUPFROMGROUP = $0106;

(*
 * A secure player-player message has arrived.
 * Use DPMSG_SECUREMESSAGE
 *)
  DPSYS_SECUREMESSAGE = $0107;

(*
 * Start a new session.
 * Use DPMSG_STARTSESSION
 *)
  DPSYS_STARTSESSION = $0108;

(*
 * A chat message has arrived
 * Use DPMSG_CHAT
 *)
  DPSYS_CHAT = $0109;

(*
 * The owner of a group has changed
 * Use DPMSG_SETGROUPOWNER
 *)
  DPSYS_SETGROUPOWNER = $010A;

(*
 * An async send has finished, failed or been cancelled
 * Use DPMSG_SENDCOMPLETE
 *)
  DPSYS_SENDCOMPLETE = $010D;

(*
 * Used in the dwPlayerType field to indicate if it applies to a group
 * or a player
 *)
  DPPLAYERTYPE_GROUP = $00000000;
  DPPLAYERTYPE_PLAYER = $00000001;

type
(*
 * TDPMsg_Generic
 * Generic message structure used to identify the message type.
 *)
  PDPMsg_Generic = ^TDPMsg_Generic;
  TDPMsg_Generic = packed record
    dwType: DWORD;   // Message type
  end;

(*
 * TDPMsg_CreatePlayerOrGroup
 * System message generated when a new player or group
 * created in the session with information about it.
 *)
  PDPMsg_CreatePlayerOrGroup = ^TDPMsg_CreatePlayerOrGroup;
  TDPMsg_CreatePlayerOrGroup = packed record
    dwType: DWORD;             // Message type
    dwPlayerType: DWORD;       // Is it a player or group
    DPID: TDPID;               // ID of the player or group
    dwCurrentPlayers: DWORD;   // current # players & groups in session
    lpData: Pointer;           // pointer to remote data
    dwDataSize: DWORD;         // size of remote data
    dpnName: TDPName;           // structure with name info
                               // the following fields are only available when using
                               // the IDirectPlay3 interface or greater
    dpIdParent: TDPID;         // id of parent group
    dwFlags: DWORD;            // player or group flags
  end;

(*
 * TDPMsg_DestroyPlayerOrGroup
 * System message generated when a player or group is being
 * destroyed in the session with information about it.
 *)
  PDPMsg_DestroyPlayerOrGroup= ^TDPMsg_DestroyPlayerOrGroup;
  TDPMsg_DestroyPlayerOrGroup = packed record
    dwType: DWORD;             // Message type
    dwPlayerType: DWORD;       // Is it a player or group
    DPID: TDPID;                // player ID being deleted
    lpLocalData: Pointer;      // copy of players local data
    dwLocalDataSize: DWORD;    // sizeof local data
    lpRemoteData: Pointer;     // copy of players remote data
    dwRemoteDataSize: DWORD;   // sizeof remote data
                               // the following fields are only available when using
                               // the IDirectPlay3 interface or greater
    dpnName: TDPName;           // structure with name info
    dpIdParent: TDPID;          // id of parent group
    dwFlags: DWORD;            // player or group flags
  end;

(*
 * DPMSG_ADDPLAYERTOGROUP
 * System message generated when a player is being added
 * to a group.
 *)
  PDPMsg_AddPlayerToGroup = ^TDPMsg_AddPlayerToGroup;
  TDPMsg_AddPlayerToGroup = packed record
    dwType: DWORD;      // Message type
    dpIdGroup: TDPID;    // group ID being added to
    dpIdPlayer: TDPID;   // player ID being added
  end;

(*
 * DPMSG_DELETEPLAYERFROMGROUP
 * System message generated when a player is being
 * removed from a group
 *)
  PDPMsg_DeletePlayerFromGroup = ^TDPMsg_DeletePlayerFromGroup;
  TDPMsg_DeletePlayerFromGroup = TDPMsg_AddPlayerToGroup;

(*
 * TDPMsg_AddGroupToGroup
 * System message generated when a group is being added
 * to a group.
 *)
  PDPMsg_AddGroupToGroup = ^TDPMsg_AddGroupToGroup;
  TDPMsg_AddGroupToGroup = packed record
    dwType: DWORD;           // Message type
    dpIdParentGroup: TDPID;   // group ID being added to
    dpIdGroup: TDPID;         // group ID being added
  end;

(*
 * DPMsg_DeleteGroupFromGroup
 * System message generated when a GROUP is being
 * removed from a group
 *)
  PDPMsg_DeleteGroupFromGroup = ^TDPMsg_DeleteGroupFromGroup;
  TDPMsg_DeleteGroupFromGroup = TDPMsg_AddGroupToGroup;

(*
 * DPMSG_SETPLAYERORGROUPDATA
 * System message generated when remote data for a player or
 * group has changed.
 *)
  PDPMsg_SetPlayerOrGroupData = ^TDPMsg_SetPlayerOrGroupData;
  TDPMsg_SetPlayerOrGroupData = packed record
    dwType: DWORD;         // Message type
    dwPlayerType: DWORD;   // Is it a player or group
    DPID: TDPID;           // ID of player or group
    lpData: Pointer;       // pointer to remote data
    dwDataSize: DWORD;     // size of remote data
  end;

(*
 * DPMSG_SETPLAYERORGROUPNAME
 * System message generated when the name of a player or
 * group has changed.
 *)
  PDPMsg_SetPlayerOrGroupName = ^TDPMsg_SetPlayerOrGroupName;
  TDPMsg_SetPlayerOrGroupName = packed record
    dwType: DWORD;         // Message type
    dwPlayerType: DWORD;   // Is it a player or group
    DPID: TDPID;           // ID of player or group
    dpnName: TDPName;      // structure with new name info
  end;

(*
 * DPMSG_SETSESSIONDESC
 * System message generated when                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              