alter table client_2 add constraint client2_pk primary key (no);
alter table operation_2 add constraint operation2_pk primary key (no);
alter table compte_2 add constraint compte2_pk primary key (no);
alter table type_operation_2 add constraint type_operation2_pk primary key (no);
alter table type_compte_2 add constraint type_compte2_pk primary key (no);
alter table compte_2 add constraint type_compte2_fk foreign key (type_compte_no) references type_compte_2(no);
alter table compte_2 add constraint client2_fk foreign key (client_no) references client_2(no);
alter table operation_2 add constraint type_operation2_fk foreign key (type_operation_no) references type_operation_2(no);