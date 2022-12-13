const express = require('express')
const database = require('./connection')

exports.createNewOrder = (listId, listQuantity, userId) => {
    return new Promise((resolve, reject) => {

        const listIdStr = listId.join('|')
        const listQuantityStr = listQuantity.join('|')

        database.query(`call create_new_order('${listIdStr}', '${listQuantityStr}', '${userId}', @ORDER_ID); select @ORDER_ID as order_id;`,
            ['result', 'orderId'],
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve(results[1][0].order_id)
            }
        );
    });
}

exports.getOrderById = (orderId) => {
    return new Promise((resolve, reject) => {
        database.query(`select o.id as id,
                            o.state as state,
                            u.name as name, 
                            u.phone_number as phone_number, 
                            u.email as email, 
                            get_total_price(o.id) as total_price 
                        from orders as o
                        left join users as u on u.id = o.user_id 
                        where o.id = '${orderId}'; 
                        select b.name as book_name, 
                            b.main_image_url as book_image, 
                            ob.discount as discount, 
                            ob.quantity as quantity, 
                            ob.price as price,
                            (ob.price * (1 - ob.discount)) as discount_price
                        from orders as o
                        join orderbooks as ob on o.id = ob.order_id
                        join books as b on b.id = ob.book_id
                        where o.id = '${orderId}';
                        `,
            [1, 2],
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                console.log(results)
                const obj = results[0][0]
                obj.listItems = results[1]
                resolve(obj)
            }
        );
    });
}