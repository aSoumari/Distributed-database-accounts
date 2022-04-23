

------agence
create or replace trigger tg_dml_agence
instead of insert or delete or update on agence 
for each row 
begin 
if inserting then
insert into agence@ensias1 values(seq_agence.nextval,:new.nom,:new.Adresse,:new.Ville);
end if;

if updating then
update agence@ensias1 set nom=:new.nom,Adresse=:new.Adresse ,Ville=:new.Ville where no=:old.no;
end if;

if deleting then
delete from agence@ensias1 where no=:old.no;
end if;

end;
/ORA-02082: a loopback database link must have a connection qualifier
alter session set global_names=true; --ensias1
alter database rename global_name to CHICAGO;
select name from v$database@BOSTON;
create database link SOURCE_LINK connect to hr identified by password using 'SOURCE_DATABASE';
----type_compte

CREATE OR REPLACE TRIGGER tg_dml_type_compte
    INSTEAD OF INSERT or update or delete ON type_compte
    FOR EACH ROW
BEGIN
if inserting then
insert into type_compte_2@ensias2 values (seq_type_compte.nextval,:new.libelle_compte,:new.description);
end if;

if updating then
update type_compte_2@ensias2 set libelle_compte=:new.libelle_compte,description=:new.description where no=:old.no;
end if;

if deleting then
delete from type_compte_2@ensias2 where no=:old.no;
end if;

END;
/

-----type_operation

CREATE OR REPLACE TRIGGER tg_dml_type_operation
    INSTEAD OF INSERT or update or delete ON type_operation
    FOR EACH ROW
BEGIN
if inserting then
insert into type_operation_2@ensias2 values (seq_type_operation.nextval,:new.libelle_operation,:new.description);
end if;

if updating then
update type_operation_2@ensias2 set libelle_operation=:new.libelle_operation,description=:new.description where no=:old.no;
end if;

if deleting then
delete from type_operation_2@ensias2 where no=:old.no;
end if;

END;
------------------------------------

-----insert client


create or replace trigger tg_in_client
instead of insert on client 
for each row 
begin
 
if :new.ville='Casablanca' then
insert into client_1@ensias1 values(seq_client.nextval, :new.nom , :new.prenom, :new.Adresse);
end if;

if :new.ville='Rabat' then
insert into client_2@ensias2 values(seq_client.nextval, :new.nom , :new.prenom, :new.Adresse);
end if;

end;
/

----------delete client

create or replace trigger tg_del_client
instead of delete on client 
for each row 
begin
 
if :old.ville='Casablanca' then
delete from client_1@ensias1 where no=:old.no;
end if;

if :old.ville='Rabat' then
delete from client_2@ensias2 where no=:old.no;
end if;

end;

-----------update client
create or replace trigger tg_del_client
instead of update on client 
for each row 
begin
 
if :old.ville='Casablanca' then
update  client_1@ensias1 set  nom=:new.nom ,prenom=:new.prenom, Adresse=:new.Adresse where no=:old.no;
end if;

if :old.ville='Rabat' then
update  client_2@ensias2 set  nom=:new.nom ,prenom=:new.prenom, Adresse=:new.Adresse where no=:old.no;
end if;

end;


--------insert compte

create or replace trigger tg_in_compte
instead of insert on compte 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc from client where no=:new.client_no;
if v_nc='Casablanca' then
insert into compte_1@ensias1 
values(seq_compte.nextval,:new.type_compte_no ,TO_DATE( :new.dateOuverture , 'DD MON YYYY' ),
:new.decouvert_autorise ,:new.solde , :new.client_no , :new.agence_no);
end if;

if v_nc='Rabat' then
insert into compte_2@ensias2 
values(seq_compte.nextval,:new.type_compte_no ,TO_DATE( :new.dateOuverture , 'DD MM YYYY' ), 
:new.decouvert_autorise ,:new.solde , :new.client_no , :new.agence_no);
else raise_application_error(-20175,'reference n existe pas');
end if;

end;
/

--------update compte

create or replace trigger tg_up_compte
instead of update on compte 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc from client where no=:old.client_no;
if v_nc='Casablanca' then
update compte_1@ensias1 set 
type_compte_no=:new.type_compte_no ,dateOuverture=TO_DATE(:new.dateOuverture , 'DD MM YYYY' ), 
decouvert_autorise=:new.decouvert_autorise ,solde=:new.solde ,agence_no=:new.agence_no
where no=:old.no;
end if;

if v_nc='Rabat' then
update compte_2@ensias2 set 
type_compte_no=:new.type_compte_no ,dateOuverture=TO_DATE(:new.dateOuverture , 'DD MM YYYY' ), 
decouvert_autorise=:new.decouvert_autorise ,solde=:new.solde ,agence_no=:new.agence_no
where no=:old.no;
else raise_application_error(-20175,'reference n existe pas client');

end if;

end;
/

--------delete compte

create or replace trigger tg_del_compte
instead of delete on compte 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc from client where no=:old.client_no;
if v_nc='Casablanca' then
delete from compte_1@ensias1
where no=:old.no;
end if;

if v_nc='Rabat' then
delete from compte_2@ensias2 
where no=:old.no;
end if;

end;


----------insert operation
create or replace trigger tg_in_operation
instead of insert on operation 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc from client where no=(select client_no from compte where no=:new.compte_no);
if v_nc='Casablanca' then
insert into operation_1@ensias1 values(seq_operation.nextval,:new.type_operation_no, :new.compte_no );
end if;

if v_nc='Rabat' then
insert into  operation_2@ensias2 values(seq_operation.nextval,:new.type_operation_no, :new.compte_no);
end if;

end;
/

--------------update operation
create or replace trigger tg_up_operation
instead of update on operation 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc 
 from client 
 where no=(select client_no from compte where no=:old.compte_no);
if v_nc='Casablanca' then
update  operation_1@ensias1 set  type_operation_no=:new.type_operation_no where no=:old.no;
end if;

if v_nc='Rabat' then
update operation_2@ensias2 set  type_operation_no=:new.type_operation_no where no=:old.no;
end if;

end;

--------------delete operation
create or replace trigger tg_up_operation
instead of delete on operation 
for each row
declare
v_nc varchar(50); 
begin
 select ville into v_nc 
 from client 
 where no=(select client_no from compte where no=:old.compte_no);
if v_nc='Casablanca' then
delete from operation_1@ensias1  where no=:old.no;
end if;

if v_nc='Rabat' then
delete from operation_2@ensias2 where no=:old.no;
end if;

end;
/
























































---------views

create or replace view client(no, nom , prenom, Adresse, Ville) as
select no, nom , prenom, Adresse, 'Casablanca' from client_1@ensias1 
union 
select no, nom , prenom, Adresse, 'Rabat' from client_2@ensias2 ;

create or replace view compte as
select * from compte_1@ensias1
union
select * from compte_2@ensias2;

create or replace view operation as
select * from operation_1@ensias1
union
select * from operation_2@ensias2;

create or replace view type_operation as
select * from type_operation_2@ensias2 ;

create or replace view type_compte as
select * from type_compte_2@ensias2;

create or replace view agence as
select * from agence@ensias1;


















































--ensias2 trigger constraint fk compte_2->agence
create or replace trigger fk_compte2_agence
before update or insert of agence_no on compte_2
for each row 
DECLARE
v_no int;
begin
 select count(*) into v_no from agence@ensias1 where no=:new.agence_no;
if v_no=0 then
 raise_application_error(-20111,'Operation interdite: Agence inconnue');
end if;
end;
/
--ensias1 trigger constrait fk agence->compte_2  
create or replace trigger fk_agence_compte2
before delete or update of no on agence
for each row 
declare
v_no int;
begin 
 select count(*) into v_no from compte_2@ensias2 where agence_no=:old.no;
if v_no>0 then
 raise_application_error(-20122,'Operation interdite: Agence referencee a partir de compte 2');
end if;
end;
/


--ensias2 trigger constraint fk type_compte_2->compte_1
create or replace trigger fk_tycomp_comp1
before delete or update of no on type_compte_2
for each row 
declare
v_no int;
begin 
 select count(*) into v_no from compte_1@ensias1 where type_compte_no=:old.no;
if v_no>0 then
 raise_application_error(-20112,'Opération interdite: type_compte référencée à partir de compte 1');
end if;
end;



--ensias1 trigger constrait fk compte_1->type_compte_2  
create or replace trigger fk_comp1_tycomp
before insert or update of type_compte_no on compte_1
for each row 
DECLARE
v_no int;
begin 
select count(*) into v_no from type_compte_2@ensias2 where no=:new.type_compte_no;
if v_no=0 then
 raise_application_error(-20112,'Opération interdite: type_compte inconnue');
end if;
end;
/
--ensias1 trigger constrait fk operation_1->type_operation_2  
create or replace trigger fk_oper_tyoper2
before insert or update of type_operation_no on operation_1
for each row 
DECLARE
v_no int;
begin 
select count(*) into v_no from type_operation_2@ensias2 where no=:new.type_operation_no;
if v_no=0 then
 raise_application_error(-20113,'Opération interdite: type_operation inconnue');
end if;
end;
/
--ensias2 trigger constraint fk type_operation_2->operation_1
create or replace trigger fk_tyoper2_oper
before delete or update of no on type_operation_2
for each row 
declare
v_no int;
begin 
 select count(*) into v_no from operation_1@ensias1 where type_operation_no=:old.no;
if v_no>0 then
 raise_application_error(-20113,'Opération interdite: type_operation référencée à partir de operation 1');
end if;
end;