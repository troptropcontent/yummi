

/* Open */



const toggleFilters = () => {
  const openBtn = document.getElementById("open-btn");
  const closeBtn = document.getElementById("close-btn");
  const navbar = document.querySelector(".navbar");
  const overlay = document.querySelector(".overlay");

  if (openBtn&&closeBtn) {
    
    openBtn.addEventListener("click",()=>{
      
      overlay.classList.toggle("active");
      console.log("Hello")
      // document.getElementById("meal-cards").style.display ="none";
      navbar.style.display = "none";  
    });
    closeBtn.addEventListener("click",()=>{
      console.log("close")
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