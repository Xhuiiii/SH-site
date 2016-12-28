// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(".service_type_reservations").ready(function(){
  //Get selected service (Service chosen first)
  var selected_service_id = document.getElementById('selected_service_id');
  //Get service select field (Category chosen first)
  var service_select_field = document.getElementById('service_select_field');
  if (service_select_field){
    service_select_field.style.display = 'none';
  }
  var sel_time_field = document.getElementById('sel_time_field');
  if (sel_time_field){
    sel_time_field.style.display = 'none';
  }

  var category_id = document.getElementById('category_id');
  var service_type_id = document.getElementById('service_type_id');
  var occupancy = document.getElementById('occupancy');
  var adult_occupancy = document.getElementById('adult_occupancy');
  var child_occupancy = document.getElementById('child_occupancy');

  //Customise Datepickers
  //Get today's date
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
  var checkinDate = new Date();

  var unavailable_dates = document.getElementById('unavailable_dates');
  if(unavailable_dates){
    var unavailable_dates_array = unavailable_dates.value.split(" ");
  }
  var unavailable_days = document.getElementById('unavailable_days');
  if (unavailable_days){
    var unavailable_days_array = unavailable_days.value;
  }

  var checkin = $('#dpd1').datepicker({
    todayHighlight: true,
    startDate: now,
    format: 'dd M yyyy',
    datesDisabled: unavailable_dates_array,
    daysOfWeekDisabled: unavailable_days_array
  }).on('changeDate', function(ev) {
    if (sel_time_field){
      sel_time_field.style.display = 'block';
    }
    var newDate = new Date(ev.date);
    newDate.setDate(newDate.getDate() + 1);
    //If a service is already selected
    var multiple_day = document.getElementById('multiple_day');

    //Set the checkout calendar's view date
    $('#dpd2').datepicker('defaultViewDate', newDate);
    $('#dpd2').datepicker('setDate', newDate);
    $('#dpd2').datepicker('setStartDate', newDate);

    checkin.hide();
  }).on('show', function(ev){
    //If service is selected first
    if (selected_service_id){
      //Get ajax to display prices
      $.get("display_prices", {service_type_id : selected_service_id.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }
  }).on('hide', function(ev){
    //If a date has been chosen
    if($('#dpd1').datepicker()[0].value){
      var multiple_day = document.getElementById('multiple_day');
      //If the category is a single day category
      if (multiple_day.value == "false"){
        //if a category is chosen first
        if (service_select_field){
          //Show available services for selected dates when checkout is chosen
          $.get("display_single_day_services", {category_id : category_id.value, check_in : checkin.getDate()})
          .error(function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
          });
          service_select_field.style.display = 'block';
        }else{
          $.get("display_timeslots", {service_type_id : selected_service_id.value, query_date : this.value})
          .error(function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
          });
        }
      }else{
        if (selected_service_id){
          //Get whether an adult child field or a persons field is required
          $.get("display_occupancy", {service_type_id : selected_service_id.value})
          .error(function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
          });
        }
      }
    }
  }).data('datepicker');

  var checkout = $('#dpd2').datepicker({
    format: 'dd M yyyy',
  }).on('changeDate', function(ev) {
    var next_day_date = ev.date
    if (!next_day_date){
      var checkinDate = $('#dpd1').datepicker('getDate');
      var next_day_date = new Date(checkinDate);
      next_day_date.setDate(next_day_date.getDate() + 1);
    }
    var newEndDate;
    if(selected_service_id){
      //Gets array of disabled checkout dates (if any)
      $.get("get_checkout_dates", {service_type_id : selected_service_id.value, next_day : next_day_date})
      .success(function(data){
        newEndDate = new Date(data);
        //Check if newEndDate is valid date object
        if(newEndDate instanceof Date && !isNaN(newEndDate.valueOf())){
          $('#dpd2').datepicker('setEndDate', newEndDate);
        }
      })
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown);
      });
    }
    checkout.hide();
  }).on('show', function(ev){
    //If the first datepicker has a value
    if ($('#dpd1').datepicker()[0].value){
      if (selected_service_id){
        //Get ajax to display prices
        $.get("display_prices", {service_type_id : selected_service_id.value})
        .error(function(XMLHttpRequest, textStatus, errorThrown){
          console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
        });
      }
    }else{
      checkout.hide();
      $('#dpd1')[0].focus();
    }
  }).on('hide', function(ev){
    //If both datepickers have a value
    if (($('#dpd1').datepicker()[0].value) && ($('#dpd2').datepicker()[0].value)){
      //if a category is chosen first
      if (service_select_field){
        var multiple_day = document.getElementById('multiple_day');
        //If the category is a multiple day category
        if (multiple_day.value == "true"){
          //Show available services for selected dates when checkout is chosen
          $.get("display_multiple_day_services", {category_id : category_id.value, check_in : checkin.getDate(), check_out : this.value})
          .error(function(XMLHttpRequest, textStatus, errorThrown){
            console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
          });
        }
        service_select_field.style.display = 'block';
      }
    }
  }).data('datepicker');

  //Date is selected already
  //When a radio button is selected
  $(document).on('change', "[data-behavior~=service_selected]", function(){
    //Set the service type id to the selected service value
    service_type_id.value = this.value;
    var multiple_day = document.getElementById('multiple_day');

    //Show timeslots if applicable
    if (multiple_day.value == "false"){
      if (sel_time_field){
        sel_time_field.style.display = 'block';
      }
      $.get("display_timeslots", {service_type_id : this.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }else{
      //Get whether an adult child field or a persons field is required
      $.get("display_occupancy", {service_type_id : this.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }
  });

  $(document).on('change', "[data-behavior~=timeslot_selected]", function(){
    var timeslot_selected = document.getElementById('chosen_timeslot');
    //Set to timeslot id
    timeslot_selected.value = this.value;
    if(selected_service_id){
      //Get whether an adult child field or a persons field is required
      $.get("display_occupancy", {service_type_id : selected_service_id.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }
  });

  $(document).on('change', "[data-behavior~=occupancy_selected]", function(){
    occupancy.value = this.value;
  });

  $(document).on('change', "[data-behavior~=adult_occupancy_selected]", function(){
    adult_occupancy.value = this.value;
    if(service_type_id){
      //Reset the child occupancy
      $.get("display_child_occupancy", {service_type_id : service_type_id.value, adult_occupancy : this.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }else if(selected_service_id){
      //Reset the child occupancy
      $.get("display_child_occupancy", {service_type_id : selected_service_id.value, adult_occupancy : this.value})
      .error(function(XMLHttpRequest, textStatus, errorThrown){
        console.log(XMLHttpRequest.responseText + textStatus + errorThrown)
      });
    }
  });

  $(document).on('change', "[data-behavior~=child_occupancy_selected]", function(){
    child_occupancy.value = this.value;
  });
});
