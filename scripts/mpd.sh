#!/bin/sh

add-song()
{
album="$( mpc --host ~/.mpd/socket ls | dmenu -i -p "pick album" )"
queue="$(echo -e "album\nsong" | dmenu -i -p "add this album or pick song")"
if [ $(echo $queue) = album ]
then
    mpc --host ~/.mpd/socket add "$album"
else
    song="$(mpc --host ~/.mpd/socket ls "$album"| dmenu -i -p 'pick song')"
    mpc --host ~/.mpd/socket add "$song"
fi
}
prevnext()
{
command2="$(echo -e "next\nprev" | dmenu -i -p 'pick command')"
mpc --host ~/.mpd/socket "$command2"
}

pause()
{
mpc --host ~/.mpd/socket toggle
}

open-ncmpcpp()
{
st -e ncmpcpp
}
startmpd()
{
musicpd ~/.mpd/musicpd.conf
}
killmpd()
{
killall musicpd
}
quit()
{
exit
}
command-selection()
{
command="$(echo -e "add-song\nprevnext\npause\nstartmpd\nopen-ncmpcpp\nkillmpd\nquit" | dmenu -i -p "mpc control")"
$command
}
while true; do
    command-selection
    whatnow=$(echo -e "$(echo "$command")\ntake-another-action\nquit" | dmenu -i -p "what now")
    if [ $(echo $whatnow) = $command ]
    then
        $command
    elif [ $(echo $whatnow) = take-another-action ]
    then
        command-selection
    elif [ $(echo $whatnow) = quit ]
    then
        exit
    fi
done
