
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:53 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Sockets IS


   TYPE Ref IS NEW SOMObject.Ref WITH NULL RECORD;

   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref;

   Major_Version : CONSTANT SOM.integer4 := 2;
   Minor_Version : CONSTANT SOM.integer4 := 1;

   FUNCTION New_Class (
      Major_Version : IN SOM.integer4;
      Minor_Version : IN SOM.integer4)
      RETURN             SOM.SOMClassPtr;

   FUNCTION New_Instance
      RETURN Ref;

   PROCEDURE Free_Instance(
      Instance : IN OUT Ref);
      

   SUBTYPE sockaddr IS SOM.SOMFOREIGN;

   SUBTYPE iovec IS SOM.SOMFOREIGN;

   SUBTYPE msghdr IS SOM.SOMFOREIGN;

   SUBTYPE fd_set IS SOM.SOMFOREIGN;

   SUBTYPE timeval IS SOM.SOMFOREIGN;

   SUBTYPE hostent IS SOM.SOMFOREIGN;

   SUBTYPE servent IS SOM.SOMFOREIGN;

   SUBTYPE in_addr IS SOM.SOMFOREIGN;


   PROCEDURE somsAccept (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);
     
     -- Accept a connection request from a client.

   PROCEDURE somsBind (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : IN OUT Sockets.sockaddr;
      namelen : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Binds a unique local name to the socket with descriptor s.

   PROCEDURE somsConnect (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : IN OUT Sockets.sockaddr;
      namelen : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- For streams sockets, attempts to establish a connection between
     -- two sockets.  For datagram sockets, specifies the socket's peer.

   FUNCTION somsGethostbyaddr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Corba.Char;
      addrlen : IN Corba.Long;
      domain : IN Corba.Long)
      RETURN Sockets.hostent;
     
     -- Returns a hostent structure for the host address specified on
     -- the call.

   FUNCTION somsGethostbyname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String)
      RETURN Sockets.hostent;
     
     -- Returns a hostent structure for the host name specified on
     -- the call.

   FUNCTION somsGethostent (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Sockets.hostent;
     
     -- Returns a pointer to the next entry in the hosts file.

   FUNCTION somsGethostid (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- Returns the unique identifier for the current host.

   FUNCTION somsGethostname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String;
      namelength : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Retrieves the standard host name of the local host.

   PROCEDURE somsGetpeername (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);
     
     -- Gets the name of the peer connected to socket s.

   FUNCTION somsGetservbyname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String;
      protocol : IN Corba.String)
      RETURN Sockets.servent;
     
     -- Retrieves an entry from the /etc/services file using the service
     -- name as a search key.

   PROCEDURE somsGetsockname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);
     
     -- Stores the current name for the socket specified by the s
     -- parameter into the structure pointed to by the name parameter.

   PROCEDURE somsGetsockopt (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      level : IN Corba.Long;
      optname : IN Corba.Long;
      optval : IN Corba.Char;
      option : OUT Corba.Long;
      Result : OUT Corba.Long);
     
     -- Returns the values of socket options at various protocol levels.

   FUNCTION somsHtonl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long;
     
     -- Translates an unsigned long integer from host-byte order to
     -- network-byte order.

   FUNCTION somsHtons (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short;
     
     -- Translates an unsigned short integer from host-byte order to
     -- network-byte order.

   FUNCTION somsIoctl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      cmd : IN Corba.Long;
      data : IN Corba.Char;
      length : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Controls the operating characteristics of sockets.

   FUNCTION somsInet_addr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long;
     
     -- Interprets character strings representing numbers expressed in
     -- standard '.' notation and returns numbers suitable for use as
     -- internet addresses.

   FUNCTION somsInet_lnaof (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long;
     
     -- Breaks apart the internet address and returns the local network
     -- address portion.

   FUNCTION somsInet_makeaddr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      net : IN Corba.Unsigned_Long;
      lna : IN Corba.Unsigned_Long)
      RETURN Sockets.in_addr;
     
     -- Takes a network number and a local network address and constructs
     -- an internet address.

   FUNCTION somsInet_netof (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long;
     
     -- Returns the network number portion of the given internet address.

   FUNCTION somsInet_network (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long;
     
     -- Interprets character strings representing numbers expressed in
     -- standard '.' notation and returns numbers suitable for use as
     -- network numbers.

   FUNCTION somsInet_ntoa (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.String;
     
     -- Returns a pointer to a string expressed in the dotted-decimal
     -- notation.

   FUNCTION somsListen (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      backlog : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Creates a connection request queue of length backlog to queue
     -- incoming connection requests, and then waits for incoming
     -- connection requests.

   FUNCTION somsNtohl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long;
     
     -- Translates an unsigned long integer from network-byte order
     -- to host-byte order.

   FUNCTION somsNtohs (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short;
     
     -- Translates an unsigned short integer from network-byte order
     -- to host-byte order.

   PROCEDURE somsReadv (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      iov : IN OUT Sockets.iovec;
      iovcnt : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Reads data on socket s and stores it in a set of buffers
     -- described by iov.

   FUNCTION somsRecv (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      buf : IN Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Receives data on streams socket s and stores it in buf.

   PROCEDURE somsRecvfrom (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      buf : IN Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);
     
     -- Receives data on datagram socket s and stores it in buf.

   PROCEDURE somsRecvmsg (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN OUT Sockets.msghdr;
      flags : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Receives messages on a socket with descriptor s and stores them
     -- in an array of message headers.

   PROCEDURE somsSelect (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      nfds : IN Corba.Long;
      readfds : IN OUT Sockets.fd_set;
      writefds : IN OUT Sockets.fd_set;
      exceptfds : IN OUT Sockets.fd_set;
      timeout : IN OUT Sockets.timeval;
      Result : OUT Corba.Long);
     
     -- Monitors activity on a set of different sockets until a timeout
     -- expires, to see if any sockets are ready for reading or writing,
     -- or if an exceptional condition is pending.

   FUNCTION somsSend (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Sends msg on streams socket s.

   PROCEDURE somsSendmsg (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN OUT Sockets.msghdr;
      flags : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Sends messages passed in an array of message headers on a socket
     -- with descriptor s.

   PROCEDURE somsSendto (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN OUT Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long;
      to : IN OUT Sockets.sockaddr;
      tolen : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Sends msg on datagram socket s.

   FUNCTION somsSetsockopt (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      level : IN Corba.Long;
      optname : IN Corba.Long;
      optval : IN Corba.Char;
      optlen : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Sets options associated with a socket.

   FUNCTION somsShutdown (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      how : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Shuts down all or part of a full-duplex connection.

   FUNCTION somsSocket (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      domain : IN Corba.Long;
      IDL_type : IN Corba.Long;
      protocol : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Creates an endpoint for communication and returns a socket
     -- descriptor representing the endpoint.

   FUNCTION somsSoclose (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long)
      RETURN Corba.Long;
     
     -- Shuts down socket s and frees resources allocated to the socket.

   PROCEDURE somsWritev (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      iov : IN OUT Sockets.iovec;
      iovcnt : IN Corba.Long;
      Result : OUT Corba.Long);
     
     -- Writes data on socket s.  The data is gathered from the buffers
     -- described by iov.

   FUNCTION get_serrno (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     --Method from the IDL attribute statement:
     --"attribute long serrno"

   PROCEDURE set_serrno (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      serrno : IN Corba.Long);
     
     --Method from the IDL attribute statement:
     --"attribute long serrno"

END Sockets; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Sockets IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somsAccept : SOM.somMToken;
      somsBind : SOM.somMToken;
      somsConnect : SOM.somMToken;
      somsGethostbyaddr : SOM.somMToken;
      somsGethostbyname : SOM.somMToken;
      somsGethostent : SOM.somMToken;
      somsGethostid : SOM.somMToken;
      somsGethostname : SOM.somMToken;
      somsGetpeername : SOM.somMToken;
      somsGetsockname : SOM.somMToken;
      somsGetsockopt : SOM.somMToken;
      somsHtonl : SOM.somMToken;
      somsHtons : SOM.somMToken;
      somsIoctl : SOM.somMToken;
      somsInet_addr : SOM.somMToken;
      somsInet_lnaof : SOM.somMToken;
      somsInet_makeaddr : SOM.somMToken;
      somsInet_netof : SOM.somMToken;
      somsInet_network : SOM.somMToken;
      somsInet_ntoa : SOM.somMToken;
      somsListen : SOM.somMToken;
      somsNtohl : SOM.somMToken;
      somsNtohs : SOM.somMToken;
      somsReadv : SOM.somMToken;
      somsRecv : SOM.somMToken;
      somsRecvfrom : SOM.somMToken;
      somsRecvmsg : SOM.somMToken;
      somsSelect : SOM.somMToken;
      somsSend : SOM.somMToken;
      somsSendmsg : SOM.somMToken;
      somsSendto : SOM.somMToken;
      somsSetsockopt : SOM.somMToken;
      somsShutdown : SOM.somMToken;
      somsSocket : SOM.somMToken;
      somsSoclose : SOM.somMToken;
      somsWritev : SOM.somMToken;
      set_serrno : SOM.somMToken;
      get_serrno : SOM.somMToken;
      somsGetservbyname : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SocketsClassData : classData;
   FOR SocketsClassData USE AT standard.system.label("SocketsClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SocketsCClassData : CClassData;
   FOR SocketsCClassData USE AT standard.system.label("SocketsCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SocketsClassData.classObject) 
      THEN
         RETURN Ref'(som_object => som_object);
      ELSE
         RAISE program_error;
      END IF;
   END To_Ref;



   FUNCTION New_Class (
      Major_Version : IN SOM.integer4;
      Minor_Version : IN SOM.integer4)
      RETURN             SOM.SOMClassPtr
   IS
      FUNCTION SocketsNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SocketsNewClass);
      PRAGMA interface_information (SocketsNewClass, ".SocketsNewClass");
   BEGIN
      RETURN SocketsNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SocketsClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SocketsClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somsAccept (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Accept a connection request from a client.
      FUNCTION Sockets_somsAccept(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsAccept);
      PRAGMA interface_information (Sockets_somsAccept, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsAccept (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(name'address),
            SOM.To_SOM_Address(namelen'address),
            SocketsClassData.somsAccept);
   END somsAccept;

   PROCEDURE somsBind (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : IN OUT Sockets.sockaddr; 
      namelen : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Binds a unique local name to the socket with descriptor s.
      FUNCTION Sockets_somsBind(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsBind);
      PRAGMA interface_information (Sockets_somsBind, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsBind (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(name'address),
            namelen,
            SocketsClassData.somsBind);
   END somsBind;

   PROCEDURE somsConnect (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : IN OUT Sockets.sockaddr; 
      namelen : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- For streams sockets, attempts to establish a connection between
     -- two sockets.  For datagram sockets, specifies the socket's peer.
      FUNCTION Sockets_somsConnect(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsConnect);
      PRAGMA interface_information (Sockets_somsConnect, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsConnect (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(name'address),
            namelen,
            SocketsClassData.somsConnect);
   END somsConnect;

   FUNCTION somsGethostbyaddr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Corba.Char; 
      addrlen : IN Corba.Long; 
      domain : IN Corba.Long)
      RETURN Sockets.hostent
   IS
     
     -- Returns a hostent structure for the host address specified on
     -- the call.
      FUNCTION Sockets_somsGethostbyaddr(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         addr : IN Corba.Char; 
         addrlen : IN Corba.Long; 
         domain : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Sockets.hostent; 
      PRAGMA interface (assembly, Sockets_somsGethostbyaddr);
      PRAGMA interface_information (Sockets_somsGethostbyaddr, ".xsomcall5");
      Result : ALIASED Sockets.hostent;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGethostbyaddr (
            Self.som_object,
            Ev,
            addr,
            addrlen,
            domain,
            SocketsClassData.somsGethostbyaddr);
      RETURN Result;
   END somsGethostbyaddr; 

   FUNCTION somsGethostbyname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String)
      RETURN Sockets.hostent
   IS
     
     -- Returns a hostent structure for the host name specified on
     -- the call.
      FUNCTION Sockets_somsGethostbyname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Sockets.hostent; 
      PRAGMA interface (assembly, Sockets_somsGethostbyname);
      PRAGMA interface_information (Sockets_somsGethostbyname, ".xsomcall3");
      Result : ALIASED Sockets.hostent;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGethostbyname (
            Self.som_object,
            Ev,
            name,
            SocketsClassData.somsGethostbyname);
      RETURN Result;
   END somsGethostbyname; 

   FUNCTION somsGethostent (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Sockets.hostent
   IS
     
     -- Returns a pointer to the next entry in the hosts file.
      FUNCTION Sockets_somsGethostent(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Sockets.hostent; 
      PRAGMA interface (assembly, Sockets_somsGethostent);
      PRAGMA interface_information (Sockets_somsGethostent, ".xsomcall2");
      Result : ALIASED Sockets.hostent;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGethostent (
            Self.som_object,
            Ev,
            SocketsClassData.somsGethostent);
      RETURN Result;
   END somsGethostent; 

   FUNCTION somsGethostid (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns the unique identifier for the current host.
      FUNCTION Sockets_somsGethostid(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsGethostid);
      PRAGMA interface_information (Sockets_somsGethostid, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGethostid (
            Self.som_object,
            Ev,
            SocketsClassData.somsGethostid);
      RETURN Result;
   END somsGethostid; 

   FUNCTION somsGethostname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String; 
      namelength : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Retrieves the standard host name of the local host.
      FUNCTION Sockets_somsGethostname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN Corba.String; 
         namelength : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsGethostname);
      PRAGMA interface_information (Sockets_somsGethostname, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGethostname (
            Self.som_object,
            Ev,
            name,
            namelength,
            SocketsClassData.somsGethostname);
      RETURN Result;
   END somsGethostname; 

   PROCEDURE somsGetpeername (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Gets the name of the peer connected to socket s.
      FUNCTION Sockets_somsGetpeername(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsGetpeername);
      PRAGMA interface_information (Sockets_somsGetpeername, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGetpeername (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(name'address),
            SOM.To_SOM_Address(namelen'address),
            SocketsClassData.somsGetpeername);
   END somsGetpeername;

   FUNCTION somsGetservbyname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String; 
      protocol : IN Corba.String)
      RETURN Sockets.servent
   IS
     
     -- Retrieves an entry from the /etc/services file using the service
     -- name as a search key.
      FUNCTION Sockets_somsGetservbyname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN Corba.String; 
         protocol : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Sockets.servent; 
      PRAGMA interface (assembly, Sockets_somsGetservbyname);
      PRAGMA interface_information (Sockets_somsGetservbyname, ".xsomcall4");
      Result : ALIASED Sockets.servent;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGetservbyname (
            Self.som_object,
            Ev,
            name,
            protocol,
            SocketsClassData.somsGetservbyname);
      RETURN Result;
   END somsGetservbyname; 

   PROCEDURE somsGetsockname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Stores the current name for the socket specified by the s
     -- parameter into the structure pointed to by the name parameter.
      FUNCTION Sockets_somsGetsockname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsGetsockname);
      PRAGMA interface_information (Sockets_somsGetsockname, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGetsockname (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(name'address),
            SOM.To_SOM_Address(namelen'address),
            SocketsClassData.somsGetsockname);
   END somsGetsockname;

   PROCEDURE somsGetsockopt (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      level : IN Corba.Long; 
      optname : IN Corba.Long; 
      optval : IN Corba.Char; 
      option : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Returns the values of socket options at various protocol levels.
      FUNCTION Sockets_somsGetsockopt(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         level : IN Corba.Long; 
         optname : IN Corba.Long; 
         optval : IN Corba.Char; 
         option : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsGetsockopt);
      PRAGMA interface_information (Sockets_somsGetsockopt, ".xsomcall7");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsGetsockopt (
            Self.som_object,
            Ev,
            s,
            level,
            optname,
            optval,
            SOM.To_SOM_Address(option'address),
            SocketsClassData.somsGetsockopt);
   END somsGetsockopt;

   FUNCTION somsHtonl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Translates an unsigned long integer from host-byte order to
     -- network-byte order.
      FUNCTION Sockets_somsHtonl(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         a : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsHtonl);
      PRAGMA interface_information (Sockets_somsHtonl, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsHtonl (
            Self.som_object,
            Ev,
            a,
            SocketsClassData.somsHtonl);
      RETURN Result;
   END somsHtonl; 

   FUNCTION somsHtons (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short
   IS
     
     -- Translates an unsigned short integer from host-byte order to
     -- network-byte order.
      FUNCTION Sockets_somsHtons(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         a : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Short; 
      PRAGMA interface (assembly, Sockets_somsHtons);
      PRAGMA interface_information (Sockets_somsHtons, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsHtons (
            Self.som_object,
            Ev,
            a,
            SocketsClassData.somsHtons);
      RETURN Result;
   END somsHtons; 

   FUNCTION somsIoctl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      cmd : IN Corba.Long; 
      data : IN Corba.Char; 
      length : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Controls the operating characteristics of sockets.
      FUNCTION Sockets_somsIoctl(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         cmd : IN Corba.Long; 
         data : IN Corba.Char; 
         length : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsIoctl);
      PRAGMA interface_information (Sockets_somsIoctl, ".xsomcall6");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsIoctl (
            Self.som_object,
            Ev,
            s,
            cmd,
            data,
            length,
            SocketsClassData.somsIoctl);
      RETURN Result;
   END somsIoctl; 

   FUNCTION somsInet_addr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Interprets character strings representing numbers expressed in
     -- standard '.' notation and returns numbers suitable for use as
     -- internet addresses.
      FUNCTION Sockets_somsInet_addr(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         cp : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsInet_addr);
      PRAGMA interface_information (Sockets_somsInet_addr, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_addr (
            Self.som_object,
            Ev,
            cp,
            SocketsClassData.somsInet_addr);
      RETURN Result;
   END somsInet_addr; 

   FUNCTION somsInet_lnaof (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Breaks apart the internet address and returns the local network
     -- address portion.
      FUNCTION Sockets_somsInet_lnaof(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         addr : IN Sockets.in_addr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsInet_lnaof);
      PRAGMA interface_information (Sockets_somsInet_lnaof, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_lnaof (
            Self.som_object,
            Ev,
            addr,
            SocketsClassData.somsInet_lnaof);
      RETURN Result;
   END somsInet_lnaof; 

   FUNCTION somsInet_makeaddr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      net : IN Corba.Unsigned_Long; 
      lna : IN Corba.Unsigned_Long)
      RETURN Sockets.in_addr
   IS
     
     -- Takes a network number and a local network address and constructs
     -- an internet address.
      FUNCTION Sockets_somsInet_makeaddr(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         net : IN Corba.Unsigned_Long; 
         lna : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Sockets.in_addr; 
      PRAGMA interface (assembly, Sockets_somsInet_makeaddr);
      PRAGMA interface_information (Sockets_somsInet_makeaddr, ".xsomcall4");
      Result : ALIASED Sockets.in_addr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_makeaddr (
            Self.som_object,
            Ev,
            net,
            lna,
            SocketsClassData.somsInet_makeaddr);
      RETURN Result;
   END somsInet_makeaddr; 

   FUNCTION somsInet_netof (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns the network number portion of the given internet address.
      FUNCTION Sockets_somsInet_netof(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         addr : IN Sockets.in_addr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsInet_netof);
      PRAGMA interface_information (Sockets_somsInet_netof, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_netof (
            Self.som_object,
            Ev,
            addr,
            SocketsClassData.somsInet_netof);
      RETURN Result;
   END somsInet_netof; 

   FUNCTION somsInet_network (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Interprets character strings representing numbers expressed in
     -- standard '.' notation and returns numbers suitable for use as
     -- network numbers.
      FUNCTION Sockets_somsInet_network(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         cp : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsInet_network);
      PRAGMA interface_information (Sockets_somsInet_network, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_network (
            Self.som_object,
            Ev,
            cp,
            SocketsClassData.somsInet_network);
      RETURN Result;
   END somsInet_network; 

   FUNCTION somsInet_ntoa (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.String
   IS
     
     -- Returns a pointer to a string expressed in the dotted-decimal
     -- notation.
      FUNCTION Sockets_somsInet_ntoa(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         addr : IN Sockets.in_addr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, Sockets_somsInet_ntoa);
      PRAGMA interface_information (Sockets_somsInet_ntoa, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsInet_ntoa (
            Self.som_object,
            Ev,
            addr,
            SocketsClassData.somsInet_ntoa);
      RETURN Result;
   END somsInet_ntoa; 

   FUNCTION somsListen (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      backlog : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Creates a connection request queue of length backlog to queue
     -- incoming connection requests, and then waits for incoming
     -- connection requests.
      FUNCTION Sockets_somsListen(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         backlog : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsListen);
      PRAGMA interface_information (Sockets_somsListen, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsListen (
            Self.som_object,
            Ev,
            s,
            backlog,
            SocketsClassData.somsListen);
      RETURN Result;
   END somsListen; 

   FUNCTION somsNtohl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Translates an unsigned long integer from network-byte order
     -- to host-byte order.
      FUNCTION Sockets_somsNtohl(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         a : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, Sockets_somsNtohl);
      PRAGMA interface_information (Sockets_somsNtohl, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsNtohl (
            Self.som_object,
            Ev,
            a,
            SocketsClassData.somsNtohl);
      RETURN Result;
   END somsNtohl; 

   FUNCTION somsNtohs (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short
   IS
     
     -- Translates an unsigned short integer from network-byte order
     -- to host-byte order.
      FUNCTION Sockets_somsNtohs(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         a : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Short; 
      PRAGMA interface (assembly, Sockets_somsNtohs);
      PRAGMA interface_information (Sockets_somsNtohs, ".xsomcall3");
      Result : ALIASED Corba.Unsigned_Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsNtohs (
            Self.som_object,
            Ev,
            a,
            SocketsClassData.somsNtohs);
      RETURN Result;
   END somsNtohs; 

   PROCEDURE somsReadv (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      iov : IN OUT Sockets.iovec; 
      iovcnt : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Reads data on socket s and stores it in a set of buffers
     -- described by iov.
      FUNCTION Sockets_somsReadv(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         iov : IN SOM.address; 
         iovcnt : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsReadv);
      PRAGMA interface_information (Sockets_somsReadv, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsReadv (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(iov'address),
            iovcnt,
            SocketsClassData.somsReadv);
   END somsReadv;

   FUNCTION somsRecv (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      buf : IN Corba.Char; 
      len : IN Corba.Long; 
      flags : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Receives data on streams socket s and stores it in buf.
      FUNCTION Sockets_somsRecv(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         buf : IN Corba.Char; 
         len : IN Corba.Long; 
         flags : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsRecv);
      PRAGMA interface_information (Sockets_somsRecv, ".xsomcall6");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsRecv (
            Self.som_object,
            Ev,
            s,
            buf,
            len,
            flags,
            SocketsClassData.somsRecv);
      RETURN Result;
   END somsRecv; 

   PROCEDURE somsRecvfrom (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      buf : IN Corba.Char; 
      len : IN Corba.Long; 
      flags : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Receives data on datagram socket s and stores it in buf.
      FUNCTION Sockets_somsRecvfrom(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         buf : IN Corba.Char; 
         len : IN Corba.Long; 
         flags : IN Corba.Long; 
         name : IN SOM.address; 
         namelen : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsRecvfrom);
      PRAGMA interface_information (Sockets_somsRecvfrom, ".xsomcall8");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsRecvfrom (
            Self.som_object,
            Ev,
            s,
            buf,
            len,
            flags,
            SOM.To_SOM_Address(name'address),
            SOM.To_SOM_Address(namelen'address),
            SocketsClassData.somsRecvfrom);
   END somsRecvfrom;

   PROCEDURE somsRecvmsg (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN OUT Sockets.msghdr; 
      flags : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Receives messages on a socket with descriptor s and stores them
     -- in an array of message headers.
      FUNCTION Sockets_somsRecvmsg(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         msg : IN SOM.address; 
         flags : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsRecvmsg);
      PRAGMA interface_information (Sockets_somsRecvmsg, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsRecvmsg (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(msg'address),
            flags,
            SocketsClassData.somsRecvmsg);
   END somsRecvmsg;

   PROCEDURE somsSelect (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      nfds : IN Corba.Long; 
      readfds : IN OUT Sockets.fd_set; 
      writefds : IN OUT Sockets.fd_set; 
      exceptfds : IN OUT Sockets.fd_set; 
      timeout : IN OUT Sockets.timeval; 
      Result : OUT Corba.Long)
   IS
     
     -- Monitors activity on a set of different sockets until a timeout
     -- expires, to see if any sockets are ready for reading or writing,
     -- or if an exceptional condition is pending.
      FUNCTION Sockets_somsSelect(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         nfds : IN Corba.Long; 
         readfds : IN SOM.address; 
         writefds : IN SOM.address; 
         exceptfds : IN SOM.address; 
         timeout : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSelect);
      PRAGMA interface_information (Sockets_somsSelect, ".xsomcall7");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSelect (
            Self.som_object,
            Ev,
            nfds,
            SOM.To_SOM_Address(readfds'address),
            SOM.To_SOM_Address(writefds'address),
            SOM.To_SOM_Address(exceptfds'address),
            SOM.To_SOM_Address(timeout'address),
            SocketsClassData.somsSelect);
   END somsSelect;

   FUNCTION somsSend (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN Corba.Char; 
      len : IN Corba.Long; 
      flags : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Sends msg on streams socket s.
      FUNCTION Sockets_somsSend(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         msg : IN Corba.Char; 
         len : IN Corba.Long; 
         flags : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSend);
      PRAGMA interface_information (Sockets_somsSend, ".xsomcall6");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSend (
            Self.som_object,
            Ev,
            s,
            msg,
            len,
            flags,
            SocketsClassData.somsSend);
      RETURN Result;
   END somsSend; 

   PROCEDURE somsSendmsg (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN OUT Sockets.msghdr; 
      flags : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Sends messages passed in an array of message headers on a socket
     -- with descriptor s.
      FUNCTION Sockets_somsSendmsg(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         msg : IN SOM.address; 
         flags : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSendmsg);
      PRAGMA interface_information (Sockets_somsSendmsg, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSendmsg (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(msg'address),
            flags,
            SocketsClassData.somsSendmsg);
   END somsSendmsg;

   PROCEDURE somsSendto (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN OUT Corba.Char; 
      len : IN Corba.Long; 
      flags : IN Corba.Long; 
      to : IN OUT Sockets.sockaddr; 
      tolen : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Sends msg on datagram socket s.
      FUNCTION Sockets_somsSendto(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         msg : IN SOM.address; 
         len : IN Corba.Long; 
         flags : IN Corba.Long; 
         to : IN SOM.address; 
         tolen : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSendto);
      PRAGMA interface_information (Sockets_somsSendto, ".xsomcall8");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSendto (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(msg'address),
            len,
            flags,
            SOM.To_SOM_Address(to'address),
            tolen,
            SocketsClassData.somsSendto);
   END somsSendto;

   FUNCTION somsSetsockopt (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      level : IN Corba.Long; 
      optname : IN Corba.Long; 
      optval : IN Corba.Char; 
      optlen : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Sets options associated with a socket.
      FUNCTION Sockets_somsSetsockopt(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         level : IN Corba.Long; 
         optname : IN Corba.Long; 
         optval : IN Corba.Char; 
         optlen : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSetsockopt);
      PRAGMA interface_information (Sockets_somsSetsockopt, ".xsomcall7");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSetsockopt (
            Self.som_object,
            Ev,
            s,
            level,
            optname,
            optval,
            optlen,
            SocketsClassData.somsSetsockopt);
      RETURN Result;
   END somsSetsockopt; 

   FUNCTION somsShutdown (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      how : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Shuts down all or part of a full-duplex connection.
      FUNCTION Sockets_somsShutdown(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         how : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsShutdown);
      PRAGMA interface_information (Sockets_somsShutdown, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsShutdown (
            Self.som_object,
            Ev,
            s,
            how,
            SocketsClassData.somsShutdown);
      RETURN Result;
   END somsShutdown; 

   FUNCTION somsSocket (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      domain : IN Corba.Long; 
      IDL_type : IN Corba.Long; 
      protocol : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Creates an endpoint for communication and returns a socket
     -- descriptor representing the endpoint.
      FUNCTION Sockets_somsSocket(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         domain : IN Corba.Long; 
         IDL_type : IN Corba.Long; 
         protocol : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSocket);
      PRAGMA interface_information (Sockets_somsSocket, ".xsomcall5");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSocket (
            Self.som_object,
            Ev,
            domain,
            IDL_type,
            protocol,
            SocketsClassData.somsSocket);
      RETURN Result;
   END somsSocket; 

   FUNCTION somsSoclose (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long)
      RETURN Corba.Long
   IS
     
     -- Shuts down socket s and frees resources allocated to the socket.
      FUNCTION Sockets_somsSoclose(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsSoclose);
      PRAGMA interface_information (Sockets_somsSoclose, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsSoclose (
            Self.som_object,
            Ev,
            s,
            SocketsClassData.somsSoclose);
      RETURN Result;
   END somsSoclose; 

   PROCEDURE somsWritev (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      iov : IN OUT Sockets.iovec; 
      iovcnt : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
     
     -- Writes data on socket s.  The data is gathered from the buffers
     -- described by iov.
      FUNCTION Sockets_somsWritev(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN Corba.Long; 
         iov : IN SOM.address; 
         iovcnt : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_somsWritev);
      PRAGMA interface_information (Sockets_somsWritev, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_somsWritev (
            Self.som_object,
            Ev,
            s,
            SOM.To_SOM_Address(iov'address),
            iovcnt,
            SocketsClassData.somsWritev);
   END somsWritev;

   FUNCTION get_serrno (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     --Method from the IDL attribute statement:
     --"attribute long serrno"
      FUNCTION Sockets_U_get_serrno(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, Sockets_U_get_serrno);
      PRAGMA interface_information (Sockets_U_get_serrno, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Sockets_U_get_serrno (
            Self.som_object,
            Ev,
            SocketsClassData.get_serrno);
      RETURN Result;
   END get_serrno; 

   PROCEDURE set_serrno (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      serrno : IN Corba.Long)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute long serrno"
      PROCEDURE Sockets_U_set_serrno(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         serrno : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Sockets_U_set_serrno);
      PRAGMA interface_information (Sockets_U_set_serrno, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets_U_set_serrno (
         Self.som_object,
         Ev,
         serrno,
         SocketsClassData.set_serrno);
   END set_serrno;

END Sockets; 







