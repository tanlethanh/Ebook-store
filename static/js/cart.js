import NotificationQueue from "./notify.js";


const listDeleteButton = document.querySelectorAll('.buttons .delete-btn')
const listAddToCartButton = document.querySelectorAll('.add-to-cart-btn')
const listCheckbox = document.querySelectorAll(".bagInput")
const listItems = document.querySelectorAll(".item")
const chooseAllCheckbox = document.querySelector("#headerCheckBox")
const paybutton = document.querySelector("#paybutton")

// Example POST method implementation:
async function postData(url = '', data = {}) {
    // Default options are marked with *
    const response = await fetch(url, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
            'Content-Type': 'application/json'
            // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        redirect: 'follow', // manual, *follow, error
        referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        body: JSON.stringify(data) // body data type must match "Content-Type" header
    });
    return response.json(); // parses JSON response into native JavaScript objects
}

async function addToCart(e) {
    console.log('Add to cart')
    const bookId = e.target.closest(".showcase").id
    console.log(bookId)
    const res = await postData('/api/cart', {
        "bookId": bookId
    })

    if (res.type == 'success') {
        NotificationQueue.enqueue({
            status: res.type,
            title: 'Thêm vào giỏ hàng',
            text: 'Đã thêm vào giỏ hàng, vui lòng kiểm tra!',
        })

    }
    else {
        NotificationQueue.enqueue({
            status: res.type,
            title: 'Thêm vào giỏ hàng',
            text: res.message,
        })
        console.log(res.message)
    }
    console.log(res)

}

async function deleteCartItem(e) {
    console.log('Add to cart')
    const bookId = e.target.closest(".item").id
    console.log(bookId)
    const res = await postData('/api/cart/item', {
        action: 'DELETE',
        cartId: String(window.location.pathname).split('/')[2],
        bookId: bookId
    })

    if (res.type == 'success') {
        NotificationQueue.enqueue({
            status: 'success',
            title: 'Xóa khỏi giỏ hàng',
            text: 'Xóa thành công',
            callback: () => {
                setTimeout(() => {
                    window.location.reload(true)
                }, 1000)
            }
        })
    }
    else {
        NotificationQueue.enqueue({
            status: 'error',
            title: 'Xóa khỏi giỏ hàng',
            text: res.message,
            callback: () => {
                setTimeout(() => {
                    window.location.reload(true)
                }, 1000)
            }
        })
        console.log(res.message)
    }
}


function updateTotalPrice() {
    let totalPrice = 0
    for (let i = 0; i < listItems.length; i++) {
        const ele = listItems[i]
        const cb = ele.querySelector(".bagInput")
        if (cb.checked == true) {
            const price = Number(ele.querySelector(".total-price").innerText.replace('đ', ''))
            totalPrice += price
        }
    }

    const totalPriceEle = document.querySelector("#total_price")
    totalPriceEle.innerText = String(totalPrice)
}


async function makeOrder() {
    let count = 0
    let listChosenItems = []
    for (let i = 0; i < listCheckbox.length; i++) {
        if (listCheckbox[i].checked) {
            count++
            listChosenItems.push({
                id: listCheckbox[i].closest(".item").id,
                quantity: Number(listCheckbox[i].closest(".item").querySelector(".quantity input").getAttribute("value"))
            })
        }
    }

    if (count == 0) {

    }
    else {

        const res = await postData("/api/order", {
            listItems: listChosenItems
        })

        console.log(res)

        if (res.orderId) {
            window.location.replace(`/order/${res.orderId}`)
        }
    }

}



for (let i = 0; i < listDeleteButton.length; i++) {
    listDeleteButton[i].addEventListener('click', deleteCartItem)
}

for (let i = 0; i < listAddToCartButton.length; i++) {
    listAddToCartButton[i].addEventListener('click', addToCart)
}

for (let i = 0; i < listCheckbox.length; i++) {
    listCheckbox[i].addEventListener('click', updateTotalPrice)
}

// choose all checked
chooseAllCheckbox.addEventListener('click', () => {
    for (let i = 0; i < listCheckbox.length; i++) {
        listCheckbox[i].checked = chooseAllCheckbox.checked
    }
    updateTotalPrice()
})

paybutton.addEventListener('click', makeOrder)



