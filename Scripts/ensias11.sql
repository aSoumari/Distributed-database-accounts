copy to ensias2/rabat@ensias2 
create client_2 
using select no,nom,prenom,adresse 
from client where ville='Rabat';

copy to ensias2/rabat@ensias2 
create compte_2 
using select * 
from compte 
where client_no in(select no from client where ville='Rabat');

copy to ensias2/rabat@ensias2 
create operation_2 
using select *
from operation 
where COMPTE_NO in(SELECT no FROM compte where client_no in(select no from client where ville='Rabat'));

copy to ensias2/rabat@ensias2 
create type_operation_2
using select *
from TYPE_OPERATION;

copy to ensias2/rabat@ensias2 
create type_compte_2
using select *
from TYPE_COMPTE;


create table compte_1 as select no ,type_compte_no,dateOuverture ,decouvert
_autorise, solde,client_no,agence_no from compte where client_no in(select no fr
om client where ville='Casablanca') ;