git submodule update --init --recursive

source layers/poky/oe-init-build-env

if grep -q "MACHINE=\"raspberrypi0\"" ./conf/local.conf; then
    echo -n ""
else
    echo "MACHINE=\"raspberrypi0\"" >> ./conf/local.conf
fi

if grep -q "GPU_MEM=\"16\"" ./conf/local.conf; then
    echo -n ""
else
    echo "GPU_MEM=\"16\"" >> ./conf/local.conf
fi

bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?
if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../layers/meta-raspberrypi
else
	echo "meta-raspberrypi layer already exists"
fi

bitbake-layers show-layers | grep "meta-oe" > /dev/null
layer_info=$?
if [ $layer_info -ne 0 ];then
	echo "Adding meta-oe layer"
	bitbake-layers add-layer ../layers/meta-openembedded/meta-oe
else
	echo "meta-oe layer already exists"
fi

bitbake-layers show-layers | grep "meta-cizies-looper" > /dev/null
layer_info=$?
if [ $layer_info -ne 0 ];then
	echo "Adding meta-cizies-looper layer"
	bitbake-layers add-layer ../layers/meta-cizies-looper
else
	echo "meta-cizies-looper layer already exists"
fi

set -e
bitbake core-image-cizies-looper

