rm -f TESTOBJ.scf

. /usr/lpp/som/bin/somenv.sh
. /usr/lpp/som/samples/somr/somrenv.sh
   export LIBPATH=$POWERADA/lib:$LIBPATH:/usr/lib
   export SMINCLUDE=$POWERADA/lib:$SMINCLUDE
   export SOMIR="/usr/lpp/som/etc/som.ir:./som.ir"
menudemo

