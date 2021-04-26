USE `proyecto1_BD` ;

-- Script de llenado
insert into users (idUser, firstname, lastname, username, email, verified, password, checksum)
values(1,"Lolo", "Fernández", "LolitoFNDZ", "lolencioElCrack@gmail.com",1, 100010101001001110,"0x62736A696F"),
(2,"Taylor", "Hernández", "TAY-LORD_OF_THE_HELL", "taylor20sep.hc@gmail.com",0, 1101011001000,"0x669EB8A696F"),
(3,"Juan", "Vargas", "Fletes_Baratos", "juanVF@Yopmail.com",0, 100001011010111,"0x235FA4D89D3"),
(4,"Yuen", "Law", "Yuen777", "yuenlawTEC@Yopmail.com",1, 101110011010101,"0x3521BA7C459D"),
(5,"Alejandro", "Castro", "Don_Simon", "alejandro_gamer666@hotmail.com",0, 11101100000,"0x214CC7D958A"),
(6,"Ruben", "Viquez", "RubiusUwU", "rubiuNoSeasMalo@gmail.com",1, 1111110000001,"0x2A45D1D9581"),
(7,"Carlos", "Alvarado", "Charly_God", "ElPresi666@hotmail.com",0, 10000110001,"0x75ACB66BD20"),
(8,"Florentino", "Perez", "FlorentiNop", "florentinoPerez123@gmail.com",1, 101010111000,"0x123BDB66B01A"),
(9,"Francisco", "Franco", "xX_Franchesco_Xx", "arribaFranco@gmail.com",1, 1001011000101,"0x41C2ABF45E"),
(10,"Luis", "Miguel", "eLSolazo", "luismiguelelcrack@hotmail.com",0, 1110010110100,"0x541AB2CCF12");

insert into Channel ( `idChannel`,`displayName` ,`description` ,`pictureURL` ,`idUser`)
values(1,"Lolito", "Jejeje yepas jeje", "https://images.app.goo.gl/cpDD8XVikgPnEnJd9", 1),
(2,"Tay-Lord", "momento xd", "https://images.app.goo.gl/HNA2H1Vz1GDaoCrv9", 2),
(3,"Juancin", "Mi madre me dio la vida, pero Tusa las ganas de vivirla", "https://images.app.goo.gl/agBxQAekVfxux95A7", 3),
(4,"Yuen", "Lo unico más duro en esta vida que un algoritmo NP-Duro, es no tenerte baby", "https://images.app.goo.gl/ufMstNaYFzmno8GM6", 4),
(5,"Ale-Luya", "Simón", "https://images.app.goo.gl/iqNTDrC7zEkiZgn77", 5),
(6,"Rubiu", "ust ust", "https://images.app.goo.gl/EibfqZS5EPee3zJ3A", 6),
(7,"Charly Alvarado", "Un chuzo de mae", "https://images.app.goo.gl/VWkNwDSPrUwpDUrf7", 7),
(8,"Florentino", "Ni tan superman va a ser tan Super como mi liga. HALA MADRID!. SIUUUU", "https://images.app.goo.gl/gMuiRSMGrp7f9coe6", 8),
(9,"Franco", "Arriba España. Si España te ataca, no hay error, no hay error", "https://images.app.goo.gl/Di6caAhjUKbw8BKx7", 9),
(10,"LuisMi", "Si tú me hubieras dicho siempre la verdad, Si hubieras respondido cuando te llamé, Si hubieras amado cuando te amé, Serías en mis sueños la mejor mujer… ", "https://images.app.goo.gl/PudHayh5p9ZofEAfA", 10);

insert into categories (`name`)
values ("Legue Of Legends"), ("The Binding Of Isaac"), ("Warzone"), ("Genshi Impact"), ("Just Talking"), ("ASMR"), ("Free Fire"), ("Clash Royale"), ("Mongos"), 
("Betrayel.io"), ("Valorant"),("Fortnie"),("Agar.io"),("Pinturillo"), ("Omegle"), ("Blog en Vivo"), ("Programación");

insert into tags (`name`)
values ("RPG"), ("Shooter"), ("Random"), ("Blog"), ("Funny"), ("Girl"), ("Mobile"), ("Acción"), ("MOBA"), 
("IRL"), ("Carreras"),("Plataformas"),("Terror"),("Simulación"), ("Puzle");

insert into VideoQuality(`quality`)
values  ("144"), ("240"), ("360"), ("480"),("720"),("1080");

insert into AllowedDatatypes(`datatype`)
values  ("MP3"), ("MP4"), ("MPEG-4"), ("MOV");






