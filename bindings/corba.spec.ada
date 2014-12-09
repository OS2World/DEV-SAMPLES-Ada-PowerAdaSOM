------------------------------------------------------------------------------
-- corba.spec : CORBA definitions -- PACAKGE SPEC
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec20 Upgrade to use implemented Ada95 features. (d2189)
-- 94Dec09 swn Comment out references to Annex A packages.
-- 94Dec08 swn Move Ref type to BaseObject child package.
-- 94Oct10 swn Created from mapping document.
------------------------------------------------------------------------------
--
-- CORBA provides the basic definitions required by the IDL-to-Ada95
-- mapping specification.
--
------------------------------------------------------------------------------

WITH ada.exceptions;
--WITH ada.strings.unbounded;
WITH interfaces;
WITH system;
WITH SOM;

PACKAGE Corba IS
   
   PRAGMA comment("@(#) ada/runtime/som/corba.spec, ada, power95.3 1.5 12/21/95 12:20:48");
   
   --------------------------------------------------------------------------
   -- Basic Data Types
   --------------------------------------------------------------------------

   -- CORBA 5.7, p.89
   -- Mapping 4.6.2, p.34

   TYPE    short          IS NEW interfaces.integer_16;
   
   TYPE    long           IS NEW interfaces.integer_32;
   
   TYPE    unsigned_short IS NEW interfaces.unsigned_16;
   
   TYPE    unsigned_long  IS NEW interfaces.unsigned_32;
   
   TYPE    float          IS NEW standard.float;
   
   TYPE    double         IS NEW standard.long_float;
   
   SUBTYPE char           IS     standard.character;
   
   TYPE    octet          IS NEW interfaces.unsigned_8;
   
   SUBTYPE string         IS     system.address;  
--   TYPE string            IS     ada.strings.unbounded.unbounded_string;
   
   -- Mapping 4.6.3 p.34
   
   SUBTYPE boolean        IS     standard.boolean;
   
   --------------------------------------------------------------------------
   -- Standard Excpetions.
   --------------------------------------------------------------------------

   -- CORBA 4.13, p.80

   TYPE IDL_exception_members IS ABSTRACT TAGGED NULL RECORD;
   
   FUNCTION get_members (
      x      : IN ada.exceptions.exception_occurrence)
      RETURN      IDL_exception_members
   IS ABSTRACT;

   SUBTYPE completion_status IS SOM.completion_status;
   SUBTYPE exception_type    IS SOM.exception_type;

   TYPE ex_body IS NEW Corba.IDL_exception_members WITH
   RECORD
      minor      : Corba.unsigned_long;
      completed  : completion_status;
   END RECORD;
   
--    FOR ex_body USE
--    RECORD
--       minor      AT 0 RANGE 0..31;
--       completed  AT 4 RANGE 0..31;
--    END RECORD;

   
   FUNCTION get_members (
      x      : IN ada.exceptions.exception_occurrence)
      RETURN      ex_body;
      
   unknown         : EXCEPTION; 
   bad_param       : EXCEPTION;
   no_memory       : EXCEPTION;
   imp_limit       : EXCEPTION;
   comm_failure    : EXCEPTION;
   inv_objref      : EXCEPTION;
   no_permission   : EXCEPTION;
   internal        : EXCEPTION;
   marshall        : EXCEPTION;
   initialize      : EXCEPTION;
   no_implement    : EXCEPTION;
   bad_typecode    : EXCEPTION;
   bad_operation   : EXCEPTION;
   no_resources    : EXCEPTION;
   no_response     : EXCEPTION;
   persist_store   : EXCEPTION;
   bad_inv_order   : EXCEPTION;
   transient       : EXCEPTION;
   free_mem        : EXCEPTION;
   inv_ident       : EXCEPTION;
   inv_flag        : EXCEPTION;
   intf_repos      : EXCEPTION;
   context         : EXCEPTION;
   obj_adapter     : EXCEPTION;
   data_conversion : EXCEPTION;
   
   
   -- CORBA 5.7   
   
   TYPE TCKind IS
         (tk_null,
          tk_void,
          tk_short,
          tk_long,
          tk_ushort,
          tk_ulong,
          tk_float,
          tk_double,
          tk_boolean,
          tk_char,
          tk_octet,
          tk_any,
          tk_TypeCode,
          tk_Principal,
          tk_objref,
          tk_struct,
          tk_union,
          tk_enum,
          tk_string,
          tk_sequence,
          tk_array);

  FOR TCKind USE
        ( tk_null      => 1,
          tk_void      => 2,
          tk_short     => 3,
          tk_long      => 4,
          tk_ushort    => 5,
          tk_ulong     => 6,
          tk_float     => 7,
          tk_double    => 8,
          tk_boolean   => 9,
          tk_char      => 10,
          tk_octet     => 11,
          tk_any       => 12,
          tk_TypeCode  => 13,
          tk_Principal => 14,
          tk_objref    => 15,
          tk_struct    => 16,
          tk_union     => 17,
          tk_enum      => 18,
          tk_string    => 19,
          tk_sequence  => 20,
          tk_array     => 21);

   -- CORBA 4.7.1.6
   
   TYPE any IS PRIVATE;
   
      
   PACKAGE TypeCode IS
      
      TYPE object IS PRIVATE;
      
      bounds : EXCEPTION;
      
      TYPE bounds_members IS NEW Corba.IDL_exception_members WITH NULL RECORD;
      
      FUNCTION get_members (
         x      : IN ada.exceptions.exception_occurrence)
         RETURN      bounds_members;
      
      FUNCTION equal (
         self   : IN object;
         tc     : IN object)
         RETURN      Corba.boolean;

--       FUNCTION "=" (
--          left   : IN object;
--          right  : IN object)
--          RETURN      Corba.boolean RENAMES equal;
      
      FUNCTION kind (
         self   : IN object)
         RETURN      TCKind;
      
      FUNCTION param_count (
         self   : IN object)
         RETURN      Corba.long;
      
      FUNCTION parameter (
         self   : IN object;
         index  : IN Corba.long)
         RETURN      any;
      
   PRIVATE

      TYPE object IS NEW SOM.TypeCode;
      
   END TypeCode;


   FUNCTION type_of (
      the_any : IN any)
      RETURN       TypeCode.Object;
   
   FUNCTION to_any (from : IN octet)          RETURN any;
   FUNCTION to_any (from : IN short)          RETURN any;
   FUNCTION to_any (from : IN long)           RETURN any;
   FUNCTION to_any (from : IN unsigned_short) RETURN any;
   FUNCTION to_any (from : IN unsigned_long)  RETURN any;
   FUNCTION to_any (from : IN boolean)        RETURN any;
   FUNCTION to_any (from : IN char)           RETURN any;
   FUNCTION to_any (from : IN string)         RETURN any;
   
   FUNCTION to_octet          (from : IN any) RETURN octet;
   FUNCTION to_short          (from : IN any) RETURN short;
   FUNCTION to_long           (from : IN any) RETURN long;
   FUNCTION to_unsigned_short (from : IN any) RETURN unsigned_short;
   FUNCTION to_unsigned_long  (from : IN any) RETURN unsigned_long;
   FUNCTION to_boolean        (from : IN any) RETURN boolean;
   FUNCTION to_char           (from : IN any) RETURN char;
   FUNCTION to_string         (from : IN any) RETURN string;
   
   
   -- CORBA 7.5.1
   
   TYPE identifier IS NEW Corba.string;
   
   -- CORBA 6.1.1
   
   TYPE flags IS NEW Corba.unsigned_long;
   
   arg_in    : CONSTANT flags;
   arg_out   : CONSTANT flags;
   arg_inout : CONSTANT flags;
   
   TYPE NamedValue IS
   RECORD
      name      : identifier;
      argument  : any;
      len       : long;
      arg_modes : flags;
   END RECORD;
   
   out_list_memory    : CONSTANT flags;
   in_copy_value      : CONSTANT flags;
   inv_no_response    : CONSTANT flags;
   inv_term_on_err    : CONSTANT flags;
   resp_no_wait       : CONSTANT flags;
   dependent_list     : CONSTANT flags;
   ctx_restrict_scope : CONSTANT flags;
   
   TYPE status IS NEW Corba.unsigned_long;

PRIVATE
   
   TYPE any IS 
   RECORD
      typex : TypeCode.Object;
      value : SOM.Address;
   END RECORD;

   arg_in    : CONSTANT flags := 16#00000001#;
   arg_out   : CONSTANT flags := 16#00000002#;
   arg_inout : CONSTANT flags := 16#00000004#;
   
   in_copy_value      : CONSTANT flags := 16#00000008#;
   dependent_list     : CONSTANT flags := 16#00000010#;
   out_list_memory    : CONSTANT flags := 16#00000020#;
   inv_no_response    : CONSTANT flags := 16#00000040#;
   inv_term_on_err    : CONSTANT flags := 16#00000080#;
   resp_no_wait       : CONSTANT flags := 16#00000100#;
   ctx_restrict_scope : CONSTANT flags := 16#00000400#;
   
END Corba;
