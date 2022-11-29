CREATE
    DEFINER = `root`@`localhost` PROCEDURE `checkOrders`(in Cname varchar(255), Cphone varchar(255))
BEGIN
    declare c int;
    select count(orders.receiver_name)
    into c
    from orders
    where orders.receiver_name = Cname;

# kiem tra xem co ten tim kiem co dung khong
    if (Cname = '') then
        signal sqlstate '45000'
            set message_text = "Lỗi nhập không có tên";
    end if;
    if
        (c = 0) then
        signal sqlstate '45000'
            set message_text = "Khách hàng không tồn tại";
    end if;
-- check phonenumber
    if
        (regexp_like(Cphone, '^[[:digit:]]{10}$') = 0) then
        signal sqlstate '45000'
            set message_text = "So dien thoai khong hop le";
    end if;
-- lay cai orderID ung voi ten input
    Create table Mem_order
    select orders.id as memorders_id, receiver_name, phone_number, orders.customer_id as customer_id -- select phone
    from orders
    where orders.receiver_name = Cname
      and orders.phone_number = Cphone
      and orders.state = 'DONE'
    order by orders.customer_id;

-- Tao bang tham khao san pham va gia
    Create table Detail_Order
    select distinct Mem_order.memorders_id as order_id,
                    orders.customer_id     as customer_id,
                    orderbook.quantity     as order_quantity,
                    orderbook.price        as order_price,
                    book.name              as Pname
    from Mem_order,
         orderbook,
         book,
         orders
    where Mem_order.memorders_id = orderbook.order_id
      and orderbook.book_id = book.id
      and mem_order.customer_id = orders.customer_id;

-- Tao bang tinh toan
    Create table Sum_Detail_Order
    select order_id, customer_id, sum(order_quantity) as TongSL, sum(order_price) as TongGia
    from detail_order;
-- lay cac thuoc tinh khach hang, tong so sach, tong gia ung va tong don hang voi customer do.
    select distinct sum_detail_order.customer_id  as CustomerId,
                    mem_order.receiver_name       as Name,
                    mem_order.phone_number        as Phone,
                    sum_detail_order.TongSL       as Totalbook,
                    sum_detail_order.TongGia      as Totalprice,
                    count(mem_order.memorders_id) as TongDon
    from sum_detail_order,
         mem_order
    where sum_detail_order.customer_id = mem_order.customer_id
    group by sum_detail_order.customer_id #chi lay tong so sach tren num(input)
    having TongDon > 1
    order by TongDon;
    drop table mem_order;
    drop table detail_order;
    drop table sum_detail_order;
END