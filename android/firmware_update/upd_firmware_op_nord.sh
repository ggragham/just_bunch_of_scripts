#!/usr/bin/env bash

fastboot flash --slot=all modem modem.img
fastboot reboot fastboot
fastboot flash --slot=all abl abl.img
fastboot flash --slot=all aop aop.img
fastboot flash --slot=all bluetooth bluetooth.img
fastboot flash --slot=all devcfg devcfg.img
fastboot flash --slot=all dsp dsp.img
fastboot flash --slot=all featenabler featenabler.img
fastboot flash --slot=all hyp hyp.img
fastboot flash --slot=all imagefv imagefv.img
fastboot flash --slot=all keymaster keymaster.img
fastboot flash --slot=all logo logo.img
fastboot flash --slot=all oem_stanvbk oem_stanvbk.img
fastboot flash --slot=all odm odm.img
fastboot flash --slot=all qupfw qupfw.img
fastboot flash --slot=all storsec storsec.img
fastboot flash --slot=all tz tz.img
fastboot flash --slot=all uefisecapp uefisecapp.img
fastboot flash --slot=all xbl xbl.img
fastboot flash --slot=all xbl_config xbl_config.img

