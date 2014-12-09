
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:17 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Sockets;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE NBSockets IS


   TYPE Ref IS NEW Sockets.Ref WITH NULL RECORD;

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
      


   PROCEDURE somsAccept (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somsBind (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : IN OUT Sockets.sockaddr;
      namelen : IN Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somsConnect (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : IN OUT Sockets.sockaddr;
      namelen : IN Corba.Long;
      Result : OUT Corba.Long);

   FUNCTION somsGethostbyaddr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Corba.Char;
      addrlen : IN Corba.Long;
      domain : IN Corba.Long)
      RETURN Sockets.hostent;

   FUNCTION somsGethostbyname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String)
      RETURN Sockets.hostent;

   FUNCTION somsGethostent (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Sockets.hostent;

   FUNCTION somsGethostid (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsGethostname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String;
      namelength : IN Corba.Long)
      RETURN Corba.Long;

   PROCEDURE somsGetpeername (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somsGetsockname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      name : OUT Sockets.sockaddr;
      namelen : OUT Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somsGetsockopt (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      level : IN Corba.Long;
      optname : IN Corba.Long;
      optval : IN Corba.Char;
      option : OUT Corba.Long;
      Result : OUT Corba.Long);

   FUNCTION somsGetservbyname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String;
      protocol : IN Corba.String)
      RETURN Sockets.servent;

   FUNCTION somsHtonl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsHtons (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short;

   FUNCTION somsIoctl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      cmd : IN Corba.Long;
      data : IN Corba.Char;
      length : IN Corba.Long)
      RETURN Corba.Long;

   FUNCTION somsInet_addr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsInet_lnaof (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsInet_makeaddr (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      net : IN Corba.Unsigned_Long;
      lna : IN Corba.Unsigned_Long)
      RETURN Sockets.in_addr;

   FUNCTION somsInet_netof (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsInet_network (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsInet_ntoa (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      addr : IN Sockets.in_addr)
      RETURN Corba.String;

   FUNCTION somsListen (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      backlog : IN Corba.Long)
      RETURN Corba.Long;

   FUNCTION somsNtohl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long;

   FUNCTION somsNtohs (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short;

   PROCEDURE somsReadv (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      iov : IN OUT Sockets.iovec;
      iovcnt : IN Corba.Long;
      Result : OUT Corba.Long);

   FUNCTION somsRecv (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      buf : IN Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long)
      RETURN Corba.Long;

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

   PROCEDURE somsRecvmsg (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN OUT Sockets.msghdr;
      flags : IN Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somsSelect (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      nfds : IN Corba.Long;
      readfds : IN OUT Sockets.fd_set;
      writefds : IN OUT Sockets.fd_set;
      exceptfds : IN OUT Sockets.fd_set;
      timeout : IN OUT Sockets.timeval;
      Result : OUT Corba.Long);

   FUNCTION somsSend (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN Corba.Char;
      len : IN Corba.Long;
      flags : IN Corba.Long)
      RETURN Corba.Long;

   PROCEDURE somsSendmsg (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      msg : IN OUT Sockets.msghdr;
      flags : IN Corba.Long;
      Result : OUT Corba.Long);

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

   FUNCTION somsSetsockopt (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      level : IN Corba.Long;
      optname : IN Corba.Long;
      optval : IN Corba.Char;
      optlen : IN Corba.Long)
      RETURN Corba.Long;

   FUNCTION somsShutdown (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      how : IN Corba.Long)
      RETURN Corba.Long;

   FUNCTION somsSocket (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      domain : IN Corba.Long;
      IDL_type : IN Corba.Long;
      protocol : IN Corba.Long)
      RETURN Corba.Long;

   FUNCTION somsSoclose (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long)
      RETURN Corba.Long;

   PROCEDURE somsWritev (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN Corba.Long;
      iov : IN OUT Sockets.iovec;
      iovcnt : IN Corba.Long;
      Result : OUT Corba.Long);

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE set_serrno (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      serrno : IN Corba.Long);

   FUNCTION get_serrno (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

END NBSockets; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY NBSockets IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   NBSocketsClassData : classData;
   FOR NBSocketsClassData USE AT standard.system.label("NBSocketsClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   NBSocketsCClassData : CClassData;
   FOR NBSocketsCClassData USE AT standard.system.label("NBSocketsCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            NBSocketsClassData.classObject) 
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
      FUNCTION NBSocketsNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, NBSocketsNewClass);
      PRAGMA interface_information (NBSocketsNewClass, ".NBSocketsNewClass");
   BEGIN
      RETURN NBSocketsNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF NBSocketsClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(NBSocketsClassData.classObject));
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsAccept (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         name,
         namelen,
         Result);
   END somsAccept;

   PROCEDURE somsBind (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : IN OUT Sockets.sockaddr; 
      namelen : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsBind (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         name,
         namelen,
         Result);
   END somsBind;

   PROCEDURE somsConnect (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : IN OUT Sockets.sockaddr; 
      namelen : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsConnect (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         name,
         namelen,
         Result);
   END somsConnect;

   FUNCTION somsGethostbyaddr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Corba.Char; 
      addrlen : IN Corba.Long; 
      domain : IN Corba.Long)
      RETURN Sockets.hostent
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGethostbyaddr (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            addr,
            addrlen,
            domain);
   END somsGethostbyaddr;

   FUNCTION somsGethostbyname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String)
      RETURN Sockets.hostent
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGethostbyname (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            name);
   END somsGethostbyname;

   FUNCTION somsGethostent (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Sockets.hostent
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGethostent (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev);
   END somsGethostent;

   FUNCTION somsGethostid (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGethostid (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev);
   END somsGethostid;

   FUNCTION somsGethostname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String; 
      namelength : IN Corba.Long)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGethostname (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            name,
            namelength);
   END somsGethostname;

   PROCEDURE somsGetpeername (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsGetpeername (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         name,
         namelen,
         Result);
   END somsGetpeername;

   PROCEDURE somsGetsockname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      name : OUT Sockets.sockaddr; 
      namelen : OUT Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsGetsockname (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         name,
         namelen,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsGetsockopt (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         level,
         optname,
         optval,
         option,
         Result);
   END somsGetsockopt;

   FUNCTION somsGetservbyname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String; 
      protocol : IN Corba.String)
      RETURN Sockets.servent
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsGetservbyname (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            name,
            protocol);
   END somsGetservbyname;

   FUNCTION somsHtonl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsHtonl (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            a);
   END somsHtonl;

   FUNCTION somsHtons (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsHtons (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            a);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsIoctl (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            cmd,
            data,
            length);
   END somsIoctl;

   FUNCTION somsInet_addr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_addr (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            cp);
   END somsInet_addr;

   FUNCTION somsInet_lnaof (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_lnaof (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            addr);
   END somsInet_lnaof;

   FUNCTION somsInet_makeaddr (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      net : IN Corba.Unsigned_Long; 
      lna : IN Corba.Unsigned_Long)
      RETURN Sockets.in_addr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_makeaddr (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            net,
            lna);
   END somsInet_makeaddr;

   FUNCTION somsInet_netof (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_netof (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            addr);
   END somsInet_netof;

   FUNCTION somsInet_network (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      cp : IN Corba.String)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_network (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            cp);
   END somsInet_network;

   FUNCTION somsInet_ntoa (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      addr : IN Sockets.in_addr)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsInet_ntoa (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            addr);
   END somsInet_ntoa;

   FUNCTION somsListen (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      backlog : IN Corba.Long)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsListen (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            backlog);
   END somsListen;

   FUNCTION somsNtohl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Long)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsNtohl (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            a);
   END somsNtohl;

   FUNCTION somsNtohs (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      a : IN Corba.Unsigned_Short)
      RETURN Corba.Unsigned_Short
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsNtohs (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            a);
   END somsNtohs;

   PROCEDURE somsReadv (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      iov : IN OUT Sockets.iovec; 
      iovcnt : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsReadv (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         iov,
         iovcnt,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsRecv (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            buf,
            len,
            flags);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsRecvfrom (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         buf,
         len,
         flags,
         name,
         namelen,
         Result);
   END somsRecvfrom;

   PROCEDURE somsRecvmsg (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN OUT Sockets.msghdr; 
      flags : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsRecvmsg (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         msg,
         flags,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsSelect (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         nfds,
         readfds,
         writefds,
         exceptfds,
         timeout,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsSend (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            msg,
            len,
            flags);
   END somsSend;

   PROCEDURE somsSendmsg (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      msg : IN OUT Sockets.msghdr; 
      flags : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsSendmsg (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         msg,
         flags,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsSendto (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         msg,
         len,
         flags,
         to,
         tolen,
         Result);
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
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsSetsockopt (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            level,
            optname,
            optval,
            optlen);
   END somsSetsockopt;

   FUNCTION somsShutdown (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      how : IN Corba.Long)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsShutdown (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s,
            how);
   END somsShutdown;

   FUNCTION somsSocket (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      domain : IN Corba.Long; 
      IDL_type : IN Corba.Long; 
      protocol : IN Corba.Long)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsSocket (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            domain,
            IDL_type,
            protocol);
   END somsSocket;

   FUNCTION somsSoclose (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.somsSoclose (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev,
            s);
   END somsSoclose;

   PROCEDURE somsWritev (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN Corba.Long; 
      iov : IN OUT Sockets.iovec; 
      iovcnt : IN Corba.Long; 
      Result : OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.somsWritev (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         s,
         iov,
         iovcnt,
         Result);
   END somsWritev;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

   PROCEDURE set_serrno (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      serrno : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Sockets.set_serrno (
         Sockets.Ref'(som_object=>Self.som_object),
         Ev,
         serrno);
   END set_serrno;

   FUNCTION get_serrno (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Sockets.get_serrno (
            Sockets.Ref'(som_object=>Self.som_object),
            Ev);
   END get_serrno;

END NBSockets; 







