const initDropDown = () => {

  function DropDown(el) {
    this.dd = el;
    this.placeholder = this.dd.children('span');
    this.content = this.dd.find('.dropdown');
    this.initEvents();
  }
  DropDown.prototype = {
    initEvents : function() {
      var obj = this;

      obj.dd.on('click', function(event){
        $(this).toggleClass('active');
        return false;
      });
    }
  }

  var dd = new DropDown( $('#dd') );

}

export { initDropDown }
