-- Sample Data
use ebook_store;

insert into Customers values('1', 'Manh', 'Thanh pho Thu Duc', '0949911677', 'manhhonguyen@gmail.com');
insert into Customers values('2', 'Hung', 'Q1',  '0946911655', 'hungthinh@gmail.com');
insert into Customers values('3', 'Phuc', 'Q1',  '01896327432', 'phuccaro@gmail.com');
insert into Customers values('4', 'Vy', 'Quan Tan Binh', '03667669415', 'vy123@gmail.com');
insert into Customers values('5', 'Huong', 'Quan Binh Chanh', '03440568890', 'huongle@gmail.com');
insert into Customers values('6', 'Thinh', 'Quan Tan Phu', '0978855111', 'thinhtu55@gmail.com');

insert into Users(id, username, password) values('1','vykhongdanghi', 'vynguyen4533');
insert into Users(id, username, password) values('2','huongkhongkhoi', 'huongkhoivabatnhang');
insert into Users(id, username, password) values('3','hungthinh11', 'vozerchinhhieu@14');

insert into MemberCustomers
	values('1', STR_TO_DATE('01-05-2018', '%d-%m-%Y'), 0,  'female', '4');
insert into MemberCustomers
	values('2', STR_TO_DATE('01-01-2020', '%d-%m-%Y'), 10, 'female', '5');
insert into MemberCustomers
	values('3', STR_TO_DATE('05-03-2019', '%d-%m-%Y'), 20, 'male', '6');
    
insert into Suppliers
	values('1', 'Google', 'Chuyen cung cap cac dau sach chat luong', 'google.com.vn');
    

insert into Books (id, price, discount, author, name, description, quantity, rating)
	values('1', 80000, 0, 'Nam Cao', 'Lao Hac', 'Lao Hac va Cau Vang', 20, 0);
insert into Books (id, price, discount, author, name, description, quantity, rating)
	values('2', 90000, 0.2, 'Kim Lan', 'Lang', 'Ong Hai va cau chuyen hieu lam thu vi', 50, 0);
insert into Books (id, price, discount, author, name, description, quantity, rating)
	values('3', 85000, 0, 'Thach Lam', 'Hai dua tre', 'Hai dua tre va giac mo anh sang', 90, 0);

insert into Orders (id, begin_shipment_date, state, receiver_name, phone_number, address, total_cost, total_price)
	values('1', STR_TO_DATE('11-09-2022', '%d-%m-%Y'), 'SHIPPING', 'Huong', '0976851127', 'Quan 10', 100000, 100000);
insert into Orders (id, begin_shipment_date, state, receiver_name, phone_number, address, total_cost, total_price)
	values('2', STR_TO_DATE('11-09-2022', '%d-%m-%Y'), 'INIT', 'Tien', '0976843321',  'Quan 12', 300000, 300000);

-- Trigger
-- Không được xoá đơn hàng có trạng thái shipping
DROP TRIGGER IF EXISTS beforeRemoveOrder;
DELIMITER $$  
CREATE TRIGGER beforeRemoveOrder  
BEFORE DELETE ON Orders FOR EACH ROW  
BEGIN  
    DECLARE state VARCHAR(255);
    IF old.state = 'SHIPPING' THEN
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = 'Cannot remove order that is being shipped!!';  
    END IF;  
END $$ 
-- Test case
DELETE FROM Orders WHERE id = '1';

-- Tính toán lại rating khi có khách hàng để lại bình luận mới
DROP TRIGGER IF EXISTS calculateRating;
DELIMITER $$  
CREATE TRIGGER calculateRating  
AFTER INSERT ON Comments FOR EACH ROW
BEGIN  
    DECLARE finalScore INT DEFAULT 0;
    DECLARE count INT DEFAULT 0;
    SELECT SUM(score) INTO finalScore FROM Comments WHERE id = NEW.bookId;
    SELECT COUNT(score) INTO count FROM Comments WHERE id = NEW.bookId;
    UPDATE Books
    SET rating = finalScore / count
    WHERE id = NEW.bookId;
END $$ 
-- Test case
delete from Comments where userid != -10;
insert into Comments (id, content, score, userId, bookId)
	values ('1', 'Lorem Ipsum sit amet', 4, '1', '1');
insert into Comments (id, content, score, userId, bookId)
	values ('2', 'Lorem Ipsum sit amet', 3, '2', '2');
insert into Comments (id, content, score, userId, bookId)
	values ('3', 'Lorem Ipsum sit amet', 3, '3', '2');
select * from Comments;
select * from Books;


