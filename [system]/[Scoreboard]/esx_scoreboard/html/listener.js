var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#wrap').fadeOut();
				} else {
					$('#wrap').fadeIn();
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'toggleID':

				if (event.data.state) {
					$('td:nth-child(2),th:nth-child(2)').show();
					$('td:nth-child(5),th:nth-child(5)').show();
					$('td:nth-child(8),th:nth-child(8)').show();
				} else {
					$('td:nth-child(2),th:nth-child(2)').hide();
					$('td:nth-child(5),th:nth-child(5)').hide();
					$('td:nth-child(8),th:nth-child(8)').hide();
				}

				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);


				if (jobs.ems === 0) {
					$('#ems').html("❌");
				} else if (jobs.ems >= 4) {
					$('#ems').html("4+");
				} else {
					$('#ems').html("✔");
				}

				if (jobs.police === 0) {
					$('#police').html("❌");
				} else if (jobs.police >= 4) {
					$('#police').html("4+");
				} else {
					$('#police').html("✔");
				}

				if (jobs.clerk === 0) {
					$('#clerk').html("❌");
				} else if (jobs.clerk >= 4) {
					$('#clerk').html("4+");
				} else {
					$('#clerk').html("✔");
				}

				if (jobs.taxi === 0) {
					$('#taxi').html("❌");
				} else {
					$('#taxi').html("✔");
				}

				if (jobs.mechanic === 0) {
					$('#mechanic').html("❌");
				} else if (jobs.mechanic >= 4) {
					$('#mechanic').html("4+");
				} else {
					$('#mechanic').html("✔");
				}

				if (jobs.lscustoms === 0) {
					$('#lscustoms').html("❌");
				} else if (jobs.lscustoms >= 4) {
					$('#lscustoms').html("4+");
				} else {
					$('#lscustoms').html("✔");
				}

				if (jobs.bennys === 0) {
					$('#bennys').html("❌");
				} else if (jobs.bennys >= 4) {
					$('#bennys').html("4+");
				} else {
					$('#bennys').html("✔");
				}

				if (jobs.cardealer === 0) {
					$('#cardealer').html("❌");
				} else if (jobs.cardealer >= 4) {
					$('#cardealer').html("4+");
				} else {
					$('#cardealer').html("✔");
				}

				if (jobs.weazelnews === 0) {
					$('#weazelnews').html("❌");
				} else if (jobs.weazelnews >= 4) {
					$('#weazelnews').html("4+");
				} else {
					$('#weazelnews').html("✔");
				}

				if (jobs.estate === 0) {
					$('#estate').html("❌");
				} else {
					$('#estate').html("✔");
				}

				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				applyPingColor();
				//sortPlayerList();
				break;

			case 'updatePing':
				updatePing(event.data.players);
				applyPingColor();
				break;

			case 'updateServerInfo':
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}

				break;

			default:
				console.log('esx_scoreboard: unknown action!');
				break;
		}
	}, false);
});

function applyPingColor() {
	$('#playerlist tr').each(function () {
		$(this).find('td:nth-child(3),td:nth-child(6),td:nth-child(9)').each(function () {
			var ping = $(this).html();
			var color = 'purple';

			if (ping > 110 && ping < 200) {
				color = 'purple';
			} else if (ping >= 200) {
				color = 'purple';
			}

			$(this).css('color', color);
			$(this).html(ping + " <span style='color:white;'>ms</span>");
		});

	});
}

// Todo: not the best code
function updatePing(players) {
	jQuery.each(players, function (index, element) {
		if (element != null) {
			$('#playerlist tr:not(.heading)').each(function () {
				$(this).find('td:nth-child(2):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(2).html(element.ping);
				});
				$(this).find('td:nth-child(5):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(5).html(element.ping);
				});
				$(this).find('td:nth-child(8):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(8).html(element.ping);
				});
			});
		}
	});
}

function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyA = $('td', a).eq(1).html();
		var keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}
