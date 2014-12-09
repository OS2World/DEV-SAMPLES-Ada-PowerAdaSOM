------------------------------------------------------------------------------
-- corba.object.body : CORBA Object definition -- PACAKGE BODY
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec18 swn Created from mapping document. (d2189)
------------------------------------------------------------------------------
--
-- CORBA.Object provides the basic definition of object reference type
-- as defined by the mapping specification.
--
------------------------------------------------------------------------------

PACKAGE BODY Corba.Object IS
   
   PRAGMA comment("@(#) ada/runtime/som/corba.object.body, ada, power95.3 1.1 12/21/95 12:27:07");
   
   ---------------------------------------------------------------------------
   
--    FUNCTION to_any (from : IN ref) RETURN any
--    IS
--       result : any;
--    BEGIN
--       RAISE program_error;
--       RETURN result;
--    END to_any;
   
   
--    FUNCTION to_ref (from : IN any) RETURN ref
--    IS
--       result : ref;
--    BEGIN
--       RAISE program_error;
--       RETURN result;
--    END to_ref;
   
   
--    FUNCTION get_implementation (
--       self   : IN ref)
--       RETURN      Corba.ImplementationDef.Ref'Class;
   
--    FUNCTION get_interface (
--       self   : IN ref)
--       RETURN      Corba.InterfaceDef.Ref'Class;
   
   
   FUNCTION is_nil (self : IN ref) RETURN boolean
   IS
   BEGIN
      RETURN NOT SOM.somIsObj(Self.som_object);
   END is_nil;
   
   
--   FUNCTION is_null (self : IN ref) RETURN boolean RENAMES is_nil;
   
   
--    PROCEDURE release (self : IN OUT ref'class)
--    IS
--    BEGIN
--       NULL;
--    END release;
   
   
--    PROCEDURE create_request (
--       self      : IN ref;
--       ctx       : IN corba.contxe.object;
--       operation : IN indentifier;
--       arg_list  : IN corba.nvlist.object;
--       result    : IN OUT namedvalue;
--       request   :    OUT corba.request.object;
--       req_flags : IN     flags;
--       returns   :    OUT status);

END Corba.Object;
