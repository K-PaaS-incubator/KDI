const kdiData = function(){
	const _getAllDataSourceName = function() {
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
	}
	return {
		getAllDataSourceName : _getAllDataSourceName
	};
}