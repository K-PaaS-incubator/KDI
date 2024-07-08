// 조회쿼리를 생성하는 기능
const fn_make_lnk_qry = function() {
	let qry = '';
	$('form select[name="colLnkType"],form input[name="colLnkYn"]')
		.removeClass('hide');
	switch ($('input[name="flagType"]:checked').val()) {
		default:
		case 'S': // 상태값 기준 감지
			var cols = fn_get_col_data();
			cols.oper = cols.oper || '';
			cols.state = cols.state || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = ['<span class="c-red fw-bold">\'연계 상태값 지정필요\'</span>'];
			}
			qry = 'SELECT<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.oper
				+ ',<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.nm
				+ '<br>FROM<br>&nbsp;&nbsp;&nbsp;&nbsp;'
				+ $('input[name="schNm"]').val() + "."
				+ $('input[name="tblNm"]').val()
				+ '<br>WHERE<br>&nbsp;&nbsp;&nbsp;&nbsp;';
			var whereQry = '';
			$.each(cols.state, function() {
				if ('' != whereQry) {
					whereQry += ' AND '
				}
				whereQry += this;
				whereQry += ' = \'N\'';
			});
			qry += whereQry;
			break;
		case 'W': // 조건문 임의 작성
			var cols = fn_get_col_data();
			cols.oper = cols.oper || '';
			cols.state = cols.state || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = '<span class="c-red ">\'연계 상태값 지정필요\'</span>';
			}
			$('#flagTypeInputQuery').removeAttr('name');
			$('#flagTypeInputWhere').attr('name', 'flagQuery');
			qry = 'SELECT<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.oper
				+ ',<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.nm
				+ '<br>FROM<br>&nbsp;&nbsp;&nbsp;&nbsp;'
				+ $('input[name="schNm"]').val() + "."
				+ $('input[name="tblNm"]').val()
				+ '<br>WHERE<br>&nbsp;&nbsp;&nbsp;&nbsp;'
				+ $('#flagTypeInputWhere').val();
			break;
		case 'Q': // 임의 조회문 작성
			$('#flagTypeInputWhere').removeAttr('name');
			$('#flagTypeInputQuery').attr('name', 'flagQuery');
			qry = $('#flagTypeInputQuery').val();
			$('form select[name="colLnkType"],form input[name="colLnkYn"]')
				.addClass('hide');
			console.log(qry);
			break;
	}
	$('#queryResult').html(qry);
}

// 연계 여부가 체크된 컬럼명을 반환하는 기능
const fn_get_col_data = function() {
	// return value
	let cols_nm = [];
	let state_yn = [];
	let oper_cd = [];

	// tmp value
	let col_nm;
	let colLnkType;
	let colLnkYn;
	let colNmMp;
	$.each($('form tbody tr'), function() {
		col_nm = $(this).find('input[name="colName"]').val();
		colLnkType = $(this).find('select[name="colLnkType"]').val();
		colLnkYn = $(this).find('input[name="colLnkYn"]').val();
		colNmMp = $(this).find('input[name="colNmMp"]').val() || '';

		if ('Y' == colLnkYn) {
			if ('' == colNmMp) {
				cols_nm.push(col_nm);
			} else {
				cols_nm.push(col_nm + ' AS ' + colNmMp);
			}
		}
		if ('S' == colLnkType) {
			state_yn.push(col_nm);
		}
		if ('O' == colLnkType) {
			oper_cd.push(col_nm + ' AS LNK_OPER_CD');
		}
	});
	return {
		nm: cols_nm,
		state: state_yn,
		oper: oper_cd
	};
}