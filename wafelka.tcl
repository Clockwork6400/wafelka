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
set TTY [exec w | awk {/w/} | awk {/:0 /}]
	if { "$TTY" == "" } {
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

set scanx [exec ifconfig wlan0 list scan | awk {{print $1}} | sed {1d}]
set lines    [ split $scanx "\n" ]

set result {}
foreach line [split $scanx \n] {
                lappend result $line
}

set max [llength $result]

#текущий ssid:
set ssid [exec awk {/ssid/} /etc/wpa_supplicant.conf | sed -e {s/ssid=//}]
#puts $ssid

#текущее содержимое wpa_supplicant
#set wpa [exec cat /etc/wpa_supplicant.conf];

grid [label .myLabel -width 35 -text " Подключено: $ssid " -textvariable labelText -font Tahoma] -padx 5 -pady 5
grid .myLabel -row 0 -column 0

set max [llength $result]

grid [checkbutton .chk1 -text "more" -variable occupied1 -command {if {$occupied1 } {
	for {set i 11} {$i < $max} {incr i} {
		grid .bt$i -column 0 -row 1$i -sticky nwes 
	}
} else {
	for {set i 11} {$i < $max} {incr i} {
		grid forget .bt$i 
	}
} }]

for {set i 0} {$i < $max} {incr i} {
        set var2 [lindex $result $i]
        if {$var2 != "" } {
	#	puts $var2
		ttk::button .bt$i -text "$var2" -command [list func1 $var2]
		grid .bt$i -row 1$i -column 0 -sticky nwes
        }
}

for {set i 11} {$i < $max} {incr i} {
	grid forget .bt$i
}


proc func1 { var1 } {
#	puts "$var1"
	global scanx
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

	global max
	for {set i 0} {$i < $max} {incr i} {
		grid forget .bt$i
	}

	grid [label .fr.myLabel2 -text "Выбрано устройство: " -textvariable labelText2 -font Tahoma];
	grid [label .fr.myLabel3 -text "$var1" -textvariable labelText3 -font Tahoma];
	grid .fr.myLabel2 -row 0 -column 2
	grid .fr.myLabel3 -row 1 -column 2
}
#================================================================= EOF
