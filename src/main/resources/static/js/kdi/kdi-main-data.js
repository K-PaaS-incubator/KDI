const KdiData = function() {
	const _fn_get_svc_info = function(svcId) {
		let _svcId = encodeURIComponent(svcId);
		let data;
		$.ajax({
			url: contextPath + 'res/link/get.json',
			type: 'GET',
			data: {
				svcId: _svcId
			},
			async: false,
			dataType: 'json',
			success: function(result) {
				data = result.data;
			},
			error: function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
			}
		});
		return data;
	};
	const _fn_get_all_data_source_name = function() {
		let data;
		$.ajax({
			url: contextPath + 'res/ds/get_all_ds_nm.json',
			type: 'GET',
			dataType: 'json',
			async: false,
			success: function(result) {
				data = result.data;
			},
			error: function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				$('#test_result').text('접속 테스트 실패');
				$('#test_result2').text(result.responseJSON.msg);
			}
		});
		return data;
	};
	return {
		getSvcInfo : _fn_get_svc_info,
		getAllDataSourceName: _fn_get_all_data_source_name
	};
};