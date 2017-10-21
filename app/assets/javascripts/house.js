$(function(){
  $("input[name='house[price]']").keyup(function(){
		var newVal = addCommas(removeCommas($(this).val()));
		$(this).val(newVal);
	});

	$("input[name='house[price]']").closest("form").submit(function(e) {
		var priceField = $("input[name='house[price]']");
		priceField.val(removeCommas(priceField.val()));
	})

	function addCommas(num) {
		return num.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
	}

	function removeCommas(num) {
		return num.replace(/,/g,'');
	}
});


$(document).ready(function() {
		// Animate loader off screen
		$(".se-pre-con").fadeOut("slow");
	});

document.addEventListener("turbolinks:load", function() {
	$(".se-pre-con").fadeOut("slow");;
  // your code here
})
