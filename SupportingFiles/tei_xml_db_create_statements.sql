Drop database tei_xml_db_test;
Create  database if not exists tei_xml_db_test
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

use tei_xml_db_test;

create table entry(
entry_id int auto_increment,
id varchar(200) not null,
lang varchar(200),
primary key (entry_id)
);

#Maps to a form (ontolex:cannonicalForm, otherForm etc)
create table form(
form_id int auto_increment,
type varchar(200),
n int,
entry_id int,
primary key (form_id),
foreign key(entry_id) references entry(entry_id)
);
#maps to a writtenRep
create table orth(
orth_id int auto_increment,
type varchar(200),
orth varchar(200),
form_id int,
primary key (orth_id),
foreign key(form_id) references form(form_id)
);

#maps to lexinfo:partOfSpeech lexinfo:noun,verb etc
create table grammar_group(
grammar_group_id int auto_increment,
gram varchar(200),
pos varchar(200),
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
#Maps to ontolex:phoneticRep @en-US-fonipa or @en-GB-fonipa or
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
# maps to ontolex:LexicalSense via ontolex:sense
create table sense(
sense_id int auto_increment,
corresp varchar(200),
entry_id int,
primary key (sense_id),
foreign key(entry_id) references entry(entry_id)
);

#can be mapped to skos:definition of the sense
create table sense_definition(
sense_definition_id int auto_increment,
sense_def_lang varchar(200),
sense_def_corresp varchar(200),
sense_definition varchar(500),
sense_id int,
primary key (sense_definition_id),
foreign key(sense_id) references sense(sense_id)
);

#maps to onotlex: reference
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

create table etymology(
etym_id int auto_increment,
resp varchar(200),
corresp varchar(200),
text TINYTEXT,
entry_id int,
primary key (etym_id),
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


#maps to ontolex:usage check link with sense or lexical entry
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


create table question_entry(
entry_id int,
questionnaire_no varchar(200),
question_no varchar(200),
question TINYTEXT,
primary key (entry_id)
);

Create index pos_gram_grp on
grammar_group (pos);

Create index ref_type on
reference (type);

Create index form_type on
form (type);

Create index orth_type on
orth (type);

Create index grammar_group_pos on
grammar_group (pos);






