/**
 * 2024.04.27 양시열 KDI 데이터 조회 기능
 */

/**
 * 인터페이스명 출력
 */
const fn_get_if_nm = function(ifId) {
	let resultData = null;
	$.ajax({
		url: contextPath + 'res/in/get.json',
		data: 'ifId=' + encodeURIComponent(ifId),
		type: 'GET',
		async: false,
		dataType: 'json',
		success: function(result) {
			console.log(result);
			resultData = result.data.IF_NM;
		},
		error: function(result) {
			console.log('statusCode:' + result.statusCode);
			console.log('responseJSON:' + result.responseJSON.state);
			console.log('responseJSON:' + result.responseJSON.msg);
			alert('인터페이스명 조회 실패');
		}
	});
	return resultData;
};