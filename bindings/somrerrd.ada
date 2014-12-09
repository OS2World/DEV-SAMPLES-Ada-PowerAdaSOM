
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:51 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRErrorDefinition IS


   somrException : EXCEPTION;

   TYPE somrException_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      primary : Corba.Long;
      secondary : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( somrException_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      somrException_members;
     
     --
     --Primary Error Codes.

   SOMR_SYSTEM_ERROR : CONSTANT Corba.Long := 1;

   SOMR_FRAMEWORK_ERROR : CONSTANT Corba.Long := 2;

   SOMR_FRAMEWORK_STATUS : CONSTANT Corba.Long := 3;
     
     --
     --Secondary Error/Status Codes.

   SOMR_ACK : CONSTANT Corba.Long := 11111;

   SOMR_FAILURE : CONSTANT Corba.Long := -1;

   SOMR_BASE : CONSTANT Corba.Long := 500;

   SOMR_TIMEOUT : CONSTANT Corba.Long := 500;

   SOMR_OK : CONSTANT Corba.Long := 501;

   SOMR_GRANTED : CONSTANT Corba.Long := 501;

   SOMR_UNAUTHORIZED : CONSTANT Corba.Long := 502;

   SOMR_TRYLATER : CONSTANT Corba.Long := 503;

   SOMR_DENIED : CONSTANT Corba.Long := 504;

   SOMR_LOCKBUSY : CONSTANT Corba.Long := 505;

   SOMR_AMNOTMASTER : CONSTANT Corba.Long := 506;

   SOMR_NOTMYSHDO : CONSTANT Corba.Long := 507;

   SOMR_MASTER_UNREACHABLE : CONSTANT Corba.Long := 508;

   SOMR_NEWMASTER : CONSTANT Corba.Long := 509;

   SOMR_URMASTER : CONSTANT Corba.Long := 510;

   SOMR_DONTHAVIT : CONSTANT Corba.Long := 511;

   SOMR_RELEASED : CONSTANT Corba.Long := 512;

   SOMR_CONNECTION_CLOSED : CONSTANT Corba.Long := 513;

   SOMR_LOCKNLOG_BADIR : CONSTANT Corba.Long := 514;

   SOMR_LOCKNLOG_PARAM : CONSTANT Corba.Long := 515;

   SOMR_LOCKNLOG_FAIL : CONSTANT Corba.Long := 516;

END SOMRErrorDefinition; 



