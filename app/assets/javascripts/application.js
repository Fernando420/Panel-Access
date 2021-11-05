// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery
//= require datatables
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require bootstrap
//= require_tree .



$(document).on('turbolinks:load', function() {

  $(document).ready(function() {
    $('#table_desing').DataTable();
  } );
    
  $("#username").on('blur', function(){
    let username = $('#username').val();
    let rgex = /^[a-zA-Z0-9_]*$/
    let validate = rgex.test(username);
    if ( validate ) {
      $("#username").removeClass('border-red');
      $("#text-username").addClass('hide');
    } else {
      $("#username").addClass('border-red');
      $("#text-username").removeClass('hide');
      $('#username').val("");
    }
  });

  $("#lada").on('blur', function(){
    let lada = $('#lada').val();
    let rgex = /^[0-9]*[1-9][0-9]*$/
    var validate = rgex.test(lada);
    if ( validate ) {
      $("#lada").removeClass('border-red');
      $("#text-lada").addClass('hide');
    } else {
      $("#lada").addClass('border-red');
      $("#text-lada").removeClass('hide');
      $('#lada').val("");
    }
  })

  $("#age").on('blur', function(){
    let age = $('#age').val();
    let rgex = /^[0-9]*[1-9][0-9]*$/
    var validate = rgex.test(age);
    if ( validate ) {
      $("#age").removeClass('border-red');
      $("#text-age").addClass('hide');
    } else {
      $("#age").addClass('border-red');
      $("#text-age").removeClass('hide');
      $('#age').val("");
    }
  })

  $("#member_id").on('blur', function(){
    let member_id = $('#member_id').val();
    let rgex = /^[0-9]*[1-9][0-9]*$/
    var validate = rgex.test(member_id);
    if ( validate ) {
      $("#member_id").removeClass('border-red');
      $("#text-member_id").addClass('hide');
    } else {
      $("#member_id").addClass('border-red');
      $("#text-member_id").removeClass('hide');
      $('#member_id').val("");
    }
  })

  $("#amount").on('blur', function(){
    let amount = $('#amount').val();
    let rgex = /^[1-9]\d*(\.\d+)?$/
    var validate = rgex.test(amount);
    if ( validate ) {
      $("#amount").removeClass('border-red');
      $("#text-amount").addClass('hide');
    } else {
      $("#amount").addClass('border-red');
      $("#text-amount").removeClass('hide');
      $('#amount').val("");
    }
  })

  $("#extra_charge").on('blur', function(){
    let extra_charge = $('#extra_charge').val();
    let rgex = /^[0-9]\d*(\.\d+)?$/
    var validate = rgex.test(extra_charge);
    if ( validate ) {
      $("#extra_charge").removeClass('border-red');
      $("#text-extra_charge").addClass('hide');
    } else {
      $("#extra_charge").addClass('border-red');
      $("#text-extra_charge").removeClass('hide');
      $('#extra_charge').val("");
    }
  })

  $("#password").on('blur', function(){
    let password = $('#password').val();
    let rgex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/
    let validate = rgex.test(password);
    if ( validate ) {
      $("#password").removeClass('border-red');
      $("#text-password").addClass('hide');
    } else {
      $("#password").addClass('border-red');
      $("#text-password").removeClass('hide');
      $('#password').val("");
    }
  })

  $("#confirmPassword").on('blur', function(){
    let password = $('#password').val();
    let confirmPassword = $('#confirmPassword').val();
    if ( password == confirmPassword ) {
      $("#confirmPassword").removeClass('border-red');
      $("#text-confirmPassword").addClass('hide');
    } else {
      $("#confirmPassword").addClass('border-red');
      $("#text-confirmPassword").removeClass('hide');
      $('#confirmPassword').val("");
    }
  })

  $("#phone").on('blur', function(){
    let phone = $('#phone').val();
    let rgex = /^[0-9]*[1-9][0-9]*$/
    var validate = rgex.test(phone);
    if ( validate ) {
      $("#phone").removeClass('border-red');
      $("#text-phone").addClass('hide');
    } else {
      $("#phone").addClass('border-red');
      $("#text-phone").removeClass('hide');
      $('#phone').val("");
    }
  })

  $("#email").on('blur', function(){
    let email = $('#email').val();
    let rgex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/
    var validate = rgex.test(email);
    if ( validate ) {
      $("#email").removeClass('border-red');
      $("#text-email").addClass('hide');
    } else {
      $("#email").addClass('border-red');
      $("#text-email").removeClass('hide');
      $('#email').val("");
    }
  })


});