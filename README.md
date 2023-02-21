
# 
#Installation:

(dependencies):
> pkg install tcl86 tk86

> mkdir -p /opt/wafelka

> chown -R $USER /opt/wafelka

> cd /opt/

> git clone https://github.com/Clockwork6400/wafelka.git

> cp wafelka/wafelka.desktop /usr/local/share/applications/wafelka.desktop


#Launch:

> /usr/local/bin/wish8.6 /opt/wafelka/wafelka.tcl
> 
or
> mouse from the menu

#Removal:

> rm /usr/local/share/applications/wafelka.desktop

> rm -rf /opt/wafelka/

---

wafelka is a program for quick wi-fi setup and switching that will help you connect to the network with minimal effort. If wi-fi has not been configured according to the relevant documentation for the handbook, then the program will try to configure it.

The buttons in the program correspond to all available SSID/MESH at the time the program is launched. Pressing the button selects the network to connect to. The "more" checkbox allows you to show
more networks available.

After selecting the desired network, you will be prompted to enter the password twice from the access point.
The entered password and login will be saved in /etc/wpa_supplicant.conf and the service will be restarted.

---

EOF.
