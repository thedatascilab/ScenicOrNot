function getEventTarget(e) {
   var targ;
   if (!e) {
      e = window.event;
   }
   if (e.target) {
      targ = e.target;
   } else if (e.srcElement) {
      targ = e.srcElement;
   }
   if (targ.nodeType == 3) { // defeat Safari bug
      targ = targ.parentNode;
   }

   return targ;
}


Event.observe(window, 'load', function(){
      
   $$('#rate input').each(function(e){
         Event.observe(e, 'mouseover', function(e)
            {
               var inp = getEventTarget(e)
               inp.src = inp.src.replace('.jpg', '-hover.jpg')
            });
         
         Event.observe(e, 'mouseout', function(e)
            {
               var inp = getEventTarget(e)
               inp.src = inp.src.replace('-hover.jpg', '.jpg')
            });
   });
});

