------------------------------------------------------------------------------
-- corba.body : CORBA definitions -- PACAKGE BODY
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec20 Upgrade to use implemented Ada95 features. (d2189)
-- 94Dec09 swn Comment out references to Ada.Exceptions.
-- 94Oct10 swn Created from mapping document.
------------------------------------------------------------------------------
--
-- CORBA provides the basic definitions required by the IDL-to-Ada95
-- mapping specification.
--
------------------------------------------------------------------------------

WITH unchecked_conversion;

PACKAGE BODY Corba IS
   
   PRAGMA comment("@(#) ada/runtime/som/corba.body, ada, power95.3 1.4 12/21/95 12:21:10");
   
   ---------------------------------------------------------------------------
   
   USE TYPE SOM.any;
   
   ---------------------------------------------------------------------------
   
   FUNCTION get_members (
      x      : IN ada.exceptions.exception_occurrence)
      RETURN      ex_body
   IS
      Result : ex_body;
   BEGIN
      -- Unimplemented.
      RAISE program_error;
      RETURN result;
   END get_members;
   
   
   PACKAGE BODY TypeCode IS 
      
      
      FUNCTION get_members (
         x      : IN ada.exceptions.exception_occurrence)
         RETURN      bounds_members
      IS
         Result : bounds_members;
      BEGIN
         -- Unimplemented.
         RAISE program_error;
         RETURN result;
      END get_members;
      
      
      FUNCTION equal (
         self   : IN object;
         tc     : IN object)
         RETURN      Corba.boolean
      IS
         FUNCTION tcEqual (
            x      : IN object;
            env    : IN SOM.Environment;
            y      : IN object)
            RETURN   Corba.Boolean;
         PRAGMA interface (assembly, tcEqual);
         PRAGMA interface_information (tcEqual, ".tcEqual");
         e : SOM.environment;
      BEGIN
         RETURN tcEqual(self, e, tc);
      END equal;
      
      
      FUNCTION kind (
         self   : IN object)
         RETURN      tckind
      IS
         FUNCTION tcKindx (
            t      : IN object;
            env    : IN SOM.Environment)
            RETURN   Corba.tckind;
         PRAGMA interface (assembly, tcKindx);
         PRAGMA interface_information (tcKindx, ".tcKind");
         e : SOM.environment;
      BEGIN
         RETURN tcKindx(self, e);
      END kind;
         
      
      FUNCTION param_count (
         self   : IN object)
         RETURN      Corba.long
      IS
         FUNCTION tcParmCount (
            t      : IN object;
            env    : IN SOM.Environment)
            RETURN   Corba.Long;
         PRAGMA interface (assembly, tcParmCount);
         PRAGMA interface_information (tcParmCount, ".tcParmCount");
         e : SOM.environment;
      BEGIN
         RETURN tcParmCount(self, e);
      END param_count;
      
      
      FUNCTION parameter (
         self   : IN object;
         index  : IN Corba.long)
         RETURN      any
      IS
         result : any;
      BEGIN
         RAISE program_error;
         RETURN result;
      END parameter;
      
   END TypeCode;


   FUNCTION type_of (
      the_any : IN any)
      RETURN       TypeCode.object
   IS
   BEGIN
      RETURN the_any.typex;
   END type_of;
   
      
   FUNCTION to_any (from : IN octet)          RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN short)          RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN long)           RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN unsigned_short) RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN unsigned_long)  RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN boolean)        RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN char)           RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   FUNCTION to_any (from : IN string)         RETURN any
   IS
      result : any;
   BEGIN
      RAISE program_error;
      RETURN result;
   END to_any;
   
   
   FUNCTION to_octet          (from : IN any) RETURN octet
   IS
      TYPE access_octet IS ACCESS octet;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_octet);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_octet THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_octet;
   
   
   FUNCTION to_short          (from : IN any) RETURN short
   IS
      TYPE access_short IS ACCESS short;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_short);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_short THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_short;
   
   FUNCTION to_long           (from : IN any) RETURN long
   IS
      TYPE access_long IS ACCESS long;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_long);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_long THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_long;
   
   FUNCTION to_unsigned_short (from : IN any) RETURN unsigned_short
   IS
      TYPE access_unsigned_short IS ACCESS unsigned_short;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_unsigned_short);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_ushort THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_unsigned_short;
   
   FUNCTION to_unsigned_long  (from : IN any) RETURN unsigned_long
   IS
      TYPE access_unsigned_long IS ACCESS unsigned_long;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_unsigned_long);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_ulong THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_unsigned_long;
   
   FUNCTION to_boolean        (from : IN any) RETURN boolean
   IS
      TYPE access_boolean IS ACCESS boolean;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_boolean);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_boolean THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_boolean;
   
   FUNCTION to_char           (from : IN any) RETURN char
   IS
      TYPE access_char IS ACCESS char;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_char);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_char THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_char;
   
   FUNCTION to_string         (from : IN any) RETURN string
   IS
      TYPE access_string IS ACCESS string;
      FUNCTION convert IS 
         NEW unchecked_conversion(som.address, access_string);
   BEGIN
      IF TypeCode.Kind(from.typex) = tk_string THEN
         RETURN convert(from.value).all;
      ELSE
         RAISE constraint_error;
      END IF;
   END to_string;
   
   
END Corba;
