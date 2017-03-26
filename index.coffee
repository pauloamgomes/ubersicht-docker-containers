style: """
	color: white
	right: 30px
	top: 140px
	font-size: 13px
	font-family: SFNS Display, 'Helvetica Neue', sans-serif
	text-shadow: 1px 1px 0 rgba(#000, 0.4)
	background-color: rgba(0, 0, 0, 0.5)
	padding: 12px
	border-radius: 6px
	border: 1px solid #222

	table
		margin: 0 auto
		td
			padding: 4px

	.ip
		opacity: 0.6
		font-size: 13px

	.indicator
		font-size: 20px
		padding: 0 12px
		&.running
			color: rgb(153, 227, 160)
		&.stopped
			color: rgb(244, 115, 94)
	.restart, .shell
		cursor: pointer
		padding: 2px 4px
		border: none
		border-radius: 5px
		background-color: rgba(255, 255, 255, 0.8)
"""

command: "dockercontainers.widget/helper.sh getStatus"

refreshFrequency: 15000

render: -> """
	<div>
  	<table></table>
	</div>
"""

afterRender: (domEl) ->

 $(domEl).on 'click', '.restart', (e) =>
  target = $(e.currentTarget)
 	image = $(target).attr 'data-image'
 	@run "dockercontainers.widget/helper.sh restart " + image

 $(domEl).on 'click', '.shell', (e) =>
  target = $(e.currentTarget)
 	image = $(target).attr 'data-image'
 	@run "dockercontainers.widget/helper.sh shell " + image

update: (output, domEl) ->
	machines 	= output.split("\n")
	table = $(domEl).find('table')

	table.html('')

	renderMachine = (image, name, size, status) -> """
		<tr class="row">
			<td>#{ name }</td>
			<td>#{ image }</td>
			<td>#{ size }</td>
			<td class="status">#{ status }</td>
			<td>
				<button data-image="#{ image }" class="restart">restart</button>
				<button data-image="#{ image }" class="shell">shell</button>
			</td>
		</tr>
	"""

	for machine in machines
		[image, name, size, status] = machine.split('|')
		if image.length > 0
			table.append renderMachine(image, name, size, status)
