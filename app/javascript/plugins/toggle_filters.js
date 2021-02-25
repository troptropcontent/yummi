

/* Open */



const toggleFilters = () => {
  const filterBtn = document.getElementById("filter-open-btn");
  const closeFilterBtn = document.getElementById("filter-close-btn");
  const navbar = document.querySelector(".navbar");

  if (filterBtn&&closeFilterBtn) {
    const overlay = document.getElementById("myNav");
    filterBtn.addEventListener("click",()=>{
      overlay.classList.toggle("active");
      // document.getElementById("meal-cards").style.display ="none";
      navbar.style.display = "none";  
    });
    closeFilterBtn.addEventListener("click",()=>{
      overlay.classList.toggle("active");
      navbar.style.display = "inline-flex";
      // document.getElementById("meal-cards").style.display ="none";
    });
  }

};


// function openNav() {
//   if (document.getElementById("myNav")) {
//     document.getElementById("myNav").style.display = "block";
//   };
// }

/* Close */



export {toggleFilters};