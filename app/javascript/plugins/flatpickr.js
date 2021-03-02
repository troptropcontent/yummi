// app/javascript/plugins/flatpickr.js
import flatpickr from "flatpickr";
 import ConfirmDatePlugin from 'flatpickr/dist/plugins/confirmDate/confirmDate';
  import 'flatpickr/dist/plugins/confirmDate/confirmDate.css'

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    enableTime: true,
    altInput: true,
    allowInput: true,
    disableMobile: true,
    plugins: [new ConfirmDatePlugin({confirmText: 'Done'})]
  });
}

export { initFlatpickr };
