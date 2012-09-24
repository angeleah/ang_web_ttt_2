
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Remember The Milk signup form - jQuery Validate plugin demo - with friendly permission from the RTM team</title>
<link rel="stylesheet" type="text/css" media="screen" href="milk.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/chili.css" />
<script src="../../lib/jquery.js" type="text/javascript"></script>
<script src="../../jquery.validate.js" type="text/javascript"></script>
<style type="text/css">
pre { text-align: left; }
</style>
<script id="demo" type="text/javascript">
$(document).ready(function() {
// validate signup form on keyup and submit
var validator = $("#signupform").validate({
rules: {
firstname: "required",
lastname: "required",
username: {
required: true,
minlength: 2,
remote: "users.php"
},
password: {
required: true,
minlength: 5
},
password_confirm: {
required: true,
minlength: 5,
equalTo: "#password"
},
email: {
required: true,
email: true,
remote: "emails.php"
},
dateformat: "required",
terms: "required"
},
messages: {
firstname: "Enter your firstname",
lastname: "Enter your lastname",
username: {
required: "Enter a username",
minlength: jQuery.format("Enter at least {0} characters"),
remote: jQuery.format("{0} is already in use")
},
password: {
required: "Provide a password",
rangelength: jQuery.format("Enter at least {0} characters")
},
password_confirm: {
required: "Repeat your password",
minlength: jQuery.format("Enter at least {0} characters"),
equalTo: "Enter the same password as above"
},
email: {
required: "Please enter a valid email address",
minlength: "Please enter a valid email address",
remote: jQuery.format("{0} is already in use")
},
dateformat: "Choose your preferred dateformat",
terms: " "
},
// the errorPlacement has to take the table layout into account
errorPlacement: function(error, element) {
if ( element.is(":radio") )
error.appendTo( element.parent().next().next() );
else if ( element.is(":checkbox") )
error.appendTo ( element.next() );
else
error.appendTo( element.parent().next() );
},
// specifying a submitHandler prevents the default submit, good for the demo
submitHandler: function() {
alert("submitted!");
},
// set this class to error-labels to indicate valid fields
success: function(label) {
// set &nbsp; as text for IE
label.html("&nbsp;").addClass("checked");
}
});
// propose username by combining first- and lastname
$("#username").focus(function() {
var firstname = $("#firstname").val();
var lastname = $("#lastname").val();
