
create database trigger_lab;
use trigger_lab;

create table staff (
  staff_id int primary key,
  staff_name varchar(50),
  salary decimal(10,2)
);

create table staff_log (
  log_id int auto_increment primary key,
  staff_id int,
  action varchar(50),
  log_time timestamp default current_timestamp
);

insert into staff (staff_id, staff_name, salary)
values
(101, 'Arjun', 55000.00),
(102, 'Meera', 68000.00),
(103, 'Vikas', 47000.00),
(104, 'Pooja', 75000.00);

-- 1. Trigger to Log Insert Activity
Delimiter //
create trigger trg_after_insert_staff
after insert on staff
for each row
begin
insert into staff_log(staff_id, action)
values (NEW.staff_id, 'Staff Inserted');
end //
Delimiter ;

insert into staff values (105, 'Rakesh', 52000);

-- 2. Trigger to Log Staff Delete
Delimiter //
create trigger trg_after_delete_staff
after delete on staff
for each row
begin
insert into staff_log(staff_id, action)
values (OLD.staff_id, 'Staff Deleted');
end //
Delimiter ;

delete from staff where staff_id = 101;

-- 3. Trigger to Log Salary Update
Delimiter //
create trigger trg_after_salary_update
after update on staff
for each row
begin
if OLD.salary <> NEW.salary then
   insert into staff_log(staff_id, action)
   values (NEW.staff_id, 'Salary Updated');
end if;
end //
Delimiter ;

set sql_safe_updates = 0;

update staff
set salary = 72000
where staff_id = 102;

-- 4. Trigger to Prevent Negative Salary
Delimiter //
create trigger trg_before_insert_salary
before insert on staff
for each row
begin
if NEW.salary < 0 then
   signal sqlstate '45000'
   set message_text = 'Salary cannot be negative';
end if;
end //
Delimiter ;

insert into staff values (106, 'Anjali', -3000);

-- 5. Trigger to Automatically Increase Salary by 10%
Delimiter //
create trigger trg_before_insert_bonus
before insert on staff
for each row
begin
set NEW.salary = NEW.salary * 1.10;
end //
Delimiter ;

insert into staff values (107, 'Deepak', 45000);

-- 6. Trigger to Store Old and New Salary Change
Delimiter //
create trigger trg_salary_change
after update on staff
for each row
begin
if OLD.salary <> NEW.salary then
   insert into staff_log(staff_id, action)
   values (
      NEW.staff_id,
      concat('Salary changed from ',
             OLD.salary,
             ' to ',
             NEW.salary));
end if;
end //
Delimiter ;

update staff
set salary = 80000
where staff_id = 103;

-- 7. Trigger to Convert Staff Name to Uppercase
Delimiter //
create trigger trg_uppercase_name
before insert on staff
for each row
begin
set NEW.staff_name = upper(NEW.staff_name);
end //
Delimiter ;

insert into staff values (108, 'sachin', 35000);

-- 8. Trigger to Restrict Salary Reduction
Delimiter //
create trigger trg_prevent_salary_reduce
before update on staff
for each row
begin
if NEW.salary < OLD.salary then
   signal sqlstate '45000'
   set message_text = 'Salary reduction not allowed';
end if;
end //
Delimiter ;

update staff
set salary = 40000
where staff_id = 102;

-- 9. Trigger to Log Name Changes
Delimiter //
create trigger trg_name_change
after update on staff
for each row
begin
if OLD.staff_name <> NEW.staff_name then
   insert into staff_log(staff_id, action)
   values (NEW.staff_id, 'Staff Name Changed');
end if;
end //
Delimiter ;

update staff
set staff_name = 'Nikita'
where staff_id = 104;

-- 10. Trigger to Prevent Empty Staff Name
Delimiter //
create trigger trg_no_empty_name
before insert on staff
for each row
begin
if NEW.staff_name = '' then
   signal sqlstate '45000'
   set message_text = 'Staff name cannot be empty';
end if;
end //
Delimiter ;

insert into staff values (109, '', 42000);

-- 11. Trigger to Log High Salary Staff
Delimiter //
create trigger trg_high_salary
after insert on staff
for each row
begin
if NEW.salary > 90000 then
   insert into staff_log(staff_id, action)
   values (NEW.staff_id, 'High Salary Staff Added');
end if;
end //
Delimiter ;

insert into staff values (110, 'Mohit', 95000);

-- 12. Trigger to Set Default Salary
Delimiter //
create trigger trg_default_salary
before insert on staff
for each row
begin
if NEW.salary is null then
   set NEW.salary = 30000;
end if;
end //
Delimiter ;

insert into staff(staff_id, staff_name)
values (111, 'Sneha');

-- 13. Trigger to Prevent Duplicate Staff Name
Delimiter //
create trigger trg_duplicate_name
before insert on staff
for each row
begin
if exists (
   select * from staff
   where staff_name = NEW.staff_name
) then
   signal sqlstate '45000'
   set message_text = 'Staff name already exists';
end if;
end //
Delimiter ;

insert into staff values (112, 'Arjun', 50000);

-- 14. Trigger to Add Welcome Message
Delimiter //
create trigger trg_join_message
after insert on staff
for each row
begin
insert into staff_log(staff_id, action)
values (NEW.staff_id, 'Welcome New Staff');
end //
Delimiter ;

insert into staff values (113, 'Kunal', 48000);

-- 15. Trigger to Add Bonus Salary on Update
Delimiter //
create trigger trg_bonus_salary
before update on staff
for each row
begin
if OLD.salary <> NEW.salary then
   set NEW.salary = NEW.salary + 1500;
end if;
end //
Delimiter ;

update staff
set salary = 85000
where staff_id = 102;
```
