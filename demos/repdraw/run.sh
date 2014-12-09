rm -f Tablet.scf

if [ "$ADAXLIBXTHOME" = "" -o ! -s $ADAXLIBXTHOME/xt/adalib/.adalib ]
then
   echo "repdraw:  ADAXLIBXTHOME must point to the AdaXlibXt libraries"
   echo "          See $POWERADA/../contrib/AdaXlibXt for info"
   exit 255
fi

. /usr/lpp/som/bin/somenv.sh
. /usr/lpp/som/samples/somr/somrenv.sh
   export LIBPATH=$POWERADA/lib:$LIBPATH:/usr/lib
   export SMINCLUDE=$POWERADA/lib:$SMINCLUDE
   export SOMIR="/usr/lpp/som/etc/som.ir:./som.ir"

make clean

make

rm -f Tablet.scf

repdraw &


repdraw &

