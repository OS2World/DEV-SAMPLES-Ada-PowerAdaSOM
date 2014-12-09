WITH SOM;
WITH tablet;
WITH x_lib;
WITH xt;

PACKAGE callbacks IS

   my_tablet           : tablet.ref;
   application_context : xt.xt_app_context;

   PROCEDURE event_callback (
      dummy_event : IN SOM.SOMObjectPtr;
      display     : IN x_lib.display);
   PRAGMA export (C, event_callback, "Event_callback");

   PROCEDURE begin_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event);
   PRAGMA export (C, begin_callback, "Begin_callback");

   PROCEDURE draw_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event);
   PRAGMA export (C, draw_callback, "Draw_callback");

   PROCEDURE exposure_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event);
   PRAGMA export (C, exposure_callback, "Exposure_callback");

END callbacks;


WITH corba;

PACKAGE BODY callbacks IS

   PROCEDURE event_callback (
      dummy_event : IN SOM.SOMObjectPtr;
      display     : IN x_lib.display)
   IS
      temp    : xt.x_event;
      ignored : boolean;
   BEGIN
      WHILE (x_lib.events.x_pending(display) > 0) LOOP
         xt.xt_event_management.xt_app_process_event (
            app_context  => application_context,
            mask         => xt.xt_event_management.xt_im_all);
      END LOOP;
   END event_callback;
   
   
   PROCEDURE begin_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event)
   IS
   BEGIN
      tablet.beginLine (
         callbacks.my_tablet, 
	 corba.long(event.e.button.x), 
	 corba.long(event.e.button.y));
   END begin_callback;


   PROCEDURE draw_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event)
   IS
      FUNCTION "="(l,r:IN x_lib.events.key_and_button_mask) 
         RETURN BOOLEAN RENAMES x_lib.events."=";
      FUNCTION "/"(l,r:IN x_lib.events.key_and_button_mask) 
         RETURN x_lib.events.key_and_button_mask RENAMES x_lib.events."/";
      FUNCTION "*"(l,r:IN x_lib.events.key_and_button_mask) 
         RETURN x_lib.events.key_and_button_mask RENAMES x_lib.events."*";
   BEGIN
      -- We want to ignore any modifier keys associated with these
      --  button presses, so mask out the lower 8 bits.
      IF (event.e.motion.state/256)*256 = x_lib.events.button_1_mask THEN
         tablet.drawLine(
	    my_tablet, 
	    corba.long(event.e.motion.x), 
	    corba.long(event.e.motion.y));
      ELSIF (event.e.motion.state/256)*256 = x_lib.events.button_3_mask  THEN
         tablet.clearAll(my_tablet);
      ELSE
         NULL;
      END IF;
   END draw_callback;


   PROCEDURE exposure_callback (
      w           : IN xt.widget;
      client_data : IN integer;
      event       : IN x_lib.events.event)
   IS
   BEGIN
      tablet.redraw(my_tablet);
   END exposure_callback;


END callbacks;



PROCEDURE repdraw;

WITH system;
WITH unchecked_conversion;
with xt_stringdefs;
WITH x_lib;
WITH xt;
WITH x_system_utilities;

WITH callbacks;
WITH corba;
WITH tablet;
WITH SOM;
WITH SOMEEMan;
WITH SOMEEMRegisterData;
WITH SOMR;

PROCEDURE repdraw IS

   USE x_system_utilities.command_line_utilities,
       x_lib;

   FUNCTION "+"(l,r: IN corba.unsigned_long) RETURN corba.unsigned_long
      RENAMES Corba."+";
      
   function xm_create_drawing_area( 
      parent     : xt.widget;
      name       : system.address;
      an_arg_list: system.address;
      arg_count  : natural) return xt.widget;
   pragma interface(c, xm_create_drawing_area);
   pragma interface_information( 
      xm_create_drawing_area, ".XmCreateDrawingArea" );
      
   argc      : argc_type := get_argc;
   argv      : argv_list :=  get_argv;
   toplevel  : xt.widget;
   drawarea  : xt.widget;
   args      : xt.xt_ancillary_types.xt_arg_list (1 .. 8);
   display   : x_lib.display;

   drawarea_name:  constant string := "DrawArea" & ascii.nul;

   myOwnSelf : SOMR.Ref;
   EManPtr   : SOMEEMan.Ref;
   regData   : SOMEEMRegisterData.Ref;
   regId     : corba.long;
   xfd       : corba.long;
   ev        : som.environment;
   
   FUNCTION to_voidPtr IS NEW unchecked_conversion(x_lib.display, SOM.voidPtr);
   FUNCTION to_voidPtr IS NEW unchecked_conversion(xt.widget, SOM.voidPtr);
BEGIN

   EManPtr := SOMEEMan.new_instance;
   regData := SOMEEMRegisterData.new_instance;
   myOwnSelf := SOMR.new_instance;      
	    
   xt.xt_initializers.xt_app_initialize (
         app_context_return => callbacks.application_context,
         application_class  => "Rdraw",
         options            => x_lib.resource_manager.null_xrm_options,
         argc_in_out        => argc,
         argv_in_out        => argv,
         fallback_resources => xt.null_xt_string_list,
         args               => xt.xt_ancillary_types.null_xt_arg_list,
         widget_id          => toplevel);

   xt.xt_resource_management.xt_set_arg (
      arg   => args (1),
      name  => xt_stringdefs.xt_n_width,
      value => 500);
   xt.xt_resource_management.xt_set_arg (
      arg   => args (2),
      name  => xt_stringdefs.xt_n_height,
      value => 500);
   drawarea :=
      xm_create_drawing_area(
         parent      => toplevel,
	 name        => drawarea_name(drawarea_name'first)'address,
         an_arg_list => args(args'first)'address,
         arg_count   => 2);
   xt.xt_composite_management.xt_manage_child (drawarea);
   
   xt.xt_event_management.xt_add_event_handler(
      w             => drawarea,
      an_event_mask => x_lib.events.button_press_mask,
      non_maskable  => false,
      proc          => callbacks.begin_callback'address,
      client_data   => xt.null_xt_pointer);
   xt.xt_event_management.xt_add_event_handler(
      w             => drawarea,
      an_event_mask => x_lib.events.button_motion_mask,
      non_maskable  => false,
      proc          => callbacks.draw_callback'address,
      client_data   => xt.null_xt_pointer);
   xt.xt_event_management.xt_add_event_handler(
      w             => drawarea,
      an_event_mask => x_lib.events.exposure_mask,
      non_maskable  => false,
      proc          => callbacks.exposure_callback'address,
      client_data   => xt.null_xt_pointer);

   -- Create the X window used by the widgets.
   xt.xt_instance_management.xt_realize_widget (toplevel);

   callbacks.my_tablet := tablet.new_instance;
   tablet.setTablet(callbacks.my_tablet, to_voidPtr(drawarea));
   
   display := xt.xt_instance_management.xt_display(toplevel);
   xfd := corba.long(x_lib.x_connection_number(display));
   SOMEEMRegisterData.someClearRegData(regData, ev);
   SOMEEMRegisterData.someSetRegDataEventMask(
      regData, 
      ev, 
      56, --SOMEEMan.EMSinkEvent, 
      SOM.null_address);
   SOMEEMRegisterData.someSetRegDataSink(
      regData, 
      ev, 
      xfd);
   SOMEEMRegisterData.someSetRegDataSinkMask(
      regData, 
      ev, 
      4 + 1); --SOMEEMan.EMInputReadmask + SOMEEman.EMInputExceptMask); 
   regid :=
      SOMEEMan.someRegisterProc(
         EManPtr,
         ev, 
         regdata.som_object, 
         SOM.To_SOM_Address(callbacks.event_callback'address),
         to_voidPtr(display));

   -- Handle any existing events.      
   callbacks.event_callback(SOM.null_address, display);

   -- Enter the event loop.
   SOMEEMan.someProcessEvents(EManPtr, ev);
END repdraw;
