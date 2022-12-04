let checkBoxs = document.querySelectorAll(".checkbox>input");
var totalPrice = document.getElementById("total_price");
var addedItems = new Map();


// code javascript cho nút checkbox
[...checkBoxs].forEach((checkbox) => {
    checkbox.addEventListener("change", (e) => {
        if (e.target.checked) {
          let item = checkbox.parentElement.parentElement;
          let id = (item.id)
          let price = parseInt((item.getElementsByClassName("total-price")[0].innerHTML).replace("$",""));
          let quantity = parseInt(item.getElementsByClassName("quantity")[0].children[1].value);
          addedItems.set(id,quantity);
          totalPrice.innerHTML = parseInt(totalPrice.innerHTML) + price*quantity;

        } else {
          let item = checkbox.parentElement.parentElement;
          let id = (item.id);
          let price = parseInt((item.getElementsByClassName("total-price")[0].innerHTML).replace("$",""));
          let quantity = parseInt(item.getElementsByClassName("quantity")[0].children[1].value);
          var old_quantity =addedItems.get(id)
          addedItems.delete(id)
          totalPrice.innerHTML = parseInt(totalPrice.innerHTML) - price*old_quantity;
        }
      })
});
//code cho nut chon tat ca
var allCheckBox = document.getElementById("headerCheckBox");
allCheckBox.addEventListener("change", e=>{
    if (e.target.checked) {
    let checkBoxs = document.querySelectorAll(".checkbox>input");
        [...checkBoxs].forEach(checkBox=>{
            checkBox.checked = true;
            checkBox.dispatchEvent(new Event("change"))
        })
    }
    else{
        let checkBoxs = document.querySelectorAll(".checkbox>input");
            [...checkBoxs].forEach(checkBox=>{
                checkBox.checked = false;
                checkBox.dispatchEvent(new Event("change"))
            })
            totalPrice.innerHTML = 0;
            addedItems = new Map();
    }
}
)

// code javascript cho nút xóa
var DeleteIcns = document.getElementsByClassName("buttons");
[...DeleteIcns].forEach(deleIcn=>{
    deleIcn.addEventListener("click",e=>{
        let item = deleIcn.parentElement;
        let id = (item.id);
          let price = parseInt((item.getElementsByClassName("total-price")[0].innerHTML).replace("$",""));
          var old_quantity =addedItems.get(id)
          if(old_quantity){
          totalPrice.innerHTML = parseInt(totalPrice.innerHTML) - price*old_quantity;
        }
        item.remove();
        updateNum();
    })
})

function updateNum() {   
    let Items = document.getElementsByClassName("item");
    let iteNum = Items.length;
    document.getElementById("num-items-checkbox").innerHTML= Items.length;
}

//code javascript cho nút tăng số lượng
var MinusButons = document.getElementsByClassName("minus-btn");
[...MinusButons].forEach(Minusbtn=>{
    Minusbtn.addEventListener("click",e=>{
        let item = Minusbtn.parentElement.parentElement;
        let id = item.id;
        let price = parseInt((item.getElementsByClassName("total-price")[0].innerHTML).replace("$",""));
        var old_quantity =addedItems.get(id);
        if(old_quantity!=undefined){
            addedItems.set(id,(old_quantity>=1)? (old_quantity-1):0);
            totalPrice.innerHTML = parseInt(totalPrice.innerHTML) - price*old_quantity + price*addedItems.get(id);
        }
    })
})
//code javascript cho nút tăng số lượng
var PlusButons = document.getElementsByClassName("plus-btn");
[...PlusButons].forEach(Plusbtn=>{
    Plusbtn.addEventListener("click",e=>{
        let item = Plusbtn.parentElement.parentElement;
        let id = item.id;
        let price = parseInt((item.getElementsByClassName("total-price")[0].innerHTML).replace("$",""));
        var old_quantity =addedItems.get(id);
        let maxQuantity= parseInt(item.getAttribute('value'))

        if(old_quantity!=undefined){
            if(old_quantity<maxQuantity)
            addedItems.set(id,old_quantity+1);
            else{
            addedItems.set(id,maxQuantity);
            }

            totalPrice.innerHTML = parseInt(totalPrice.innerHTML) - price*old_quantity + price*addedItems.get(id);
        }
    })
})

//code cho nut thanh tien
var payButton = document.getElementById("paybutton");
    payButton.addEventListener("click",e=>{
        console.log([...addedItems])
    })
updateNum()