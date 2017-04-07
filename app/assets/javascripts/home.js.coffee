# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
#	$('#transcript_application_college_id').parent().hide()
#	$("[for=transcript_application_college_id]").hide()
	$('#transcript_application_course').parent().hide()
	$("[for=transcript_application_course]").hide()
	colleges = $('#transcript_application_college_id').html()
	$('#transcript_application_university_id').change ->
		university = $('#transcript_application_university_id').find('option:selected',).text();
		escaped_university = university.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&")		
		options = $(colleges).filter("optgroup[label='#{university}']").html()
		if options
			$('#transcript_application_college_id').html(options)
			$('#transcript_application_college_id').parent().show()
			$("[for=transcript_application_college_id]").show()
			$('#transcript_application_course').parent().show()
			$("[for=transcript_application_course]").show()
		else
			$('#transcript_application_college_id').empty()
			$('#transcript_application_college_id').parent().hide()
			$("[for=transcript_application_college_id]").hide()
