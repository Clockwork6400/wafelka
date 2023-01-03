
# 
#Установка / Installation:

(зависимости / dependencies):
> sudo pkg install tcl86 tk86

> sudo mkdir -p /opt/wafelka

> sudo chown -R $USER /opt/

> cd /opt/

> git clone https://github.com/Clockwork6400/wafelka.git

> cp wafelka/wafelka.desktop /usr/local/share/applications/wafelka.desktop


#Запуск / Launch:

> /usr/local/bin/wish8.6 /opt/wafelka/wafelka.tcl
> 
or / или
> mouse from the menu

#Удаление / Removal:

> rm /usr/local/share/applications/wafelka.desktop

> rm -rf /opt/wafelka/

---

wafelka - программа для быстрой настройки и переключения wi-fi, которая поможет подключиться к сети с минимальными усилиями. Если wi-fi не был настроен по соответствующей документации на handbook, то программа попытается выполнить настройку.

Кнопки в программе соответствуют всем доступным SSID/MESH на момент запуска программы. Нажатие кнопки выбирает сеть, к которой будет подключение. Чекбокс "more" позволяет показать
больше доступных сетей. 

После выбора нужной сети будет предложено ввести пароль два раза от точки доступа. 
Введенный пароль и логин будут сохранены в /etc/wpa_supplicant.conf и перезапущен сервис.

---

EOF.
