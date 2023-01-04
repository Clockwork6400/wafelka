#!/usr/local/bin/wish8.6

#
# Copyright (c) 2023, Clockwork
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

set id [exec id -u]
if { "$id" != "0" } {
	puts "Don't run this as user!"
	puts "Run as root!"
	exit	  
}
set DI [exec ls -l /tmp/.X11-unix | awk {/X0/}]
if { "$DI" == "" } {
        puts "Error: no DISPLAY environment variable specified"
        exit
}
set wlan0 [exec sysctl -n net.wlan.devices]
if {$wlan0 == ""} {
	puts "Error: Wireless adapter not defined"
	exit
}
set wlans [exec awk {/wlans/} /etc/rc.conf]
set ifwlan0 [exec awk {/ifconfig_wlan0/} /etc/rc.conf]
set wpa "WPA SYNCDHCP"

if {$wlans == "" } {
	exec sysrc wlans_$wlan0=wlan0
}
if {$ifwlan0 == "" } {
	exec sysrc ifconfig_wlan0=$wpa
}

set uplink [exec ifconfig wlan0 | awk {/no carrier/}]
if {$uplink != "" } {
	exec ifconfig wlan0 up
}
set file1 [exec ls -l /etc/ | awk {/wpa_supplicant.conf/} ]
if {$file1 == "" } {
	exec touch /etc/wpa_supplicant.conf
}

set scan1 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {1p}];
set scan2 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {2p}];
set scan3 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {3p}];
set scan4 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {4p}];
set scan5 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {5p}];
set scan6 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {6p}];
set scan7 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {7p}];
set scan8 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {8p}];
set scan9 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {9p}];
set scan10 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {10p}];
set scan11 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {11p}];
set scan12 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {12p}];
set scan13 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {13p}];
set scan14 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {14p}];
set scan15 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {15p}];
set scan16 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {16p}];
set scan17 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {17p}];
set scan18 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {18p}];
set scan19 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {19p}];
set scan20 [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d} | sed -n {20p}];


#текущий ssid:
set ssid [exec awk {/ssid/} /etc/wpa_supplicant.conf | sed -e {s/ssid=//}]
#puts $ssid

#текущее содержимое wpa_supplicant
#set wpa [exec cat /etc/wpa_supplicant.conf];

grid [label .myLabel -width 35 -text " Подключено: $ssid " -textvariable labelText -font Tahoma] -padx 5 -pady 5
grid .myLabel -row 0 -column 0

grid [checkbutton .chk1 -text "more" -variable occupied1 -command {if {$occupied1 } {
	if {$scan11 != "" } {
		grid .bt11 -sticky nwes
	}
	if {$scan12 != "" } {
		grid .bt12 -sticky nwes
	}
	if {$scan13 != "" } {
		grid .bt13 -sticky nwes
	}
	if {$scan14 != "" } {
		grid .bt14 -sticky nwes
	}
	if {$scan15 != "" } {
		grid .bt15 -sticky nwes
	}
	if {$scan16 != "" } {
		grid .bt16 -sticky nwes
	}
	if {$scan17 != "" } {
		grid .bt17 -sticky nwes
	}
	if {$scan18 != "" } {
		grid .bt18 -sticky nwes
	}
	if {$scan19 != "" } {
		grid .bt19 -sticky nwes
	}
	if {$scan20 != "" } {
		grid .bt20 -sticky nwes
	}
} else {
	if {$scan11 != "" } {
		grid forget .bt11
	}
	if {$scan12 != "" } {
		grid forget .bt12
	}
	if {$scan13 != "" } {
		grid forget .bt13
	}
	if {$scan14 != "" } {
		grid forget .bt14
	}
	if {$scan15 != "" } {
		grid forget .bt15
	}
	if {$scan16 != "" } {
		grid forget .bt16
	}
	if {$scan17 != "" } {
		grid forget .bt17
	}
	if {$scan18 != "" } {
		grid forget .bt18
	}
	if {$scan19 != "" } {
		grid forget .bt19
	}
	if {$scan20 != "" } {
		grid forget .bt20
	}
} }]

if {$scan1 != "" } {
	ttk::button .bt1 -text "$scan1" -command { func1 $scan1 }
	grid .bt1 -row 2 -column 0 -sticky nwes
}
if {$scan2 != "" } {
	ttk::button .bt2 -text "$scan2" -command { func1 $scan2 }
	grid .bt2 -row 3 -column 0 -sticky nwes
}
if {$scan3 != "" } {
	ttk::button .bt3 -text "$scan3" -command { func1 $scan3 }
	grid .bt3 -row 4 -column 0 -sticky nwes
}
if {$scan4 != "" } {
	ttk::button .bt4 -text "$scan4" -command { func1 $scan4 }
	grid .bt4 -row 5 -column 0 -sticky nwes
}
if {$scan5 != "" } {
	ttk::button .bt5 -text "$scan5" -command { func1 $scan5 }
	grid .bt5 -row 6 -column 0 -sticky nwes
}
if {$scan6 != "" } {
	ttk::button .bt6 -text "$scan6" -command { func1 $scan6 }
	grid .bt6 -row 7 -column 0 -sticky nwes
}
if {$scan7 != "" } {
	ttk::button .bt7 -text "$scan7" -command { func1 $scan7 }
	grid .bt7 -row 8 -column 0 -sticky nwes
}
if {$scan8 != "" } {
	ttk::button .bt8 -text "$scan8" -command { func1 $scan8 }
	grid .bt8 -row 9 -column 0 -sticky nwes
}
if {$scan9 != "" } {
	ttk::button .bt9 -text "$scan9" -command { func1 $scan9 }
	grid .bt9 -row 10 -column 0 -sticky nwes
}
if {$scan10 != "" } {
	ttk::button .bt10 -text "$scan10" -command { func1 $scan10 }
	grid .bt10 -row 11 -column 0 -sticky nwes
}
if {$scan11 != "" } {
	ttk::button .bt11 -text "$scan11" -command { func1 $scan11 }
	grid .bt11 -row 12 -column 0 -sticky nwes
}
if {$scan12 != "" } {
	ttk::button .bt12 -text "$scan12" -command { func1 $scan12 }
	grid .bt12 -row 13 -column 0 -sticky nwes
}
if {$scan13 != "" } {
	ttk::button .bt13 -text "$scan13" -command { func1 $scan13 }
	grid .bt13 -row 14 -column 0 -sticky nwes
}
if {$scan14 != "" } {
	ttk::button .bt14 -text "$scan14" -command { func1 $scan14 }
	grid .bt14 -row 15 -column 0 -sticky nwes
}
if {$scan15 != "" } {
	ttk::button .bt15 -text "$scan15" -command { func1 $scan15 }
	grid .bt15 -row 16 -column 0 -sticky nwes
}
if {$scan16 != "" } {
	ttk::button .bt16 -text "$scan16" -command { func1 $scan16 }
	grid .bt16 -row 17 -column 0 -sticky nwes
}
if {$scan17 != "" } {
	ttk::button .bt17 -text "$scan17" -command { func1 $scan17 }
	grid .bt17 -row 18 -column 0 -sticky nwes
}
if {$scan18 != "" } {
	ttk::button .bt18 -text "$scan18" -command { func1 $scan18 }
	grid .bt18 -row 19 -column 0 -sticky nwes
}
if {$scan19 != "" } {
	ttk::button .bt19 -text "$scan19" -command { func1 $scan19 }
	grid .bt19 -row 20 -column 0 -sticky nwes
}
if {$scan20 != "" } {
	ttk::button .bt20 -text "$scan20" -command { func1 $scan20 }
	grid .bt20 -row 21 -column 0 -sticky nwes
}

if {$scan11 != "" } {
	grid forget .bt11
}
if {$scan12 != "" } {
	grid forget .bt12
}
if {$scan13 != "" } {
	grid forget .bt13
}
if {$scan14 != "" } {
	grid forget .bt14
}
if {$scan15 != "" } {
	grid forget .bt15
}
if {$scan16 != "" } {
	grid forget .bt16
}
if {$scan17 != "" } {
	grid forget .bt17
}
if {$scan18 != "" } {
	grid forget .bt18
}
if {$scan19 != "" } {
	grid forget .bt19
}
if {$scan20 != "" } {
	grid forget .bt20
}

proc func1 { var1 } {
#	puts "$var1"
	global scan1 scan2 scan3 scan4 scan5 scan6 scan7 scan8 scan9 scan10 scan11 scan12 scan13 scan14 scan15 scan16 scan17 scan18 scan19 scan20
	ttk::labelframe .fr -padding "5 5 5 5" -text "Enter password:"
	grid .fr -column 0 -row 0 -sticky nwes -padx 5 -pady 5

	proc tellme { var1 var2 var3 } {
        	global form
        	foreach line [array names form] {
#                puts "$var1"
        	}
        	global form2
        	foreach line [array names form2] {
#                puts "$form2($line)"
       		}
        	if {"$form($line)" == "$form2($line)" } {
			if {"$form($line)" == "" } {
				puts "What kind of fool puts a blank password on the router?"
			}
			set fp [open /etc/wpa_supplicant.conf w+]
			puts $fp "network={"
			puts $fp ssid="$var1"
			puts $fp psk="$form($line)"
			puts $fp "}"
			close $fp

			grid forget .fr.myLabel2 .fr.myLabel3 .fr.upd 
			#.fr.exi
			grid forget .fr.lab$var2 .fr.lab2$var3
			grid forget .fr.ent$var2 .fr.ent2$var3

			grid [label .fr.ok -text "OK" -textvariable labelOK -font Tahoma] -padx 5 -pady 5
			grid .fr.ok -row 3 -column 0

			puts "Please, wait..."
			
			exec service netif restart 2>&1
        	} else {
        	        puts "Warning: Passwords do not match"
        	}
	}
	set fields {Password}
	set fields2 {Password}

	foreach field $fields {
        	label .fr.lab$field -text $field
        	entry .fr.ent$field -textvariable form($field)
        	grid .fr.lab$field .fr.ent$field -sticky news
        	bind .fr.ent$field <Return> "tellme $var1 $fields $fields2"
	}
	foreach field2 $fields2 {
        	label .fr.lab2$field2 -text $field2
        	entry .fr.ent2$field2 -textvariable form2($field2)
        	grid .fr.lab2$field2 .fr.ent2$field2
        	bind .fr.ent2$field2 <Return> "tellme $var1 $fields $fields2"
	}
	
	button .fr.upd -text "OK" -command "tellme $var1 $field $field2"
	button .fr.exi -text Exit -command exit
	#grid .fr.upd .fr.exi -sticky news
	grid .fr.upd -row 3 -column 0 -sticky nwes
	grid .fr.exi -row 3 -column 1 -sticky nwes

	grid forget .chk1 

	if {$scan1 != "" } {
	grid forget .bt1
	}
	if {$scan2 != "" } {
	grid forget .bt2
	}
	if {$scan3 != "" } {
	grid forget .bt3
	}
	if {$scan4 != "" } {
	grid forget .bt4
	}
	if {$scan5 != "" } {
	grid forget .bt5
	}
	if {$scan6 != "" } {
	grid forget .bt6
	}
	if {$scan7 != "" } {
	grid forget .bt7
	}
	if {$scan8 != "" } {
	grid forget .bt8
	}
	if {$scan9 != "" } {
	grid forget .bt9
	}
	if {$scan10 != "" } {
	grid forget .bt10
	}
	if {$scan11 != "" } {
	grid forget .bt11
	}
	if {$scan12 != "" } {
	grid forget .bt12
	}
	if {$scan13 != "" } {
	grid forget .bt13
	}
	if {$scan14 != "" } {
	grid forget .bt14
	}
	if {$scan15 != "" } {
	grid forget .bt15
	}
	if {$scan16 != "" } {
	grid forget .bt16
	}
	if {$scan17 != "" } {
	grid forget .bt17
	}
	if {$scan18 != "" } {
	grid forget .bt18
	}
	if {$scan19 != "" } {
	grid forget .bt19
	}
	if {$scan20 != "" } {
	grid forget .bt20
	}

	grid [label .fr.myLabel2 -text "Выбрано устройство: " -textvariable labelText2 -font Tahoma];
	grid [label .fr.myLabel3 -text "$var1" -textvariable labelText3 -font Tahoma];
	grid .fr.myLabel2 -row 0 -column 2
	grid .fr.myLabel3 -row 1 -column 2
}
#EOF
