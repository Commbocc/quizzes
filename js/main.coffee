---
---

$ ->

	# form behavior
	$('.answer-list input').change ->
		$(this).closest('.answer-list').find('.description').each ->
			$(this).slideDown()

		if $(this).data('correct') != false
			$(this).closest('.alert').addClass('alert-success')
		else
			$(this).closest('.alert').addClass('alert-danger')

		# disable other answers from being selected
		$(this).closest('.answer-list').find('input').each ->
			$(this).addClass('disabled').attr('disabled', true)

	# get results
	$('#get-results').click ->

		# highlight answers
		$('.answer-list input').each ->
			$(this).addClass('disabled').attr('disabled', true)
			$(this).closest('.alert').siblings().andSelf().each ->
				if $(this).find('input').data('correct') != false
					$(this).addClass('text-success')
				else
					$(this).addClass('text-danger')

		# show descriptions
		$('.description').each ->
			$(this).slideDown()

		# count correct answers
		correct_answers = 0
		$('.answer-list input:checked').each ->
			correct_answers++ if $(this).data('correct') != false

		# display results
		$('.result').each ->
			$(this).show() if correct_answers <= $(this).data('upper') && correct_answers >= $(this).data('lower')
			$('.num-correct').text(correct_answers)
			$('.percent-correct').text( (correct_answers / $(this).data('question-count') * 100).toFixed(2) )
