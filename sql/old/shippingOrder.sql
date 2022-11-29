CREATE
    DEFINER = `‘root‘`@`‘localhost‘` PROCEDURE `shipping_order`(in name varchar(36))
BEGIN
    declare
        c int;
    select count(Customers.id)
    into c
    from Customers
    where Customers.fullName = name;
    if
        (c = 0) then
        signal sqlstate '45000'
            set message_text = 'Member does not exist';
    end if;

#lay danh sach order dang o trang thai shipping cua 1 nguoi co name(input)
    select *
    from `Order`
    where customer_id in (select id from Customer where Customer.name = name)
      and state = 'SHIPPING'
    order by ID;
END