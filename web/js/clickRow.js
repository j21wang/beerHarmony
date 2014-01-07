$(document).ready(function(){
   reloadAvgrund();

   $("#example tbody").click(function(event){
      $(oTable.fnSettings().aoData).each(function(){
         $(this.nTr).removeClass('row_selected');
   });

   $(event.target.parentNode).addClass('row_selected');
      reloadAvgrund();
   });

   $(".paginate_enabled_previous, .paginate_enabled_next, thead").click(function(){
      reloadAvgrund();
   });

   $('#delete').click(function(){
      var anSelected = fnGetSelected(oTable);
      oTable.fnDeleteRow(anSelected[0]);
   });
   oTable = $('#example').dataTable();
   
});

function fnGetSelected(oTableLocal){
   var aReturn = new Array();
   var aTrs = oTableLocal.fnGetNodes();
   for (var i=0; i<aTrs.length; i++){
      if($(aTrs[i]).hasClass('row_selected')){
         aReturn.push(aTrs[i]);
      }
   }
   return aReturn;
}

function reloadAvgrund(){
   $(".avgrund-overlay, .avgrund-popin").remove();
   $(".odd, .even").avgrund({
            height:300,
            holderClass: 'custom',
            showClose: true,
            showCloseText: 'Close',
            closeByEscape: true,
            closeByDocument: true,
            enableStackAnimation: true,
            onBlurContainer: 'body',
            onLoad: function(elem){
               pName=elem.context.children[0].innerHTML;
               pGender=elem.context.children[1].innerHTML;
               pAge=elem.context.children[2].innerHTML;
               pCountry=elem.context.children[3].innerHTML;
               pHotness=elem.context.children[4].innerHTML;
               response="Please try again! It will definitely work this time!";
               if (window.XMLHttpRequest)
               {// code for IE7+, Firefox, Chrome, Opera, Safari
               xmlhttp=new XMLHttpRequest();
               }
               else
               {// code for IE6, IE5
               xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
               }
               xmlhttp.onreadystatechange=function()
               {
                  if (xmlhttp.readyState==4 && xmlhttp.status==200)
                  {
                     response=xmlhttp.responseText;
                  }
               }
               xmlhttp.open("GET","http://cs336-12.cs.rutgers.edu/php/details.php?name="+pName+"&age="+pAge,false);
               xmlhttp.send();
            },
            template: '<script> console.log(pName) </script>' + 
                      '<div id="response"></div>' +
                      '<script>$("#response").html(response);</script>'
      });
}
