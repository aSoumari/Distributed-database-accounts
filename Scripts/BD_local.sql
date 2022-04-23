create or replace view client(no, nom , prenom, Adresse, Ville) as
select no, nom , prenom, Adresse, 'Casablanca' from client_1@ensias1 
union 
select no, nom , prenom, Adresse, 'Rabat' from client_2@ensias2 ;

create or replace view type_operation as
select * from type_operation_2@ensias2 ;

create or replace view type_compte as
select * from type_compte_2@ensias2;

create or replace view agence(no, nom , Adresse, Ville) as
select * from agence@ensias1;


create or replace view compte as
select * from compte_1@ensi as1
union
select * from compte_2@ensias2;

create or replace view operation as
select * from operation_1@ensias1
union
select * from operation_2@ensias2;