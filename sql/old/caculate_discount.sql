CREATE
    DEFINER = `root`@`localhost` FUNCTION `caculate_discount`(
    price int,
    voucherID varchar(36)
) RETURNS int
    DETERMINISTIC
BEGIN
    #tinh discount, dau vao tong order va voucherid
    declare
        result int;
    declare
        max_discount float;

    if
        not exists(select Voucher.id from Voucher where Voucher.id = voucherID) then
        signal sqlstate '45000'
            set message_text = "Voucher not exist";
    end if;

    set
        max_discount = (select Voucher.max_reduced_money from Voucher where Voucher.id = voucherID);
    set
        result = (price * (select Voucher.discount from Voucher where Voucher.id = voucherID)) / 100;
    if
        (result > max_discount) then
        set result = max_discount;
    end if;
    return result;
END