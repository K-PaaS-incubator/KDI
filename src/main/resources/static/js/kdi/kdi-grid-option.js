/**
 * 2024.04.27 양시열 KDI 데이터 수정 기능
 */

const fn_modify_page_load = function(menuNm, pageNm) {
	const _page_url = new URL(location.href).pathname + '/../';
	const _init = function() {
		//배너 타이틀 세팅
		$('.banner-title').text(pageNm + ' 수정');
		$('.banner-sub-title').text(pageNm + '를 수정합니다.');
		//페이지 타이틀 세팅
		$('.main-title-text').text(pageNm + ' 수정');
		$('.navi-arrow').text(' > ' + menuNm + ' > ' + pageNm + ' > 수정');

		const orgPkData = new URL(location.href).searchParams.get($('input.pk')[0].name);
		$('input#pk').val(orgPkData);
		$('input.pk').val(orgPkData);
	};
	const _get_data = function() {
		let data = {};
		const pkId = $('input.pk')[0].name;
		data[pkId] = $('input.pk').val();
		$.ajax({
			url: _page_url + 'get.json',
			data: data,
			dataType: 'json',
			success: function(result) {
				$.each($('#modify [name]'), function(idx, nameId) {
					if (!nameId.id) {
						return;
					}
					if ('SELECT' == nameId.tagName) {
						$('#' + nameId.id).val(result.data[nameId.id]).prop(
							'selected', true);
						return;
					}
					$('#' + nameId.id).val(result.data[nameId.id]);
				});
			},
			error: function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				alert(pageNm + ' 수정 실패');
			}
		});
	};

	const _event_join = function() {
		$('#modifyBtn').click(function() {
			$('#modify').validate();
			$.ajax({
				url: _page_url + 'modify.json',
				type: 'POST',
				data: $('#modify').serialize(),
				dataType: 'json',
				success: function() {
					location.href = _page_url;
				},
				error: function(result) {
					console.log('statusCode:' + result.statusCode);
					console.log('responseJSON:' + result.responseJSON.state);
					console.log('responseJSON:' + result.responseJSON.msg);
					alert(pageNm + ' 수정 실패');
				}
			});
		});

		$('#deleteBtn').click(function() {
			if (confirm(pageNm + '을(를) 삭제하시겠습니까?')) {
				$.ajax({
					url: _page_url + 'delete.json',
					type: 'POST',
					data: $('#modify').serialize(),
					dataType: 'json',
					success: function() {
						location.href = _page_url;
						alert('정상적으로 삭제되었습니다.');
					},
					error: function(result) {
						console.log(result);
						console.log('statusCode:' + result.statusCode);
						console.log('responseJSON:' + result.responseJSON.state);
						console.log('responseJSON:' + result.responseJSON.msg);
						alert(pageNm + ' 삭제 실패');
					}
				});
			} else {
				alert('삭제 취소');
			}
		});

		$('#previousBtn').click(function() {
			location.href = _page_url
		});
	};
	_init();
	_get_data();
	_event_join();
};