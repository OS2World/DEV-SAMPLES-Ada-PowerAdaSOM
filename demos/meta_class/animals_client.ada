
   --------------------------------------------------------------------------
-- Animals client demonstration program.
   --------------------------------------------------------------------------

PROCEDURE animals_client;

WITH animals;
WITH animals.animal;
WITH animals.dog;
WITH animals.bigdog;
WITH animals.littledog;
WITH animals.m_animal;
WITH animals.kennel;

WITH SOM;
WITH Corba;
WITH system;
WITH text_io;
WITH unchecked_conversion;

PROCEDURE animals_client
IS

   cm    : SOM.somClassMgrPtr;

   ev    : SOM.environment;
   
   Animal_class    : Animals.M_Animal.Ref;
   Dog_class       : Animals.Kennel.Ref;
   BigDog_class    : Animals.Kennel.Ref;
   LittleDog_class : Animals.Kennel.Ref;

   
   FUNCTION DogNames (
      I : Natural)
      RETURN System.Address
   IS
      Lassie : CONSTANT String := "Lassie" & Ascii.Nul;
      Guffy  : CONSTANT String := "Guffy" & Ascii.Nul;
      Waldo  : CONSTANT String := "Waldo" & Ascii.Nul;
      Pluto  : CONSTANT String := "Pluto" & Ascii.Nul;
      Elvis  : CONSTANT String := "Elvis" & Ascii.Nul;
      Spike  : CONSTANT String := "Spike" & Ascii.Nul;
   BEGIN
      CASE (I MOD 6) IS
      WHEN 0 => RETURN Lassie'Address;
      WHEN 1 => RETURN Guffy'Address;
      WHEN 2 => RETURN Waldo'Address;
      WHEN 3 => RETURN Pluto'Address;
      WHEN 4 => RETURN Elvis'Address;
      WHEN 5 => RETURN Spike'Address;
      WHEN OTHERS => RAISE Program_Error;
      END CASE;
   END DogNames;
   
         
   FUNCTION DogBreeds (
      I : Natural)
      RETURN System.Address
   IS
      Collie          : CONSTANT String := "Collie" & ascii.Nul;
      Retriever       : CONSTANT String := "Retriever" & Ascii.Nul;
      German_Shepherd : CONSTANT String := "German Shepherd" & Ascii.Nul;
      Animated        : CONSTANT String := "Animated" & Ascii.Nul;
      Hounddog        : CONSTANT String := "Hounddog" & Ascii.Nul;
      Bulldog         : CONSTANT String := "Bulldog" & Ascii.Nul;
   BEGIN
      CASE (I MOD 6) IS
      WHEN 0 => RETURN Collie'Address;
      WHEN 1 => RETURN Retriever'Address;
      WHEN 2 => RETURN German_Shepherd'Address;
      WHEN 3 => RETURN Animated'Address;
      WHEN 4 => RETURN Hounddog'Address;
      WHEN 5 => RETURN Bulldog'Address;
      WHEN OTHERS => RAISE Program_Error;
      END CASE;
   END DogBreeds;
   
   FUNCTION DogColors (
      I : Natural)
      RETURN System.Address
   IS
      Tan   : CONSTANT String := "tan" & Ascii.Nul;
      Brown : CONSTANT String := "brown" & Ascii.Nul;
      Black : CONSTANT String := "black" & Ascii.Nul;
   BEGIN
      CASE (I MOD 3) IS
      WHEN 0 => RETURN Tan'Address;
      WHEN 1 => RETURN Brown'Address;
      WHEN 2 => RETURN Black'Address;
      WHEN OTHERS => RAISE Program_Error;
      END CASE;
   END DogColors;
      
   allCreatures : Animals.Animal.Animal_Unbounded.Sequence;   

   scary        : CONSTANT string := "Scary" & ascii.nul;
   roar         : CONSTANT string := "Roar!" & ascii.nul;
   rover        : CONSTANT string := "Rover" & ascii.nul;
   grrr         : CONSTANT string := "Grrr!" & ascii.nul;
   retriever    : CONSTANT string := "Retriever" & ascii.nul;
   yellow       : CONSTANT string := "yellow" & ascii.nul;
   pierre       : CONSTANT string := "Pierre" & ascii.nul;
   frenchPoodle : CONSTANT string := "French Poodle" & ascii.nul;
   yapyap       : CONSTANT string := "Yap, yap!" & ascii.nul;
   black        : CONSTANT string := "black" & ascii.nul;
   
   dummy : SOM.SOMObjectPtr;   
   current_animal : Animals.Animal.Ref;
   
BEGIN
   --------------------------------------------------------------------------
   -- Initalize the SOM environment.
   --------------------------------------------------------------------------
   
   cm := SOM.somEnvironmentNew;
   
   --------------------------------------------------------------------------
   -- Create the animal classes.
   --------------------------------------------------------------------------
   
   Animal_class := 
      Animals.M_Animal.To_Ref(
         Animals.Animal.new_class(
            Animals.Animal.major_version, 
            Animals.Animal.minor_version));
            
   Dog_class := 
      Animals.Kennel.To_Ref(
         Animals.Dog.new_class(
            Animals.Dog.major_version, 
            Animals.Dog.minor_version));
            
   BigDog_Class :=
      Animals.Kennel.To_Ref(
         Animals.BigDog.new_class(
            Animals.BigDog.major_version, 
            Animals.BigDog.minor_version));
            
   LittleDog_class := 
      Animals.Kennel.To_Ref(
         Animals.LittleDog.new_class(
            Animals.LittleDog.major_version, 
            Animals.LittleDog.minor_version));
   
   --------------------------------------------------------------------------
   -- Create some object instances.
   --------------------------------------------------------------------------
            
   -- A new animal class for scary animals that roar.
   dummy := 
      Animals.M_Animal.newAnimal(Animal_class, ev, scary'address, roar'address);

   -- A new dog named Rover that growls.
   dummy :=
      Animals.Kennel.newDog(Dog_class, ev, 
         rover'address, grrr'address, retriever'address, yellow'address);

   -- A new little dog named Pierre that yaps.
   dummy :=
      Animals.Kennel.newDog(LittleDog_class, ev, 
         pierre'address, yapyap'address, frenchPoodle'address, black'address);

    -- Six new big dogs of varying names, breeds, and colors.
    FOR i IN 1..6 LOOP

      dummy :=
         Animals.Kennel.newDog(BigDog_class, ev, 
          DogNames(I), yapyap'address, DogBreeds(I), DogColors(I));

    END LOOP;
    
   --------------------------------------------------------------------------
    -- Display all the created objects.
   --------------------------------------------------------------------------
    
    -- Retrieve all aninmal instances.
    allCreatures := Animals.M_Animal.get_instances (Animal_class, ev);

    -- Display each of them.
    FOR i IN 1..Animals.Animal.Animal_Unbounded.length(allCreatures) LOOP

        current_animal :=
            Animals.Animal.To_Ref(
                Animals.Animal.Animal_Unbounded.Element_Of(allCreatures, i));
        Animals.Animal.display(current_animal, ev);

    END LOOP;

    text_io.put_line("Total animal population is currently " &
                     Natural'Image(
                        Animals.Animal.Animal_Unbounded.Length(allCreatures)));
    
   --------------------------------------------------------------------------
    -- Destroy all the objects.
   --------------------------------------------------------------------------
    
    FOR i IN 1..Animals.Animal.Animal_Unbounded.length(allCreatures) LOOP

        current_animal :=
            Animals.Animal.To_Ref(
                Animals.Animal.Animal_Unbounded.Element_Of(allCreatures, i));
        Animals.Animal.Free_Instance(current_animal);

    END LOOP;

END animals_client;
