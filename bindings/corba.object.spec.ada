------------------------------------------------------------------------------
-- corba.object.spec : CORBA Object definition -- PACAKGE SPEC
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec18 swn Change BaseObject to Object.   (d2189)
-- 94Dec08 swn Created from mapping document.
------------------------------------------------------------------------------
--
-- CORBA.Object provides the basic definition of object reference type
-- as defined by the mapping specification.
--
------------------------------------------------------------------------------

WITH SOM;

PACKAGE Corba.Object IS

   PRAGMA comment("@(#) ada/runtime/som/corba.object.spec, ada, power95.3 1.1 12/21/95 12:25:33");

   --------------------------------------------------------------------------
   -- This is the object reference.  This is basically a SOM object 
   -- reference wrapped in an Ada tagged type.  The tagged type wrapper
   -- facilitates the use of Ada inheritance and method dispatching.
   -- This record is never extended by subclasses.
   --------------------------------------------------------------------------

--   TYPE ref IS TAGGED PRIVATE;
   TYPE ref IS TAGGED
   RECORD
      som_object : SOM.SOMObjectPtr;
   END RECORD;
   
--    FUNCTION to_any (from : IN ref) RETURN any;
--    FUNCTION to_ref (from : IN any) RETURN ref;
   
   TYPE object IS TAGGED PRIVATE;
   
--    FUNCTION get_implementation (
--       self   : IN ref)
--       RETURN      Corba.ImplementationDef.Ref'Class;
   
--    FUNCTION get_interface (
--       self   : IN ref)
--       RETURN      Corba.InterfaceDef.Ref'Class;
   
    FUNCTION is_nil (self : IN ref) RETURN boolean;
--   FUNCTION is_null (self : IN ref) RETURN boolean RENAMES is_nil;
   
   -- No duplicate: use assignment.
   
--    PROCEDURE release (self : IN OUT ref'class);
   
--    PROCEDURE create_request (
--       self      : IN ref;
--       ctx       : IN corba.contxe.object;
--       operation : IN indentifier;
--       arg_list  : IN corba.nvlist.object;
--       result    : IN OUT namedvalue;
--       request   :    OUT corba.request.object;
--       req_flags : IN     flags;
--       returns   :    OUT status);

PRIVATE
   
--    TYPE ref IS TAGGED
--    RECORD
--       som_object : SOM.SOMObjectPtr;
--    END RECORD;
      
   TYPE object IS TAGGED
   RECORD
      som_object : SOM.SOMObjectPtr;
   END RECORD;
      
END Corba.Object;
