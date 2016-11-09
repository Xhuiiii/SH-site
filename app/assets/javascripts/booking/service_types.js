// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  //Occupancy
  var adult_child_checkbox = document.getElementById("adult_child_checkbox");
  display_child_div(adult_child_checkbox);

  var adult_compulsory = document.getElementById("adult_compulsory");
  var max_adult_occupancy = document.getElementById("max_adult_occupancy");
  var max_child_occupancy = document.getElementById("max_child_occupancy");
  var max_occupancy = document.getElementById('max_occupancy');
  if(max_occupancy){
    if(parseInt(max_occupancy.value) < 1){
      max_occupancy.value = 1;
    }
  }

  //Customise Datepickers
  //Get today's date
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
  var checkinDate = new Date();

  var special_from = $('#dpd1').datepicker({
    todayHighlight: true,
    startDate: now,
    format: 'dd M yyyy'
  }).on('changeDate', function(ev) {
    var newDate = new Date(ev.date);
    newDate.setDate(newDate.getDate() + 1);
    $('#dpd2').datepicker('setStartDate', newDate);
    $('#dpd2').datepicker('defaultViewDate', newDate);
    $('#dpd2').datepicker('setDate', newDate);
    special_from.hide();
    $('#dpd2')[0].focus();
  }).data('datepicker');

  var special_to = $('#dpd2').datepicker({
    format: 'dd M yyyy'
  }).on('changeDate', function(ev) {
    special_to.hide();
  }).on('show', function(ev){
    var special_from_date = $('#dpd1').datepicker('getDate');
    var startDate = new Date();
    startDate.setDate(special_from_date.getDate() + 1);
    $('#dpd2').datepicker('setStartDate', startDate);
  }).data('datepicker');

  var unavailable_from = $('#dpd3').datepicker({
    todayHighlight: true,
    startDate: now,
    format: 'dd M yyyy'
  }).on('changeDate', function(ev) {
    var newDate = new Date(ev.date);
    newDate.setDate(newDate.getDate() + 1);
    $('#dpd4').datepicker('setStartDate', newDate);
    $('#dpd4').datepicker('defaultViewDate', newDate);
    $('#dpd4').datepicker('setDate', newDate);
    unavailable_from.hide();
    $('#dpd4')[0].focus();
  }).data('datepicker');

  var unavailable_to = $('#dpd4').datepicker({
    format: 'dd M yyyy'
  }).on('changeDate', function(ev) {
    unavailable_to.hide();
  }).on('show', function(ev){
    var unavailable_from_date = $('#dpd3').datepicker('getDate');
    var startDate = new Date();
    startDate.setDate(unavailable_from_date.getDate() + 1);
    $('#dpd4').datepicker('setStartDate', startDate);
  }).data('datepicker');

  //Add timeslots
  $('[data-form-prepend]').click( function(e)
  { var obj = $( $(this).attr('data-form-prepend') );
  obj.find('input, select, textarea').each( function() {
    $(this).attr( 'name', function() {
      return $(this).attr('name').replace( 'new_record', (new Date()).getTime() );
    });
  });
  return false;
  });

  //Special prices
  var special_mondays = document.getElementById('special_mondays');
  var special_tuesdays = document.getElementById('special_tuesdays');
  var special_wednesdays = document.getElementById('special_wednesdays');
  var special_thursdays = document.getElementById('special_thursdays');
  var special_fridays = document.getElementById('special_fridays');
  var special_saturdays = document.getElementById('special_saturdays');
  var special_sundays = document.getElementById('special_sundays');

  display_child_div(special_mondays);
  display_child_div(special_tuesdays);
  display_child_div(special_wednesdays);
  display_child_div(special_thursdays);
  display_child_div(special_fridays);
  display_child_div(special_saturdays);
  display_child_div(special_sundays);

  //Booking limit
  var booking_limit_bool = document.getElementById('booking_limit_bool');
  display_child_div(booking_limit_bool);
});

//Display child div if checkbox is checked
var display_child_div = function(checkbox){
  if(checkbox){
    if(checkbox.checked){
      checkbox.parentElement.getElementsByTagName("div")[0].style.display = "block";
    }else{
      checkbox.parentElement.getElementsByTagName("div")[0].style.display = "none";
    }
  }
}

$(document).on('change', "[data-behavior~=show_child_div]",  function(ev){
  if(this.checked){
    this.parentElement.getElementsByTagName("div")[0].style.display = "block";
  }else{
    this.parentElement.getElementsByTagName("div")[0].style.display = "none";
  }
});

//Max occupancy changed. Update adult & child fields
$(document).on('change', "[data-behavior~=max_occupancy_updated]", function(){
  if(parseInt(this.value) < 1){
    this.value = 1;
  }
  if(adult_child_checkbox.checked){
    if(parseInt(max_adult_occupancy.value) > parseInt(this.value)){
      max_adult_occupancy.value = this.value;
    }
    if(adult_compulsory.checked){
      if(parseInt(max_child_occupancy.value) > (parseInt(this.value) - 1)){
        max_child_occupancy.value = (parseInt(this.value) - 1);
      }
    }else{
      if(parseInt(max_child_occupancy.value) > parseInt(this.value)){
        max_child_occupancy.value = this.value;
      }
    }
  }
});

$(document).on('change', "[data-behavior~=adult_compulsory]", function(){
  if(parseInt(max_adult_occupancy.value) < 1){
    max_adult_occupancy.value = 1;
  }
});

$(document).on('change', "[data-behavior~=max_adult_occupancy]", function(){
  if(adult_compulsory.checked && (parseInt(this.value) < 1)){
    this.value = 1;
  }
  if(parseInt(this.value) > parseInt(max_occupancy.value)){
    this.value = max_occupancy.value;
  }
});

$(document).on('change', "[data-behavior~=max_child_occupancy]", function(){
  if(adult_compulsory.checked){
    if(parseInt(this.value) >= parseInt(max_occupancy.value)){
      this.value = (parseInt(max_occupancy.value) - 1);
    }
  }else{
    if(parseInt(this.value) > parseInt(max_occupancy.value)){
      this.value = max_occupancy.value;
    }
  }
});
