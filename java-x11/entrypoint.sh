#!/bin/bash

if [ ! $LOCAL_USER_ID ]; then
    echo "Please set LOCAL_USER_ID environment variable"
    exit
fi

useradd --shell /bin/bash -u $LOCAL_USER_ID -o -c "" -m user
export HOME=/home/user

ln -s /usr/local/maven-cache/.m2 /home/user/.m2

mkdir -p /home/user/.vnc
cat > /home/user/.vnc/xstartup <<EOF
 #!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &
xhost +localhost
EOF
chmod +x /home/user/.vnc/xstartup
chown -R user.user /home/user/.vnc

/usr/local/bin/gosu user /usr/bin/expect <<EOF
spawn "vnc4server"
expect "Password:"
send "password\r"
expect "Verify:"
send "password\r"
expect eof
exit
EOF

exec /usr/local/bin/gosu user "$@"
