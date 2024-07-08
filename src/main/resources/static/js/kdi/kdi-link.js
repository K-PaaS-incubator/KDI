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
			cols.order = cols.order || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = ['<span class="c-red fw-bold">\'연계 상태값 지정필요\'</span>'];
			}
			if ('' == cols.order) {
				cols.order = [{nm:'<span class="c-red fw-bold">\'정렬순서와 정렬방식 지정필요\'</span>',type:''}];
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
			var orderQry = '';
			$.each(cols.order, function() {
				if ('' == orderQry) {
					orderQry = '<br>ORDER BY<br>&nbsp;&nbsp;&nbsp;&nbsp;'
				} else {
					orderQry += ', '
				}
				orderQry += this.nm;
				orderQry += '&nbsp;';
				orderQry += this.type;
			});
			qry += orderQry;
			break;
		case 'W': // 조건문 임의 작성
			var cols = fn_get_col_data();
			cols.oper = cols.oper || '';
			cols.state = cols.state || '';
			cols.order = cols.order || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = '<span class="c-red ">\'연계 상태값 지정필요\'</span>';
			}
			if ('' == cols.order) {
				cols.order = [{nm:'<span class="c-red fw-bold">\'정렬순서와 정렬방식 지정필요\'</span>',type:''}];
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
			var orderQry = '';
			$.each(cols.order, function() {
				if ('' == orderQry) {
					orderQry = '<br>ORDER BY<br>&nbsp;&nbsp;&nbsp;&nbsp;'
				} else {
					orderQry += ', '
				}
				orderQry += this.nm;
				orderQry += '&nbsp;';
				orderQry += this.type;
			});
			qry += orderQry;
			break;
		case 'Q': // 임의 조회문 작성
			$('#flagTypeInputWhere').removeAttr('name');
			$('#flagTypeInputQuery').attr('name', 'flagQuery');
			qry = $('#flagTypeInputQuery').val();
			$('form select[name="colLnkType"],form input[name="colLnkYn"],form input[name="colOrderNum"],form select[name="colOrderType"]')
				.addClass('hide');
			break;
	}
	$('#queryResult').html(qry);
}

const orderTypeMap = { A: 'ASC', D: 'DESC' };
// 연계 여부가 체크된 컬럼명을 반환하는 기능
const fn_get_col_data = function() {
	// return value
	let cols_nm = [];
	let state_yn = [];
	let oper_cd = [];
	let order = [];

	// tmp value
	let col_nm;
	let colLnkType;
	let colLnkYn;
	let colNmMp;
	let orderNum;
	let orderType;
	$.each($('form tbody tr'), function() {
		col_nm = $(this).find('input[name="colName"]').val();
		colLnkType = $(this).find('select[name="colLnkType"]').val();
		colLnkYn = $(this).find('input[name="colLnkYn"]').val();
		colNmMp = $(this).find('input[name="colNmMp"]').val() || '';
		orderNum = $(this).find('input[name="colOrderNum"]').val() || '99';
		orderType = $(this).find('select[name="colOrderType"]').val() || 'NONE';

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
		if ('N' != orderType) {
			order.push({ nm: col_nm, order: orderNum, type: orderTypeMap[orderType] });
		}
	});
	order.sort(function(i, j) {
		return i.order - j.order;
	});
	return {
		nm: cols_nm,
		state: state_yn,
		oper: oper_cd,
		order: order
	};
}