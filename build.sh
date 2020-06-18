git submodule update --init

MACHINE=raspberrypi0 GPU_MEM=16 source layers/poky/oe-init-build-env

bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?
if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../layers/meta-raspberrypi
else
	echo "meta-raspberrypi layer already exists"
fi

if [ $layer_info -ne 0 ];then
	echo "Adding meta-cizies-looper layer"
	bitbake-layers add-layer ../layers/meta-cizies-looper
else
	echo "meta-cizies-looper layer already exists"
fi

set -e
bitbake core-image-cizies-looper

