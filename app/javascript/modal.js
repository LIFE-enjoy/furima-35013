function modalOpen(){
    const pencilBottom = document.getElementById("edit-bottom");
    const closeBtn = document.getElementById('closeBtn');
    const modal = document.getElementById('modal');
    const modalBody = document.getElementsByClassName('modal-content')

    pencilBottom.addEventListener('click',() => {
      modal.setAttribute("style", "display:block;");
    });

    closeBtn.addEventListener('click', function(e) {
      e.preventDefault();
      location.reload();
    });
};

window.addEventListener('load',modalOpen)