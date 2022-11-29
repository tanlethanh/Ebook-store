CREATE
    DEFINER = `root`@`localhost` FUNCTION `caculate_state`(BookID varchar(36)) RETURNS varchar(36) CHARSET utf8mb4
    DETERMINISTIC
    BEGIN
        #tinh trang thai cua sach - het hang - sap het hang - co hang - dau vao book id
        declare result varchar(36);
        declare quantity int;
        if not exists(select Book.id from Book where Book.id = BookID) then
            signal sqlstate '45000' set message_text = 'Book not exist';
        end if;
        set quantity = (select Book.quantity from Book where Book.id = BookID);
        if (quantity = 0) then
            set result = 'Out of stock';
        elseif (quantity < 10) then
            set result = 'Run low';
        else
            set result = 'Full';
        end if;
        RETURN result;
    END

