drop table has_ability;
drop table team_comments;
drop table personal_comments;
drop table personal_introduction;
drop table team_finder;
drop table user_table;
drop table team;
--create table
BEGIN TRANSACTION;
create table user_table
(
    user_account_name varchar(25),
    user_id Serial,
    password varchar(20) not NULL,
    realname character varying(30) NOT NULL,
    gender character varying(12) NOT NULL,
    college character varying(20) NOT NULL,
    major character varying(20) NOT NULL,
    grade character varying(5) NOT NULL,
    academic_background character varying(8) NOT NULL
    primary key (user_account_name)
);

create table personal_introduction
(
    user_account_name varchar(25),
    email character varying(30) NOT NULL,
    qq character varying(20) NOT NULL,
    introduction text NOT NULL,
    primary key (user_account_name),
    foreign key (user_account_name) references user_table
);

create table team_finder
(
    user_account_name varchar(25),
    primary key (user_account_name),
    foreign key (user_account_name) references user_table
);

create table team(
    team_id SERIAL,
    team_name varchar(100),
    owner_user_account character varying(25),
    competition_name varchar(255) NOT NULL,
    email character varying(30) NOT NULL,
    qq character varying(20),
    team_introduction text,
    primary key (team_id),
    foreign key (owner_user_account) references user_table
);

create table comments(
    comment_id SERIAL,
    sent_user_account_name varchar(25),
    sent_time timestamp,
    content text,
    primary key (comment_id),
    foreign key (sent_user_account_name) references user_table
);

create table has_ability
(
    user_account_name varchar(25),
    ability_name varchar(255),
    primary key (user_account_name,ability_name),
    foreign key (user_account_name) references user_table
);
create table team_comments_relations(
    comment_id integer, 
    team_id integer,
    primary key (comment_id),
    foreign key (team_id) references team,
    foreign key (comment_id) references comments
);
create table personal_comments_relations(
    comment_id integer,
    user_account_name integer,
    primary key (comment_id),
    foreign key (user_account_name) references user_table,
    foreign key (comment_id) references comments
);

create table team_comments
(
    comment_id SERIAL,
    team_id integer,
    sent_user_account_name varchar(25),
    sent_time timestamp,
    content text,
    primary key(comment_id),
    foreign key(team_id) references team,
    foreign key(sent_user_account_name) references user_table
);

create table personal_comments
(
    comment_id SERIAL,
    master_account_name varchar(25),
    sent_user_account_name varchar(25),
    sent_time timestamp,
    content text,
    primary key(comment_id),
    foreign key(master_account_name) references user_table,
    foreign key(sent_user_account_name) references user_table
);

COMMIT;


