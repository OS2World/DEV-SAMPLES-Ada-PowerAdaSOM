
PROCEDURE hello_client;

WITH hello;
WITH Corba;
WITH SOM;

PROCEDURE hello_client 
IS  
   cm    : SOM.somClassMgrPtr;

   ev    : SOM.Environment;
   
   class : SOM.somClassPtr;
   
   obj   : hello.ref;
   
BEGIN

   cm := SOM.somEnvironmentNew;
   
--   ev := SOM.somGetGlobalEnvironment;   

   class := hello.new_class(hello.major_Version, hello.minor_version);
   
   obj := hello.new_instance;

   hello.set_repeatCount(obj, ev, 5);   
   hello.sayHello(obj, ev);
   
   hello.free_instance(obj);
   
END hello_client;
