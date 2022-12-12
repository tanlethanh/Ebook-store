use ebook_store;

INSERT INTO Address (id, province, district, wards, country, home)
VALUES ('abcz', 'TPHCM', 'Thu Duc', 'Linh Trung', 'VN', 'KTX khu A');

INSERT INTO Orders (id, init_date, state, receiver_name, phone_number, total_price, total_discount, shipment_cost, address_id) 
VALUES ('obcz', '2022-12-01', 'SHIPPING', 'Manh', '012345678', 110000, 0, 10000, 'abcz');

INSERT INTO OrderBooks (order_id, book_id, quantity, price, discount)
VALUES ('obcz', '4a54c7cc-72dc-11ed-b98a-04229dac88a3', 2, 50000, 0);

-- Toi thay hoa vang tren co xanh
DELETE FROM Books WHERE id='4a54c7cc-72dc-11ed-b98a-04229dac88a3'
AND id NOT IN 
	(SELECT ob.book_id 
    FROM OrderBooks AS ob, Orders AS o
    WHERE o.id = ob.order_id 
    AND (o.state='INIT' OR o.state='CONFIRM' OR o.state='SHIPPING'));
    
SELECT * FROM Books WHERE id='4a54c7cc-72dc-11ed-b98a-04229dac88a3';