   . /usr/lpp/som/bin/somenv.sh
   export LIBPATH=$POWERADA/lib:$LIBPATH:/usr/lib
   export SMINCLUDE=$POWERADA/lib:$SMINCLUDE

sc -D__PRIVATE__ -sih:h -u testobj.idl
cc -I. -I/usr/lpp/som/include -g -D_ALL_SOURCE -c testobj.c

sc -sada testobj.idl

cat > alib.list << EOF_EOF
adalib
$POWERADA/lib/som
EOF_EOF

alibinit -F

ada testobj.ada
ada -m adamain.ada -o menudemo -i testobj.o


if [ "$DISPLAY" != "" ]
then
   aixterm -e ksh ./run.sh &
else
   echo "X-Windows not available;  open another window "
   echo "   and execute run.sh in this directory"
fi

./run.sh

