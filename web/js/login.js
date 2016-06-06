// document.getElementById("submitButton").onclick(submitForm);

// function submitForm() {
//     document.forms["login"].submit();
// }


$(document).ready(function(){
"use strict";
    $("#submitButton").click(function(){
        document.forms["login_form"].submit();
    });

    $("#sign_up_button").click(function(){
        $("#sign_up_form").fadeIn(1000);
    });

    $("#sign_up_submitButton").click(function(){
        document.forms["sign_up_form"].submit();
    });

    $("#forgetPassword").click(function(){
        alert("此功能需要付费,请联系管理员 QQ:675250932");
    });



});