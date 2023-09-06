#define GAMEMODE_VERSION    "0.1"

const SPAWN_VW          = 1337  ;
const LVPD_VW     	    = 1338  ;
const GTOWN_VW    	    = 1339  ;
const RCBTF_VW		    = 2000  ;
const JAILED_VW 		= 2001  ;
const LVPD2_VW     	    = 2002  ;
const GHOST2_VW     	= 2003  ;
const WHOUSE_VW 		= 2005  ;
const SOAR_VW			= 2006  ;

#define InfoMessage(%0,%1) \
	SendClientMessage(%0, 0x0070D0FF, ""%1)

#define SCMTA       						SendClientMessageToAll
#define C3D 								CreateDynamic3DTextLabel
#define CDP 								CreateDynamicPickup

#define COLOR_GRAY2							0x8C8C8CFF
#define COLOR_PURPLE        				0xFF2DFFFF
#define COLOR_YELLOW						0xFFFF06FF
#define COLOR_SERVER2 						0x0070D0FF
#define COLOR_RED2         				 	0xFF6347AA
#define COLOR_ARENA        					0x5AB7C7AA

#define COLOR_SERVER 						"{0070D0}"
#define COLOR_WHITE							"{FFFFFF}"
#define COLOR_GRAY							"{797979}"
#define COLOR_RED 			    			"{FF6347}"

// #define function%0(%1) forward%0(%1); public%0(%1)

#define echo%0\10;%9 printf(#%0);

stock bool:DONE_FALSE = false;
#define loop%8\10;%9 for (new %8)REMOVE_ME:(%8)
#define in{%0..%1})REMOVE_ME:(%9\32;%2\32;%9) =%0;%2!=%1;++%2)
#define do%8\10;%9 {%8
#define done%8\10;%9 }%8

#define check[%0]%8\10;%9 if(%0)%8
#define then%8\10;%9 {%8
#define ifnot%8\10;%9 }else{%8
#define elif[%0]%8\10;%9 }else if(%0){%8
#define fi%8\10;%9 }%8

#define lt 0<  // -lt
#define le 0<= // -le
#define eq 0== // -eq
#define ne 0!= // -ne
#define ge 0>= // -ge
#define gt 0>  // -gt
#define or ||
#define and &&

#define breaker%0\10;%9 switch(%0)
#define of) ){case cellmin:{
#define _case%0) }case %0:{
#define _default) }default:{
#define esac }}

#define DIALOG_EMAIL 9
#define DIALOG_CHOOSELANG 10

#define IsValidEmail(%1) \
    regex_match(%1, "[a-zA-Z0-9_\\.]+@([a-zA-Z0-9\\-]+\\.)+[a-zA-Z]{2,4}")