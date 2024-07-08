/**
 * 2024.04.27 양시열 KDI용 그리드 작성 시작
 */

/**
 * 게시판 목록
 */
var KdiListGrid = function(varName, url) {
	var _varName = varName;
	var _isReady = 0;

	var _url = url || '';
	var _mapping = '';
	var _pagePerRow = 10;

	var _gridHtmlFormatId = '#gridHtmlFormatId';
	var _gridHtmlFormat = '';
	var _tableDataBodyId = '#gridTableDataBody';

	// loading
	var _gridLoadingHtmlFormatId = '#gridLoadingHtmlFormatId';
	var _gridLoadingHtmlFormat = '';

	// nodata
	var _gridNoDataHtmlFormatId = '#gridNoDataHtmlFormatId';
	var _gridNoDataHtmlFormat = '';

	var _seqId = '';

	// event
	var _event = {
		_postEvent: null,
		_errEvent: null
	};

	// 전체 건수 출력위치 ID
	var _totalCntId = '';
	// 현재 페이지 번호 출력위치 ID
	var _pageNumId = '';
	// 전체 페이지 수 출력위치 ID
	var _totalPageId = '';
	// 전체 페이지
	var _totalPage = 1;
	// 현제 페이지
	var _currentPage = 1;

	var _pageCtlZoneId = '';
	var _paginationNumFormat = '';
	var _pageNumCurrentClass = 'page-num-current';
	var _pageNumDisabledClass = 'page-num-disabled';
	var _pageCtlInfo = {
		_ctlFn: {
			_load: function(maxPageNumView) {
				var numZoneHtml = '';

				var startPage = ((Math.ceil(_currentPage / maxPageNumView) - 1) * maxPageNumView);

				var lastPage = 1;
				for (var i = startPage; i < startPage + maxPageNumView && i < _totalPage; i++) {
					var numZoneHtmlTmp = _paginationNumFormat;
					numZoneHtmlTmp = numZoneHtmlTmp.replaceAll('#PAGE_NO#', i + 1);
					numZoneHtml += numZoneHtmlTmp;
					lastPage = i + 1;
				}

				// 페이지 제어하는 번호 출력
				$(_pageCtlZoneId + ' .page-ctl-num-zone').html(numZoneHtml);
				// 현제페이지 표시
				$(_pageCtlZoneId + ' .page-' + _currentPage).addClass(_pageNumCurrentClass);

				this._first();
				this._prev(startPage);
				this._next(lastPage);
				this._last();
			},
			_first: function() {
				var _ctLId = _pageCtlZoneId + ' .firstCtl';
				if (1 < _currentPage) {
					$(_ctLId).removeClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', 'javascript:' + _varName + '.search(1)');

				} else {
					$(_ctLId).addClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', '#');
				}
			},
			_prev: function(startPage) {
				var _ctLId = _pageCtlZoneId + ' .prevCtl';
				if (1 < _currentPage) {
					$(_ctLId).removeClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', 'javascript:' + _varName + '.search(' + (0 == startPage ? 1 : startPage) + ')');
				} else {
					$(_ctLId).addClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', '#');
				}
			},
			_next: function(lastPage) {
				var _ctLId = _pageCtlZoneId + ' .nextCtl';
				if (_currentPage < _totalPage || lastPage < _totalPage) {
					$(_ctLId).removeClass(_pageNumDisabledClass);
					if (lastPage < _totalPage) {
						lastPage++;
					}
					$(_ctLId).attr('href', 'javascript:' + _varName + '.search(' + (lastPage) + ')');
				} else {
					$(_ctLId).addClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', '#');
				}
			},
			_last: function() {
				var _ctLId = _pageCtlZoneId + ' .lastCtl';
				if (_currentPage < _totalPage) {
					$(_ctLId).removeClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', 'javascript:' + _varName + '.search(' + _totalPage + ')');
				} else {
					$(_ctLId).addClass(_pageNumDisabledClass);
					$(_ctLId).attr('href', '#');
				}
			}
		}
	}

	// 환경설정 
	var env = {
		setUrl: function(url) {
			_url = url;
		},
		setMapping: function(mapping) {
			_mapping = mapping;
		},
		setPagePerRow: function(pagePerRow) {
			_pagePerRow = pagePerRow || 10;
			if ('number' != typeof _pagePerRow) {
				_pagePerRow = parseInt(_pagePerRow);
			}
			if (0 >= _pagePerRow) {
				_pagePerRow = 10;
			}
			_paramData['pagePerRow'] = _pagePerRow;
		},

		setGridHtmlFormatId: function(gridHtmlFormatId) {
			gridHtmlFormatId = gridHtmlFormatId.replaceAll(/[^\w\s]/g, '\\\$&');
			_gridHtmlFormatId = gridHtmlFormatId;
		},

		setTableDataBodyId: function(tableDataBodyId) {
			tableDataBodyId = tableDataBodyId.replaceAll(/[^\w\s]/g, '\\\$&');
			_tableDataBodyId = tableDataBodyId
		},

		loadGridHtmlFormat: function() {
			_gridHtmlFormat = $(_gridHtmlFormatId).html();
		},

		loading: {
			setGridLoadingHtmlFormatId: function(gridLoadingHtmlFormatId) {
				_gridLoadingHtmlFormatId = gridLoadingHtmlFormatId;
				enable();
			},
			enable: function() {
				_gridLoadingHtmlFormat = $(_gridLoadingHtmlFormatId).html();
			},
			disable: function() {
				_gridLoadingHtmlFormat = '';
			}
		},

		nodata: {
			setGridNoDataHtmlFormatId: function(gridNoDataHtmlFormatId) {
				_gridNoDataHtmlFormatId = gridNoDataHtmlFormatId;
				enable();
			},
			enable: function() {
				_gridNoDataHtmlFormat = $(_gridNoDataHtmlFormatId).html();
			},
			disable: function() {
				_gridNoDataHtmlFormat = '';
			}
		},

		seq: {
			enable: function(noId) {
				_seqId = noId || '';
				if ('' == _seqId) {
					throw new Error('noId가 정의되지 않았습니다.');
				}
			},
			disable: function() {
				_seqId = '';
			}
		},

		setTotalCntId: function(totalCntId) {
			totalCntId = totalCntId || '';
			_totalCntId = totalCntId;
		},

		setPageNumInfo: function(currentPageNumId, totalPageId) {
			currentPageNumId = currentPageNumId || '';
			totalPageId = totalPageId || '';
			_pageNumId = currentPageNumId;
			_totalPageId = totalPageId;
		},

		setPageCtlInfo: function(pageCtlZoneId) {
			_pageCtlZoneId = pageCtlZoneId || '',
				$(pageCtlZoneId).load(contextPath + 'html/kdi/pagination-num.html .page-ctl-zone', function() {
					_paginationNumFormat = $(pageCtlZoneId + ' .page-ctl-num-zone').html();
					_paginationNumFormat = _paginationNumFormat.replaceAll('#VAR_NAME#', varName);
					var pageZoneFormat = $(pageCtlZoneId).html();
					pageZoneFormat = pageZoneFormat.replaceAll('#VAR_NAME#', varName);
					pageZoneFormat = pageZoneFormat.replaceAll('#PAGE_NO#', '1');
					$(pageCtlZoneId).html(pageZoneFormat);
					$(pageCtlZoneId + ' .page-1').addClass(_pageNumCurrentClass);
				});
		}
	};

	var event = {
		/** 데이터 불러온 다음 호출할 이벤트 */
		setPostEvent: function(eventFn) {
			_event._postEvent = eventFn;
		},
		/** 데이터 불러온 결과 에러발생시 호출할 이벤트 */
		setErrEvent: function(eventFn) {
			_event._errEvent = eventFn;
		}
	}

	var ready = function() {
		if ('' == _url) {
			throw new Error('url정보가 정의되지 않았습니다. env.setUrl 함수를 호출하여 정의하세요.');
		}
		if ('' == _mapping) {
			throw new Error('MappingData가 초기화되지 않았습니다. env.setMapping 함수를 호출하여 정의하세요.');
		}
		env.loadGridHtmlFormat();
		_isReady = 1;
	};
	var _paramData = {};
	var search = function(page, paramData) {
		if (0 == _isReady) {
			throw new Error('KdiListGrid를 사용할 준비가 되지 않았습니다. ready 함수를 호출하여 준비하세요.');
		}
		if (paramData) {
			_paramData = paramData;
			_paramData['pagePerRow'] = _pagePerRow;
		}
		page = page || 1;
		if ('number' != typeof page) {
			page = parseInt(page);
		}
		if (0 >= page) {
			page = 1;
		}
		_paramData['pageNum'] = page;

		$.ajax({
			url: _url,
			type: 'GET',
			dataType: 'JSON',
			data: _paramData,
			contentType: "application/json",
			beforeSend: function() {
				if ('' != _gridLoadingHtmlFormat) {
					$(_tableDataBodyId).html(_gridLoadingHtmlFormat);
				}
			},
			success: function(result) {
				var dataHtml = '';
				if (0 == result.data.length) {
					if ('' != _gridNoDataHtmlFormat) {
						dataHtml = _gridNoDataHtmlFormat;
					}
				} else {
					for (var i = 0; i < result.data.length; i++) {
						// row 데이터 가져오기
						var rowData = result.data[i];
						// rowHtml내용은 tableDataHtml포멧에서 가져옴
						var rowHtml = _gridHtmlFormat;
						// 컬럼 단위로 값을 변경하는 행위
						if ('' != _seqId) {
							rowHtml = rowHtml.replaceAll(_seqId, ((page - 1) * _pagePerRow) + (i + 1));
						}

						for (var mappingKey in _mapping) {
							var dataKey = _mapping[mappingKey];
							rowHtml = rowHtml.replaceAll(mappingKey, rowData[dataKey] || '');
						}
						// 완성된 rowHtml을 tmp에 담는 행위
						dataHtml += rowHtml;
					}
				}
				$(_tableDataBodyId).html(dataHtml);

				{
					// PageNumInfo
					var _pageInfo = result.page;
					// 전체건수
					if ('' != _totalCntId) {
						$(_totalCntId).html(_pageInfo.total);
					}

					// 현재페이지
					if ('' != _pageNumId) {
						_currentPage = _pageInfo.pageNum;
						$(_pageNumId).html(_pageInfo.pageNum);
					}

					// 전체페이지
					if ('' != _totalPageId) {
						if ('number' != typeof _pageInfo.pagePerRow) {
							_pageInfo.pagePerRow = parseInt(_pageInfo.pagePerRow);
						}
						if(0 < _pageInfo.total) {
							_totalPage = Math.ceil(_pageInfo.total / _pageInfo.pagePerRow);
						} else {
							_totalPage = 1;
						}
						$(_totalPageId).html(_totalPage);
					}
					// PageCtlInfo
					_pageCtlInfo._ctlFn._load(_pageInfo.maxPageNumView);
				}
				if (_event._postEvent) {
					_event._postEvent(result);
				}
			},
			error: _event._errEvent
		});
	};
	return {
		env,
		event,
		ready,
		search
	};
};