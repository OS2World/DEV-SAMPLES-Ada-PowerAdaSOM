
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:55 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE StExcep IS


   UNKNOWN : EXCEPTION;

   TYPE UNKNOWN_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( UNKNOWN_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      UNKNOWN_members;
     
     -- the unknown exception

   BAD_PARAM : EXCEPTION;

   TYPE BAD_PARAM_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( BAD_PARAM_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      BAD_PARAM_members;
     
     -- an invalid parameter was passed

   NO_MEMORY : EXCEPTION;

   TYPE NO_MEMORY_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( NO_MEMORY_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      NO_MEMORY_members;
     
     -- dynamic memory allocation failure

   IMP_LIMIT : EXCEPTION;

   TYPE IMP_LIMIT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( IMP_LIMIT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      IMP_LIMIT_members;
     
     -- violated implementation limit

   COMM_FAILURE : EXCEPTION;

   TYPE COMM_FAILURE_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( COMM_FAILURE_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      COMM_FAILURE_members;
     
     -- communication failure

   INV_OBJREF : EXCEPTION;

   TYPE INV_OBJREF_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INV_OBJREF_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INV_OBJREF_members;
     
     -- invalid object reference

   NO_PERMISSION : EXCEPTION;

   TYPE NO_PERMISSION_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( NO_PERMISSION_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      NO_PERMISSION_members;
     
     -- no permission for attempted op.

   INTERNAL : EXCEPTION;

   TYPE INTERNAL_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INTERNAL_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INTERNAL_members;
     
     -- ORB internal error

   MARSHAL : EXCEPTION;

   TYPE MARSHAL_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( MARSHAL_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      MARSHAL_members;
     
     -- error marshalling param/result

   INITIALIZE : EXCEPTION;

   TYPE INITIALIZE_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INITIALIZE_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INITIALIZE_members;
     
     -- ORB initialization failure

   NO_IMPLEMENT : EXCEPTION;

   TYPE NO_IMPLEMENT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( NO_IMPLEMENT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      NO_IMPLEMENT_members;
     
     -- operation implementation unavail.

   BAD_TYPECODE : EXCEPTION;

   TYPE BAD_TYPECODE_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( BAD_TYPECODE_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      BAD_TYPECODE_members;
     
     -- bad typecode

   BAD_OPERATION : EXCEPTION;

   TYPE BAD_OPERATION_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( BAD_OPERATION_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      BAD_OPERATION_members;
     
     -- invalid operation

   NO_RESOURCES : EXCEPTION;

   TYPE NO_RESOURCES_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( NO_RESOURCES_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      NO_RESOURCES_members;
     
     -- insufficient resources for req.

   NO_RESPONSE : EXCEPTION;

   TYPE NO_RESPONSE_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( NO_RESPONSE_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      NO_RESPONSE_members;
     
     -- response to req. not yet avail.

   PERSIST_STORE : EXCEPTION;

   TYPE PERSIST_STORE_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( PERSIST_STORE_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      PERSIST_STORE_members;
     
     -- persistent storage failure

   BAD_INV_ORDER : EXCEPTION;

   TYPE BAD_INV_ORDER_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( BAD_INV_ORDER_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      BAD_INV_ORDER_members;
     
     -- routine invocations out of order

   TRANSIENT : EXCEPTION;

   TYPE TRANSIENT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( TRANSIENT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      TRANSIENT_members;
     
     -- transient failure - reissue req.

   FREE_MEM : EXCEPTION;

   TYPE FREE_MEM_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( FREE_MEM_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      FREE_MEM_members;
     
     -- cannot free memory

   INV_IDENT : EXCEPTION;

   TYPE INV_IDENT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INV_IDENT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INV_IDENT_members;
     
     -- invalid identifier syntax

   INV_FLAG : EXCEPTION;

   TYPE INV_FLAG_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INV_FLAG_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INV_FLAG_members;
     
     -- invalid flag was specified

   INTF_REPOS : EXCEPTION;

   TYPE INTF_REPOS_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( INTF_REPOS_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      INTF_REPOS_members;
     
     -- error accessing interface repos.

   CONTEXT : EXCEPTION;

   TYPE CONTEXT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( CONTEXT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      CONTEXT_members;
     
     -- error processing context object

   OBJ_ADAPTER : EXCEPTION;

   TYPE OBJ_ADAPTER_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( OBJ_ADAPTER_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      OBJ_ADAPTER_members;
     
     -- failure detected by obj. adapter

   DATA_CONVERSION : EXCEPTION;

   TYPE DATA_CONVERSION_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( DATA_CONVERSION_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      DATA_CONVERSION_members;
     
     -- data conversion error
     -- DSOM standard exceptions

   OPSYS : EXCEPTION;

   TYPE OPSYS_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( OPSYS_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      OPSYS_members;
     
     -- operating system error

   WMQUIT : EXCEPTION;

   TYPE WMQUIT_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( WMQUIT_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      WMQUIT_members;
     
     -- WMQUIT message

   DISPATCH : EXCEPTION;

   TYPE DISPATCH_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      minor : Corba.Unsigned_Long;
      completed : SOM.completion_status;
   END RECORD;
   PRAGMA Preserve_Layout( DISPATCH_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      DISPATCH_members;
     
     -- no longer raised by DSOM

END StExcep; 



