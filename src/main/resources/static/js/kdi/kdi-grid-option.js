const fn_title_init = function(menuNm, pageNm, pageType) {
	//배너 타이틀 세팅
	$('.banner-title').text(pageNm + ' ' + pageType);
	$('.banner-sub-title').text(pageNm + '를 ' + pageType + ' 합니다.');
	//페이지 타이틀 세팅
	$('.main-title-text').text(pageNm + ' ' + pageType);
	$('.navi-arrow').text(' > ' + menuNm + ' > ' + pageNm + ' ' + pageType);
};

const fn_duplicate_check = function(pageUri, pkNm) {
	let data = {};
	data[pkNm] = encodeURIComponent($('input[name="' + pkNm + '"]'));
	let checkResult = false;
	console.log(data);
	$.ajax({
		url: pageUri + 'duplicateCheck.json', //컨트롤러에서 요청받을 주소
		type: 'GET',
		async: false,
		dataType: 'json',
		data: data,
		success: function(result) {
			// 중복이면 true
			checkResult = result.data;
		},
		error: function(result) {
			console.log('statusCode:' + result.statusCode);
		}
	});
	return checkResult;
};

const fn_previous_button_click = function(_page_url) {
	$('#previousBtn').click(function() {
		location.href = _page_url
	});
};
const fn_detail_display_event = function(dtlName, dtlMapping) {
	const _dtlName = dtlName;
	const _dtlMapping = dtlMapping;
	const _init = function() {
		$('[name="' + _dtlName + '"]').change(function() {
			$('div[class*="detail-"]').css('display', 'none');
			$('.detail-' + _dtlMapping[this.value]).css('display', 'flex');
		});
	};
	const _fn_select = function() {
		$('.detail-' + _dtlMapping[$('[name="' + _dtlName + '"]').val()]).css('display', 'flex');
	}
	_init();
	return {
		select: _fn_select
	}
};
const fn_input_box_display_event = function(dtlName, dtlMapping) {
	const _dtlName = dtlName;
	const _dtlMapping = dtlMapping;
	const _init = function() {
		$('[name="' + _dtlName + '"]').change(function() {
			$('div[class*="detail-"]').css('display', 'none');
			$('.detail-' + _dtlMapping[this.value]).css('display', 'block');
		});
	};
	const _fn_select = function() {
		$('div[class*="detail-"]').css('display', 'none');
		if (!_dtlMapping[$('[name="' + _dtlName + '"]')]) {
			return;
		}
		$('.detail-' + _dtlMapping[$('[name="' + _dtlName + '"]').val()]).css('display', 'block');
	}
	_init();
	return {
		select: _fn_select
	}
};

const fn_pattern_event = function() {
	$('.id-pattern').keyup(function() {
		$(this).val($(this).val().replace(/[^a-zA-Z0-9@._-]/g, ''));
	});
}

const fn_insert_page_load = function(menuNm, pageNm) {
	const _page_url = new URL(location.href).pathname + '/../';
	const _pkNm = $('input.pk')[0].name;
	const _pkTitle = $('.pk-title').text();
	const _init = function() {
		fn_title_init(menuNm, pageNm, '등록');
		fn_pattern_event();
	};
	const _event_join = function() {
		$('#regbtn').click(function databaseSave() {
			$('form').validate();
			const duplicate = fn_duplicate_check(_page_url, _pkNm);
			if (duplicate) {
				alert('"' + _pkTitle + '"가(이) 중복되었습니다.');
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
					console.log(result.responseJSON);
					alert(result.responseJSON.msg);
				}
			});
		});
		fn_previous_button_click(_page_url);
	};
	_init();
	_event_join();
};

const fn_modify_page_load = function(menuNm, pageNm, postEvent) {
	const _page_url = new URL(location.href).pathname + '/../';
	const _pkNm = $('input.pk')[0].name;
	const _pkTitle = $('.pk-title').text();
	let _org_pk_data = '';
	const _init = function() {
		fn_title_init(menuNm, pageNm, '수정');
		fn_pattern_event();

		_org_pk_data = new URL(location.href).searchParams.get($('input.pk')[0].name);
		$('input#pk').val(_org_pk_data);
		$('input.pk').val(_org_pk_data);
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
				$.each($('#modify [name]:not(#pk)'), function(idx, nameId) {
					if (!nameId.id) {
						return;
					}
					let thisData = result.data[nameId.id];
					if ('SELECT' == nameId.tagName) {
						$('#' + nameId.id).val(thisData).prop('selected', true);
						return;
					}
					$('#' + nameId.id).val(thisData);
				});
				if (postEvent) {
					$.each(postEvent, function(idx) {
						postEvent[idx]();
					});
					// 후처리 후 select변동 대응
					$.each($('#modify select[name]'), function(idx, nameId) {
						if (!nameId.id) {
							return;
						}
						let thisData = result.data[nameId.id];
						if (!thisData) {
							return;
						}
						if ('boolean' == typeof thisData) {
							thisData = thisData.toString().toUpperCase();
						}
						$('#' + nameId.id).val(thisData).prop('selected', true);
					});
				}
			},
			error: function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				alert(pageNm + ' 조회 실패');
			}
		});
	};

	const _event_join = function() {
		$('#modifyBtn').click(function() {
			let duplicate = false;
			if (_org_pk_data != $('input.pk').val()) {
				duplicate = fn_duplicate_check(_page_url, _pkNm);
			}
			if (duplicate) {
				alert('"' + _pkTitle + '"가(이) 중복되었습니다.');
				return;
			}

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
