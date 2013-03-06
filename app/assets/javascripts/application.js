// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(function() {
	$("#user-list .pagination a").live("click", function () {
		$("#user-list .pagination").html('<div class="progress progress-info progress-striped active"><div class="bar" style="width: 80%"></div></div>');
		$.getScript(this.href);
		return false;
	});

	var timer = null;
	$("#users_search input").keyup(function() {
        clearTimeout(timer); 
        timer = setTimeout($.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script"), 1000);
        return false;
  });

	$("#high-scores .pagination a").live("click", function () {
		$("#high-scores .pagination").html('<div class="progress progress-info progress-striped active"><div class="bar" style="width: 80%"></div></div>');
		$.getScript(this.href);
		return false;
	});
});