Drop database tei_xml_db;
Create  database if not exists tei_xml_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

use tei_xml_db;

create table entry(
entry_id int auto_increment,
id varchar(200) not null,
lang varchar(200),
primary key (entry_id)
);


create table form(
form_id int auto_increment,
type varchar(200),
n int,
entry_id int,
primary key (form_id),
foreign key(entry_id) references entry(entry_id)
);

create table orth(
orth_id int auto_increment,
type varchar(200),
orth varchar(20),
form_id int,
primary key (orth_id),
foreign key(form_id) references form(form_id)
);


create table grammar_group(
grammar_group_id int auto_increment,
gram varchar(200),
pos varchar(100),
entry_id int,
primary key (grammar_group_id),
foreign key(entry_id) references entry(entry_id)
);


create table form_grammar_group(
form_grammar_group_id int auto_increment,
gram varchar(200),
form_id int,
primary key (form_grammar_group_id),
foreign key(form_id) references form(form_id)
);

create table pronunciation(
pronunciation_id int auto_increment,
notation varchar(200),
resp varchar(200),
changes varchar(200),
pron varchar(200),
form_id int,
primary key (pronunciation_id),
foreign key(form_id) references form(form_id)
);

create table sense(
sense_id int auto_increment,
corresp varchar(200),
entry_id int,
primary key (sense_id),
foreign key(entry_id) references entry(entry_id)
);

create table sense_definition(
sense_definition_id int auto_increment,
sense_def_lang varchar(200),
sense_def_corresp varchar(200),
sense_definition varchar(500),
sense_id int,
primary key (sense_definition_id),
foreign key(sense_id) references sense(sense_id)
);

create table reference(
reference_id int auto_increment,
type varchar(200),
ref varchar(200),
ref_date varchar(200),
entry_id int,
primary key (reference_id),
foreign key(entry_id) references entry(entry_id)
);

create table bibliography(
bibliography_id int auto_increment,
type varchar(200),
bibl varchar(200),
ref_date varchar(200),
reference_id int,
primary key (bibliography_id),
foreign key(reference_id) references  reference(reference_id)
);

create table note(
note_id int auto_increment,
type varchar(200),
resp varchar(200),
corresp varchar(200),
note varchar(200),
entry_id int,
primary key (note_id),
foreign key(entry_id) references entry(entry_id)
);


create table citation(
citation_id int auto_increment,
type varchar(200),
n  int,
entry_id int,
primary key (citation_id),
foreign key(entry_id) references entry(entry_id)
);

create table citation_definition(
citation_definition_id int auto_increment,
citation_def_lang varchar(200),
citation_def_corresp varchar(200),
citation_definition varchar(200),
citation_id int,
primary key (citation_definition_id),
foreign key(citation_id) references citation(citation_id)
);

create table citation_quote(
citation_quote_id int auto_increment,
resp varchar(200),
changes varchar(200),
quote varchar(200),
citation_id int,
primary key (citation_quote_id),
foreign key(citation_id) references citation(citation_id)
);



create table entry_usage (
usage_id int auto_increment,
usage_type varchar(200),
usage_corresp varchar(200),
usage_place_name varchar(200),
usage_place_type varchar(200),
entry_id int,
primary key (usage_id),
foreign key(entry_id) references entry(entry_id)
);

create table place(
place_id int auto_increment,
list_place_ref varchar(200),
place_type varchar(200),
place_name varchar(200),
place_id_no varchar(200),
usage_id int,
primary key (place_id),
foreign key(usage_id) references entry_usage(usage_id)
);






