import '../stylesheets/datepickr.scss'

import flatpickr from 'flatpickr'

document.addEventListener('turbolinks:load', function(){
  flatpickr('#task_start_at', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
  flatpickr('#task_end_at', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  })
})

