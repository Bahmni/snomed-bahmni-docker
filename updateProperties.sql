use openmrs;
update idgen_seq_id_gen set max_length = 14 where prefix != 'NAT';
update concept set is_set = 1 where concept_id = (select concept_id from concept_name where name="Procedure Orders" and locale="en" and concept_name_type = "FULLY_SPECIFIED");
update drug set retired = 1, retire_reason="Not needed" where date_created < "2023-10-24 14:53:06";
select user_id INTO @user_id from users where username = 'registration';
INSERT INTO user_role (user_id, role) VALUES (@user_id, 'FrontDesk');
select user_id INTO @user_id_doctor from users where username = 'dr_neha';
INSERT INTO user_role (user_id, role) VALUES (@user_id_doctor, 'Doctor');