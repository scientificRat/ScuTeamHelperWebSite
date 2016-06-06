
$(document).ready(function(){
"use strict";

                  $("#plus").mouseover(function(){
                                       $(".panel").slideToggle("fast");
                                       });
                  
                  $("#plus").mouseout(function(){
                                      $(".panel").slideToggle("fast");
                                      });
                  
                  $("#plus").click(function(){
                                   $(".form").slideToggle("fast");
                                   });
                  $("#notCaptain").click(function(){
                                         $(".abilityForm").slideDown("fast");
                                         });
                  $("#Captain").click(function(){
                                      $(".abilityForm").slideUp("fast");
                                      });
				  $(document).scroll(changeTitleOpacity);
				  $("#nav_projectHolder").click(scrollToProjectHolder);
				  $("#nav_abilityHolder").click(scrollToAbilityHolder);
                 
 });

function changeTitleOpacity(){
	"use strict";
	var x=$(document).scrollTop()/$(window).height();
	//alert(x);
	$("#front").css('opacity',Math.max(0, Math.min(1, 1-x*2 )));
	if(x>0.5){
		$("#front").css('z-index',-10);
	}
	else{
		$("#front").css('z-index',-10);
	}
}
function scrollToProjectHolder(){
	"use strict";
	$.scrollTo('#projectHolder',500);
}
function scrollToAbilityHolder(){
	"use strict";
	$.scrollTo('#abilityHolder',500);
}