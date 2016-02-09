#!/bin/sh

. /lib/ralink.sh

status_led=""

led_set_attr() {
	[ -f "/sys/class/leds/$1/$2" ] && echo "$3" > "/sys/class/leds/$1/$2"
}

status_led_set_timer() {
	led_set_attr $status_led "trigger" "timer"
	led_set_attr $status_led "delay_on" "$1"
	led_set_attr $status_led "delay_off" "$2"
}

status_led_on() {
	led_set_attr $status_led "trigger" "none"
	led_set_attr $status_led "brightness" 255
}

status_led_off() {
	led_set_attr $status_led "trigger" "none"
	led_set_attr $status_led "brightness" 0
}

get_status_led() {
	case $(ralink_board_name) in
	fonera20n)
		status_led="fonera20n:green:power"
		;;
	rt-n13)
		status_led="rt-n13:power"
		;;
	hg255d)
		status_led="hg255d:power"
		;;
	hg256)
		status_led="hg256:power"
		;;
	wrtnode)
		status_led="wrtnode:sys"
		;;
	q7)
		status_led="zte_q7:sys"
		;;
	mt7620a-evb | ap7620a | mt7621a-evb)
		status_led="power"
		;;
	dir620)
		status_led="d-link:green:wps"
		;;
	wr8305rt)
		status_led="wr8305rt:sys"
		;;
	ry1)
		status_led="ry1:sys"
		;;
	y1s)
		status_led="power:blue"
		;;
    vg100)
		status_led="power"
		;;
	y1)
		status_led="power:blue"
		;;
	y2s)
		status_led="sys:blue"
		;;
	pbr-m1)
		status_led="power:blue"
		;;
	abox)
		status_led="usb2:green"
		;;
	ap7621)
		status_led="power:blue"
		;;
	yk1)
		status_led="power:blue"
		;;
	mtall | superdisk_mini | creativebox)
		status_led="power"
		;;
	xiaomi-mini)
		status_led="culiang:blue"
		;;
	xiaomi-r1cl)
		status_led="status:red"
		;;
	wap120nf)
		status_led="wap120nf:power"
		;;
	ji2)
		status_led="ji2:power"
		;;
	oye-0001)
		status_led="oye:green:power"
		;;
	rt-n15)
		status_led="rt-n15:blue:power"
		;;
	rt-n10-plus)
		status_led="asus:green:wps"
		;;
	rt-n56u | wl-330n | wl-330n3g)
		status_led="asus:blue:power"
		;;
	m1-jd)
		status_led="jd-led-blue"
		;;
	pbr-w3)
		status_led="power"
		;;
	esac
}

set_state() {
	get_status_led

	case "$1" in
	preinit)
		status_led_set_timer 200 200
		;;
	failsafe)
		status_led_set_timer 50 50
		;;
	done)
		status_led_on
		;;
	esac
}
