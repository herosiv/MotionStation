/* $Revision: 1.2 $ */
/*	ddeml.h for lcc (contributed by jl Hamel) */
#ifndef	_INC_DDEMLH
#define	_INC_DDEMLH
#ifndef	_GNU_H_WIN32Headers
#include	<win.h>
#endif
#define	_HSZ_DEFINED
#define	EXPENTRY CALLBACK
typedef	SECURITY_QUALITY_OF_SERVICE *PSECURITY_QUALITY_OF_SERVICE;
typedef	HSZPAIR *PHSZPAIR;
typedef	CONVCONTEXT *PCONVCONTEXT;
typedef	CONVINFO *PCONVINFO;
#define	XST_NULL 0
#define	XST_INCOMPLETE 1
#define	XST_CONNECTED 2
#define	XST_INIT1 3
#define	XST_INIT2 4
#define	XST_REQSENT 5
#define	XST_DATARCVD 6
#define	XST_POKESENT 7
#define	XST_POKEACKRCVD 8
#define	XST_EXECSENT 9
#define	XST_EXECACKRCVD 10
#define	XST_ADVSENT 11
#define	XST_UNADVSENT 12
#define	XST_ADVACKRCVD 13
#define	XST_UNADVACKRCVD 14
#define	XST_ADVDATASENT 15
#define	XST_ADVDATAACKRCVD 16
#define	CADV_LATEACK 0xFFFF
#define	ST_CONNECTED 0x0001
#define	ST_ADVISE 0x0002
#define	ST_ISLOCAL 0x0004
#define	ST_BLOCKED 0x0008
#define	ST_CLIENT 0x0010
#define	ST_TERMINATED 0x0020
#define	ST_INLIST 0x0040
#define	ST_BLOCKNEXT 0x0080
#define	ST_ISSELF 0x0100
#define	DDE_FACK 0x8000
#define	DDE_FBUSY 0x4000
#define	DDE_FDEFERUPD 0x4000
#define	DDE_FACKREQ 0x8000
#define	DDE_FRELEASE 0x2000
#define	DDE_FREQUESTED 0x1000
#define	DDE_FAPPSTATUS 0x00ff
#define	DDE_FNOTPROCESSED 0x0000
#define	DDE_FACKRESERVED (~(DDE_FACK | DDE_FBUSY | DDE_FAPPSTATUS))
#define	DDE_FADVRESERVED (~(DDE_FACKREQ | DDE_FDEFERUPD))
#define	DDE_FDATRESERVED (~(DDE_FACKREQ | DDE_FRELEASE | DDE_FREQUESTED))
#define	DDE_FPOKRESERVED (~(DDE_FRELEASE))
#define	MSGF_DDEMGR 0x8001
#define	CP_WINANSI 1004
#define	CP_WINUNICODE 1200
#define	XTYPF_NOBLOCK 0x0002
#define	XTYPF_NODATA 0x0004
#define	XTYPF_ACKREQ 0x0008
#define	XCLASS_MASK 0xFC00
#define	XCLASS_BOOL 0x1000
#define	XCLASS_DATA 0x2000
#define	XCLASS_FLAGS 0x4000
#define	XCLASS_NOTIFICATION 0x8000
#define	XTYP_ERROR (0x0000 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK )
#define	XTYP_ADVDATA (0x0010 | XCLASS_FLAGS )
#define	XTYP_ADVREQ (0x0020 | XCLASS_DATA | XTYPF_NOBLOCK )
#define	XTYP_ADVSTART (0x0030 | XCLASS_BOOL )
#define	XTYP_ADVSTOP (0x0040 | XCLASS_NOTIFICATION)
#define	XTYP_EXECUTE (0x0050 | XCLASS_FLAGS )
#define	XTYP_CONNECT (0x0060 | XCLASS_BOOL | XTYPF_NOBLOCK)
#define	XTYP_CONNECT_CONFIRM (0x0070 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK)
#define	XTYP_XACT_COMPLETE (0x0080 | XCLASS_NOTIFICATION )
#define	XTYP_POKE (0x0090 | XCLASS_FLAGS )
#define	XTYP_REGISTER (0x00A0 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK)
#define	XTYP_REQUEST (0x00B0 | XCLASS_DATA )
#define	XTYP_DISCONNECT (0x00C0 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK)
#define	XTYP_UNREGISTER (0x00D0 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK)
#define	XTYP_WILDCONNECT (0x00E0 | XCLASS_DATA | XTYPF_NOBLOCK)
#define	XTYP_MASK 0x00F0
#define	XTYP_SHIFT 4
#define	TIMEOUT_ASYNC 0xFFFFFFFF
#define	QID_SYNC 0xFFFFFFFF

#ifdef	UNICODE
#define	SZDDESYS_TOPIC L"System"
#define	SZDDESYS_ITEM_TOPICS L"Topics"
#define	SZDDESYS_ITEM_SYSITEMS L"SysItems"
#define	SZDDESYS_ITEM_RTNMSG L"ReturnMessage"
#define	SZDDESYS_ITEM_STATUS L"Status"
#define	SZDDESYS_ITEM_FORMATS L"Formats"
#define	SZDDESYS_ITEM_HELP L"Help"
#define	SZDDE_ITEM_ITEMLIST L"TopicItemList"
#else
#define	SZDDESYS_TOPIC "System"
#define	SZDDESYS_ITEM_TOPICS "Topics"
#define	SZDDESYS_ITEM_SYSITEMS "SysItems"
#define	SZDDESYS_ITEM_RTNMSG "ReturnMessage"
#define	SZDDESYS_ITEM_STATUS "Status"
#define	SZDDESYS_ITEM_FORMATS "Formats"
#define	SZDDESYS_ITEM_HELP "Help"
#define	SZDDE_ITEM_ITEMLIST "TopicItemList"
#endif

typedef	HDDEDATA CALLBACK FNCALLBACK(UINT,UINT,HCONV,
	HSZ,HSZ,HDDEDATA,DWORD,DWORD);
typedef	HDDEDATA (CALLBACK *PFNCALLBACK)(UINT,UINT,HCONV,
	HSZ,HSZ,HDDEDATA,DWORD,DWORD);

#define	CBR_BLOCK ((HDDEDATA)0xffffffffL)

UINT	WINAPI DdeInitializeA(LPDWORD,PFNCALLBACK,DWORD,DWORD);
UINT	WINAPI DdeInitializeW(LPDWORD,PFNCALLBACK,DWORD,DWORD);
#ifdef	UNICODE
#define	DdeInitialize DdeInitializeW
#else
#define	DdeInitialize DdeInitializeA
#endif

#define	CBF_FAIL_SELFCONNECTIONS 0x00001000
#define	CBF_FAIL_CONNECTIONS 0x00002000
#define	CBF_FAIL_ADVISES 0x00004000
#define	CBF_FAIL_EXECUTES 0x00008000
#define	CBF_FAIL_POKES 0x00010000
#define	CBF_FAIL_REQUESTS 0x00020000
#define	CBF_FAIL_ALLSVRXACTIONS 0x0003f000
#define	CBF_SKIP_CONNECT_CONFIRMS 0x00040000
#define	CBF_SKIP_REGISTRATIONS 0x00080000
#define	CBF_SKIP_UNREGISTRATIONS 0x00100000
#define	CBF_SKIP_DISCONNECTS 0x00200000
#define	CBF_SKIP_ALLNOTIFICATIONS 0x003c0000
#define	APPCMD_CLIENTONLY 0x00000010L
#define	APPCMD_FILTERINITS 0x00000020L
#define	APPCMD_MASK 0x00000FF0L
#define	APPCLASS_STANDARD 0x00000000L
#define	APPCLASS_MASK 0x0000000FL

BOOL	WINAPI DdeUninitialize(DWORD idInst);
HCONVLIST	WINAPI DdeConnectList(DWORD,HSZ,HSZ,HCONVLIST,PCONVCONTEXT);
HCONV	WINAPI DdeQueryNextServer(HCONVLIST,HCONV);
BOOL	WINAPI DdeDisconnectList(HCONVLIST);
HCONV	WINAPI DdeConnect(DWORD,HSZ,HSZ,PCONVCONTEXT);
BOOL	WINAPI DdeDisconnect(HCONV);
HCONV	WINAPI DdeReconnect(HCONV);
UINT	WINAPI DdeQueryConvInfo(HCONV,DWORD,PCONVINFO);
BOOL	WINAPI DdeSetUserHandle(HCONV,DWORD,DWORD);
BOOL	WINAPI DdeAbandonTransaction(DWORD,HCONV,DWORD);
BOOL	WINAPI DdePostAdvise(DWORD,HSZ,HSZ);
BOOL	WINAPI DdeEnableCallback(DWORD,HCONV,UINT);
BOOL	WINAPI DdeImpersonateClient(HCONV);

#define	EC_ENABLEALL 0
#define	EC_ENABLEONE ST_BLOCKNEXT
#define	EC_DISABLE ST_BLOCKED
#define	EC_QUERYWAITING 2

HDDEDATA	WINAPI DdeNameService(DWORD,HSZ,HSZ,UINT);

#define	DNS_REGISTER 0x0001
#define	DNS_UNREGISTER 0x0002
#define	DNS_FILTERON 0x0004
#define	DNS_FILTEROFF 0x0008

HDDEDATA	WINAPI DdeClientTransaction(LPBYTE,DWORD,HCONV,HSZ,UINT,
	UINT,DWORD,LPDWORD);
HDDEDATA	WINAPI DdeCreateDataHandle(DWORD,LPBYTE,DWORD,
	DWORD,HSZ,UINT,UINT);
HDDEDATA	WINAPI DdeAddData(HDDEDATA,LPBYTE,DWORD,DWORD);
DWORD	WINAPI DdeGetData(HDDEDATA,LPBYTE,DWORD,DWORD);
LPBYTE	WINAPI DdeAccessData(HDDEDATA,LPDWORD);
BOOL	WINAPI DdeUnaccessData(HDDEDATA);
BOOL	WINAPI DdeFreeDataHandle(HDDEDATA);

#define	HDATA_APPOWNED 0x0001

UINT	WINAPI DdeGetLastError(DWORD);

#define	DMLERR_NO_ERROR 0
#define	DMLERR_FIRST 0x4000
#define	DMLERR_ADVACKTIMEOUT 0x4000
#define	DMLERR_BUSY 0x4001
#define	DMLERR_DATAACKTIMEOUT 0x4002
#define	DMLERR_DLL_NOT_INITIALIZED 0x4003
#define	DMLERR_DLL_USAGE 0x4004
#define	DMLERR_EXECACKTIMEOUT 0x4005
#define	DMLERR_INVALIDPARAMETER 0x4006
#define	DMLERR_LOW_MEMORY 0x4007
#define	DMLERR_MEMORY_ERROR 0x4008
#define	DMLERR_NOTPROCESSED 0x4009
#define	DMLERR_NO_CONV_ESTABLISHED 0x400a
#define	DMLERR_POKEACKTIMEOUT 0x400b
#define	DMLERR_POSTMSG_FAILED 0x400c
#define	DMLERR_REENTRANCY 0x400d
#define	DMLERR_SERVER_DIED 0x400e
#define	DMLERR_SYS_ERROR 0x400f
#define	DMLERR_UNADVACKTIMEOUT 0x4010
#define	DMLERR_UNFOUND_QUEUE_ID 0x4011
#define	DMLERR_LAST 0x4011

HSZ	WINAPI DdeCreateStringHandleA(DWORD,LPCSTR,int);
HSZ	WINAPI DdeCreateStringHandleW(DWORD,LPCWSTR,int);
#ifdef	UNICODE
#define	DdeCreateStringHandle DdeCreateStringHandleW
#else
#define	DdeCreateStringHandle DdeCreateStringHandleA
#endif
DWORD	WINAPI DdeQueryStringA(DWORD,HSZ,LPSTR,DWORD,int);
DWORD	WINAPI DdeQueryStringW(DWORD,HSZ,LPWSTR,DWORD,int);
#ifdef	UNICODE
#define	DdeQueryString DdeQueryStringW
#else
#define	DdeQueryString DdeQueryStringA
#endif
BOOL	WINAPI DdeFreeStringHandle(DWORD,HSZ);
BOOL	WINAPI DdeKeepStringHandle(DWORD,HSZ);
int	WINAPI DdeCmpStringHandles(HSZ,HSZ);

#ifndef	NODDEMLSPY

typedef	DDEML_MSG_HOOK_DATA *PDDEML_MSG_HOOK_DATA;
typedef	MONCBSTRUCT *PMONCBSTRUCT;
typedef	MONHSZSTRUCT *PMONHSZSTRUCT;
#ifdef	UNICODE
#define	MONHSZSTRUCTW MONHSZSTRUCT; 
#define	PMONHSZSTRUCTW PMONHSZSTRUCT;
#else
#define	MONHSZSTRUCTA MONHSZSTRUCT;
#define	PMONHSZSTRUCTA PMONHSZSTRUCT;
#endif

#define	MH_CREATE 1
#define	MH_KEEP 2
#define	MH_DELETE 3
#define	MH_CLEANUP 4

typedef	MONERRSTRUCT *PMONERRSTRUCT;
typedef	MONLINKSTRUCT *PMONLINKSTRUCT;
typedef	MONCONVSTRUCT *PMONCONVSTRUCT;

#define	MAX_MONITORS 4
#define	APPCLASS_MONITOR 0x00000001L
#define	XTYP_MONITOR (0x00F0 | XCLASS_NOTIFICATION | XTYPF_NOBLOCK)
#define	MF_HSZ_INFO 0x01000000
#define	MF_SENDMSGS 0x02000000
#define	MF_POSTMSGS 0x04000000
#define	MF_CALLBACKS 0x08000000
#define	MF_ERRORS 0x10000000
#define	MF_LINKS 0x20000000
#define	MF_CONV 0x40000000
#define	MF_MASK 0xFF000000

#endif

#endif
