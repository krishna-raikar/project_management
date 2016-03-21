 
$(document).ready(function () {

 $("#login_form").validate({
    rules : {
      "user[email]": {
        required : true,
        email    : true
      },
      "user[password]":{
         required: true,
         minlength: 8,
         maxlength: 25
      }

    },
    messages:{
      "user[email]":{
        required: "please enter email Id",
        email: "invalid email id"
      },
      "user[password]": {
        required: "please enter password",
        minlength: "password must contain min 8 chars",
        maxlength: "password must contain max 25 chars"
      }

    }
 });




$("#signup_form").validate({
    rules : {
      "user[email]": {
        required : true,
        email    : true
      },
      "user[password]":{
         required: true,
         minlength: 8,
         maxlength: 25
      },
      "user[password_confirmation]":{
         required: true,
         minlength: 8,
         maxlength: 25,
         equalTo: "#user_password"
      },
      "user[firstname]":{
        required: true,
         minlength: 3,
         maxlength: 20
      },
      "user[lastname]":{
        required: true,
         minlength: 3,
         maxlength: 20
      },
      "user[phone]":{
         required: true ,
         minlength: 7,
         maxlength: 11,
         digits:true
      },
      "user[role_id]":{
        required: true  
      }

    },
    messages:{
      "user[email]":{
        required: "please enter email Id",
        email: "invalid email id"
      },
      "user[password]": {
        required: "please enter password",
        minlength: "password must contain min 8 chars",
        maxlength: "password must contain max 25 chars"
      },
      "user[password_confirmation]":{
         required: "please reenter password",
         minlength: "password must contain min 8 chars",
         maxlength: "password must contain max 25 chars",
         equalTo: "password should match"
      },
      "user[firstname]":{
        required: "please enter firstname",
         minlength: "firstname must contain min 3 chars",
         maxlength: "firstname must contain max 20 chars"
      },
      "user[lastname]":{
        required: "please enter lastname",
         minlength: "lastname must contain min 3 chars",
         maxlength: "lastname must contain max 20 chars"
      },
      "user[phone]":{
         required: "please enter phoneno" ,
         minlength: "phoneno must contain min 7 chars",
         maxlength: "phoneno must contain max 11 chars",
         digits:"invalid phone number"
      },
      "user[role_id]":{
        required: "please choose your role"
      }


    }
 });
});