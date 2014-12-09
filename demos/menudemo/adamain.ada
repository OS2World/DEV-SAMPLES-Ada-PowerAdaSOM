with corba;
with SOM;
with SOMEEMAN;
with system;
package CALLBACK is
  
   value_logging : corba.long := 0;
   PRAGMA export(C, value_logging, "value_logging");
   
   procedure PROCESSINPUT( DUMMY_event:  IN SOM.SOMOBJECTPTR;
			   CLIENT_DATA:  in system.address);
   pragma EXPORT(C, PROCESSINPUT, "Process_Input" );
   PROCEDURE print_menu;
end CALLBACK;

with CORBA;
with REPTESTOBJ;
with SYSTEM;
with TEXT_IO;
with UNCHECKED_CONVERSION;
package body CALLBACK is
   
  
   PROCEDURE unix_exit(rc : IN integer);
   PRAGMA interface (c, unix_exit);
   PRAGMA interface_information (unix_exit, "._exit");
   
   EV:  SOM.ENVIRONMENT;
   
   OBJECT_DATA:  CORBA.STRING;
   REP_OBJECT :  REPTESTOBJ.REF;
   
   procedure SET_OBJECT;
   procedure gET_OBJECT;
   procedure unINIT_OBJECT;
   
   FUNCTION ada_string (
      string_address : IN corba.string)
      RETURN string
   IS
      SUBTYPE big_string IS string (1 .. 2000);
      TYPE access_big_string IS ACCESS big_string;
      string_ptr : access_big_string;
      string_length : natural;
      FUNCTION convert IS
         NEW unchecked_conversion (corba.string, access_big_string);
   BEGIN
      string_ptr := convert (string_address);
      if string_ptr = null then
         return "<null>"; 
      end if;
      string_length := 0;
      WHILE
         string_ptr (string_length + 1) /= ascii.nul
      LOOP
         string_length := string_length + 1;
      END LOOP;
      RETURN string_ptr (1 .. string_length);
   END ada_string;
   
   
   procedure SET_OBJECT is
      LINE:  STRING(1..2048);
      LEN:  NATURAL;      
      RESULT:  CORBA.LONG;
   begin
      TEXT_IO.PUT_LINE( "Set object data to:" );
      TEXT_IO.GET_LINE(LINE, LEN);
      LINE(LEN+1) := ASCII.NUL;
      RESULT := REPTESTOBJ.SOMRTESTSETDATA
	( REP_OBJECT, 
	  SOM.SOMGETGLOBALENVIRONMENT.all, 
	LINE(LINE'First)'address );
   end;
   procedure gET_OBJECT is
   begin
      TEXT_IO.PUT_LINE("Object data:  >" 
		       & ADA_STRING
		       ( REPTESTOBJ.SOMRTESTGETDATA
			 ( REP_OBJECT, SOM.SOMGETGLOBALENVIRONMENT.all ) ) 
		       & "<" );
   end;
   
   procedure unINIT_OBJECT is
   begin
      REPTESTOBJ.SOMRPERFORMREPBLUNINIT
	( REP_OBJECT, ev );
   end;
   
   PROCEDURE print_menu
   IS
   BEGIN
      text_io.put_line("========== REPLICATED OBJECT MENU ==========");
      text_io.put_line("         Set the State of an Object (S)");
      text_io.put_line("         Get the State of an Object (G)");
      text_io.put_line("         Create a New Test Object   (N)");
      text_io.put_line("         Perform RepblUnInit        (U)");
      text_io.put_line("         Perform RepblInit          (I)");
      text_io.put_line("         Quit Replication           (Q)");
      text_io.put_line("     PLEASE ENTER YOUR SELECTION:");
   END print_menu;
   
   
   procedure PROCESSINPUT( DUMMY_event:  IN SOM.SOMOBJECTPTR;
			   CLIENT_DATA:  in system.address) is
      LINE:  STRING(1..2048);
      LEN:  NATURAL;
   begin
	 TEXT_IO.GET_LINE(LINE, LEN);
	 case LINE(LINE'FIRST) is
	    when 'q' | 'Q' =>
               unix_exit(0);

	    when 's' | 'S' =>
	       SET_OBJECT;
	    when 'g' | 'G' =>
	       GET_OBJECT;
	    when 'n' | 'N' =>
               rep_object := reptestobj.new_instance;

	    when 'i' | 'I' =>
               REPTestObj.somrPerformRepblInit(rep_object,ev);

	    when 'u' | 'U' =>
	       UNINIT_OBJECT;
	    when others =>
	       TEXT_IO.PUT_LINE("Illegal");
	 end case;

   end PROCESSINPUT;
      

end CALLBACK;

with CALLBACK;
with REPTESTOBJ;
with SYSTEM;
with CORBA;
with SOM;
with SOMEEMAN;
with SOMEEMREGISTERDATA;
with SOMR;

procedure AdaMAIN is
   REPTD:  SOMR.REF;
   EMANPTR:  SOMEEMAN.REF;
   REGDATA:  SOMEEMREGISTERDATA.ref;
   EMSINKEVENT:  constant := 56;
   STDINPUT:  constant := 0;
   EMINPUTREADMASK:  constant := 1;
   REGISTRATION_ID:  CORBA.LONG;
   ev        : som.environment;
   CLIENT_DATA: constant STRING := "STDIN" & ASCII.NUL;
begin
   EMANPTR :=    SOMEEMAN.NEW_INSTANCE;
   regData := SOMEEMRegisterData.new_instance;
   REPTD := SOMR.NEW_INSTANCE;
   SOMEEMREGISTERDATA.SOMECLEARREGDATA( REGDATA, EV );
   SOMEEMREGISTERDATA.SOMESETREGDATAEVENTMASK
     ( REGDATA, 
       EV, 
       EMSINKEVENT, 
       SOM.NULL_address );
   SOMEEMREGISTERDATA.SOMESETREGDATASINK( REGDATA, EV, STDINPUT );
   SOMEEMREGISTERDATA.SOMESETREGDATASINKMASK
     ( regData, Ev, EMINPUTREADMASK );
   REGISTRATION_ID := SOMEEMAN.SOMEREGISTERPROC
     ( EMANPTR, 
       EV, 
       REGDATA.SOM_OBJECT, 
       SOM.To_SOM_Address(CALLBACK.PROCESSINPUT'Address), 
       SOM.To_SOM_Address(CLIENT_DATA(CLIENT_DATA'First)'address) );
   callback.PRINT_MENU;

   SOMEEMAN.SOMEPROCESSEVENTS( EManPtr, EV ); 

end AdaMAIN;
