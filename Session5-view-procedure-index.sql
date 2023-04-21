-- tạo chỉ mục cho 2 trường của bảng order_detail
create unique index id_product_name
on order_detail(productName,id);

-- hàm thêm mới bản ghi vào task
delimiter //
create procedure PROC_CreateNewTask(in newId int,in newName varchar(255),out result varchar(255))
begin
	insert into task values(newId,newName);
end
// delimiter ;

-- gọi thủ tục để thêm mới bản ghi
call PROC_CreateNewTask(10,"không đi học",@rs);
select @rs;

alter table task 
add column status bit ;
-- nếu dữ liệu nhập vào là active thì status = 1 ,
delimiter //
create procedure PROC_CreateNewTaskAll(in newId int,in newName varchar(255),newStatus varchar(10))
begin
	 set @sta = 0 ;
     if newStatus like "active" then set @sta = 1; end if;
	insert into task values(newId,newName,@sta);
end; 
// delimiter ;

-- thêm mới dữ liệu 
call PROC_CreateNewTaskAll(11,"ngủ","active");
call PROC_CreateNewTaskAll(12,"ngủ nướng","inactive");

SELECT id, `name`, (case when `status` = 1 then "nam" else "nữ" end) as sex FROM quanlybanhang_demo.task;
-- tạo view;
create view VIEW_OrderWithUsername AS Select u.fullname,u.username,o.* from `user` u join `order` o on u.id=o.user_id;  
select * from view_orderwithusername;
-- xoá view
drop view view_orderwithusername;
-- xoá thủ tục
drop procedure PROC_CreateNewTaskAll;

-- check option
create view VIEW_DEMO as SELECT * from task where `status` <> 0 with check option;
select * from view_demo;
update view_demo set `status` = 0 where id = 12;
delete from view_demo where id =12;
