const fn_title_init = function(menuNm, pageNm, pageType) {
	//배너 타이틀 세팅
	$('.banner-title').text(pageNm + ' ' + pageType);
	$('.banner-sub-title').text(pageNm + '를 ' + pageType + ' 합니다.');
	//페이지 타이틀 세팅
	$('.main-title-text').text(pageNm + ' ' + pageType);
	$('.navi-arrow').text(' > ' + menuNm + ' > ' + pageNm + ' > ' + pageType);
}
const fn_duplicate_check = function(pageUri, pkNm) {
	let data = {};
	data[pkNm] = encodeURIComponent($('input[name="' + pkNm + '"]'));
	let checkResult = false;
	$.ajax({
		url: pageUri + 'duplicateCheck.json', //컨트롤러에서 요청받을 주소
		type: 'GET',
		async: false,
		dataType: 'json',
		data: data,
		success: function(result) {
			checkResult = result.data;
		},
		error: function(result) {
			console.log('statusCode:' + result.statusCode);
		}
	});
	return checkResult;
}

const fn_previous_button_click = function(_page_url) {
	$('#previousBtn').click(function() {
		location.href = _page_url
	});
}

const fn_insert_page_load = function(menuNm, pageNm) {
	const _page_url = new URL(location.href).pathname + '/../';
	const _pkNm = $('input.pk')[0].name;
	const _pkTitle = $('.pkTitle').text();
	const _init = function() {
		fn_title_init(menuNm, pageNm, '등록');
	};
	const _event_join = function() {
		$('#regbtn').click(function databaseSave() {
			$('form').validate();
			const duplicate = fn_duplicate_check(_page_url, _pkNm);
			if (!duplicate) {
				alert(_pkTitle + '가 중복되었습니다.');
				return;
			}
			$.ajax({
				url: _page_url + 'insert.json', //컨트롤러에서 요청받을 주소
				type: 'POST',
				async: false,
				data: $('#insert').serialize(),
				dataType: 'json',
				success: function() {
					alert('등록 완료');
					location.href = _page_url;
				},
				error: function(result) {
					alert(result.responseJSON.msg);
				}
			});
		});
		fn_previous_button_click(_page_url);
	};
	_init();
	_event_join();
}

const fn_modify_page_load = function(menuNm, pageNm) {
	const _page_url = new URL(location.href).pathname + '/../';
	const _init = function() {
		fn_title_init(menuNm, pageNm, '수정');

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

		fn_previous_button_click(_page_url);
	};
	_init();
	_get_data();
	_event_join();
};