#   Makefile for: replication framework sample program "repdraw"

#==============================================================================#
# NOTES:                                                                       #
# The interface repository (defined by the SOMIR environment variable) will    #
# be updated with Tablet class interface information.                          #
#                                                                              #
#    Ensure that SOMIR is set correctly before making this program!!!!         #
#                                                                              #
# The SOMBASE environment variable must be set to the directory containing     #
# your SOM installation .  Also, SOMBASE/bin must be in your PATH.             #
#                                                                              #
#   Ensure that SOMBASE is set correctly in your environment before making     #
#   this program!!!                                                            #
#                                                                              #
# The Ada library must be preinitialized.  It must include the following:      #
#        - a working sublibrary                                                #
#        - a SOM runtime library                                               #
#        - the SERC bindings libraries                                         #
# The versions of the sublibraries must be compatible.                         #
#                                                                              #
#==============================================================================#

OBJS       = tablet.o
TARGET     = repdraw
CLEANFILES = tablet.h tablet.ih tablet.ada Tablet.scf som.ir *~ ada_compiled 

SCFLAGS     = -D__PRIVATE__ -sh:ih -u
CC          = cc
SC          = sc
CFLAGS      = -g -D_ALL_SOURCE
LINKER      = cc
LDFLAGS     = -g
LIBDIRPATH  = -L$(SOMBASE)/lib
INCLUDEPATH = -I. -I$(SOMBASE)/include -I/usr/include/Motif1.2 -I/usr/lpp/X11/include
LIBLIST     = -lXm -lX11 -lXt -lIM 	      -lsomtk

all: $(TARGET)

.SUFFIXES: .c .ih .idl .o .ada

.c.o:
	$(CC) $(INCLUDEPATH) $(CFLAGS) -c $<

.idl.ih:
	$(SC) $(SCFLAGS) $<

.idl.ada:
	alibinit -F
	$(SC) -sada $<

ada_compiled: tablet.ada repdraw.ada
	ada -v tablet.ada
	ada -v repdraw.ada
	touch ada_compiled

$(TARGET): $(OBJS) ada_compiled
	ada -o repdraw -vb repdraw -i tablet.o -i /usr/lib/libXm.a

clean:
	rm -rf *.o core *.ih $(TARGET) $(CLEANFILES) adalib

tablet.ih: tablet.idl

tablet.o: tablet.c tablet.ih

tablet.h: tablet.ih
