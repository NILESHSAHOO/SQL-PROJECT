create database Bankdatabase;
use Bankdatabase;
create table Bank(B_id int primary key,B_name varchar(30) not null,B_hq varchar(30));
insert into Bank value(2321,'SBI','BALASORE'),(4345,'BOI','BALASORE'),(5423,'PNB','BALASORE');
create table Branch(BR_id int primary key,Address varchar(30),B_id int,foreign key(B_id) references Bank(B_id));
insert into Branch values(123,'Soro,Balasore',5423);
insert into Branch values(456,'Ananta pur,Balasore',4345),(789,'Gopal pur,Balasore',2321);
create table Customer1(C_id int primary key,C_name varchar(30),Email varchar(30),Gender varchar(5),DOB date,Address varchar(30));
select * from Customer1;
insert into Customer1 values(1234,'Bikash','bikash@gmail.com','male','2000-5-20','Madhusudan pur,soro'),
																				(4321,'Nitya','nitya@gmail.com','male','2002-4-28','Meghamadhaba,soro'),
																								(5678,'Balia','balia@gmail.com','male','2003-8-20','Uttareswar,soro');
create table Account(Acc_no int primary key,Acc_type varchar(10),BR_id int,foreign key(BR_id)references Branch(BR_id));
insert into Account values(503097,'Saving ac',456),(673402,'Current ac',123),(642310,'salary ac',789);
create table Loan(L_id int primary key,L_type varchar(30),L_intrest int,BR_id int,foreign key(BR_id) references Branch(BR_id));
insert into Loan values(6732,'Home Loan',3,789),(3472,'Study loan',2,456),(6832,'Home Loan',4,123);
create table Branch_phno(BR_id int,foreign key(BR_id) references Branch(BR_id),ph_no bigint );
insert into Branch_phno values(123,8965382542),(123,9864386292),(789,6743210945),(789,6754320949),(456,9054327809),(456,7894585378);
create table Cust_phno(c_id int,foreign key(c_id) references customer1(C_id),ph_no bigint);
insert into Cust_phno values(1234,8926219266),(4321,9065324901),(5678,7834562932);
create table Cust_acc_details(Acc_no int,foreign key(Acc_no) references Account(Acc_no),C_id int,foreign key(C_id) references Customer1(C_id));
insert into Cust_acc_details values(503097,1234),(673402,4321),(642310,5678);
create table Loan_acc_details(Acc_no int,foreign key(Acc_no) references Account(Acc_no),L_id int,foreign key(L_id) references Loan(L_id));
insert into Loan_acc_details values(503097,6732),(673402,3472),(642310,6832);



#Q1
select * from Loan where Br_id in
(select Br_id from branch where Br_id in
(select Br_id from account where Acc_no in
(select Acc_no from cust_acc_details where c_id in
(select c_id from customer1 where c_id=1234))));

#Q2
select * from customer1 where C_name like "n%";

#Q3
select * from Customer1 where gender="male";

#Q4
select c.C_name,cu.Acc_no,a.acc_type from 
Customer1 c join cust_acc_details cu on c.C_id=cu.C_id
join account a on a.Acc_no=cu.Acc_no;

#Q5
select Acc_no,BR_id from account where BR_id in
(select BR_id from branch where B_id in
(select B_id from Bank where B_name="SBI"));

#Q6
select * from customer1 where c_id in
(select C_id from cust_acc_details where Acc_no in
(select Acc_no from account where Acc_no in
(select Acc_no from loan_acc_details where L_id in
(select L_id from Loan where L_type="Study Loan"))));

#Q7
select l.L_type,l.L_intrest,lo.Acc_no,c.C_id from 
Loan l join Loan_acc_details lo on l.L_id=lo.L_id
join account a on a.Acc_no=lo.Acc_no
join cust_acc_details cu on cu.Acc_no=a.Acc_no
join customer1 c on c.C_id=cu.C_id;

#Q8




